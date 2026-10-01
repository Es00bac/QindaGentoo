"""PF25 policy and graph-boundary regression fixtures; no host mutation."""
import contextlib
import importlib.machinery
import importlib.util
import io
import json
import os
import subprocess
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

TOOL = Path(__file__).resolve().parents[1] / "tools/check-plasma-dependencies"
loader = importlib.machinery.SourceFileLoader("plasma_guard", str(TOOL))
spec = importlib.util.spec_from_loader(loader.name, loader)
guard = importlib.util.module_from_spec(spec)
loader.exec_module(guard)
DESKTOP = "gui-wm/qindaqt-desktop-0.1.0_pre20261001"
FORK = "gui-wm/qindaqt-kwin-6.6.6_p2"
SHARED = "kde-plasma/kwayland-6.6.6"
LAYER = "kde-plasma/layer-shell-qt-6.6.6"
PLASMA = "kde-plasma/plasma-workspace-6.6.6"
HELPER = "sys-apps/runtime-helper-1.0"


def fixture():
    return {"schemaVersion": 1, "roots": [DESKTOP, FORK],
            "nodes": {DESKTOP: [FORK, LAYER], FORK: [SHARED], SHARED: [], LAYER: []}}


class PolicyTests(unittest.TestCase):
    def test_shared_libraries_pass(self):
        self.assertEqual(guard.forbidden_paths(fixture()), ([], 4))

    def test_direct_forbidden_reports_chain(self):
        graph = fixture()
        graph["nodes"][DESKTOP].append(PLASMA)
        graph["nodes"][PLASMA] = []
        self.assertEqual(guard.forbidden_paths(graph)[0], [[DESKTOP, PLASMA]])

    def test_transitive_dependency_crosses_allowed_library(self):
        graph = fixture()
        graph["nodes"][SHARED] = [HELPER]
        graph["nodes"][HELPER] = [PLASMA]
        graph["nodes"][PLASMA] = []
        self.assertEqual(guard.forbidden_paths(graph)[0], [[FORK, SHARED, HELPER, PLASMA]])

    def test_unrelated_installed_plasma_is_not_in_closure(self):
        graph = fixture()
        graph["nodes"][PLASMA] = []
        self.assertEqual(guard.forbidden_paths(graph), ([], 4))

    def test_allowlist_is_exact_package_not_prefix(self):
        graph = fixture()
        fake = "kde-plasma/kwayland-extra-1.0"
        graph["nodes"][FORK].append(fake)
        graph["nodes"][fake] = []
        self.assertEqual(guard.forbidden_paths(graph)[0], [[FORK, fake]])

    def test_cycles_terminate_without_hiding_violation(self):
        graph = fixture()
        graph["nodes"][FORK] += [PLASMA]
        graph["nodes"][PLASMA] = [FORK]
        self.assertEqual(guard.forbidden_paths(graph)[0], [[FORK, PLASMA]])

    def test_two_forbidden_packages_report_both(self):
        graph = fixture()
        other = "kde-plasma/powerdevil-6.6.6-r1"
        graph["nodes"][PLASMA] = [other]
        graph["nodes"][other] = []
        graph["nodes"][FORK].append(PLASMA)
        self.assertEqual(len(guard.forbidden_paths(graph)[0]), 2)


class BoundaryTests(unittest.TestCase):
    def assert_invalid(self, mutation):
        graph = fixture()
        mutation(graph)
        with self.assertRaises(guard.GraphError):
            guard.validate_graph(graph)

    def test_missing_and_unsupported_schema(self):
        for bad in ({}, [], {"schemaVersion": 2, "roots": [], "nodes": {}},
                    {"schemaVersion": True, "roots": [], "nodes": {}}):
            with self.subTest(bad=bad), self.assertRaises(guard.GraphError):
                guard.validate_graph(bad)

    def test_empty_roots(self):
        self.assert_invalid(lambda g: g.update(roots=[]))

    def test_unavailable_root(self):
        self.assert_invalid(lambda g: g["nodes"].pop(FORK))

    def test_unresolved_transitive_edge(self):
        self.assert_invalid(lambda g: g["nodes"][SHARED].append(PLASMA))

    def test_malformed_edges(self):
        for bad in (None, "dependency", [None], [[PLASMA]]):
            self.assert_invalid(lambda g: g["nodes"].update({SHARED: bad}))

    def test_malformed_root_types(self):
        self.assert_invalid(lambda g: g.update(roots=[[]]))

    def test_duplicate_roots_and_edges(self):
        self.assert_invalid(lambda g: g["roots"].append(FORK))
        self.assert_invalid(lambda g: g["nodes"][FORK].append(SHARED))

    def test_unknown_root_and_invalid_cpv(self):
        for cpv in ("=gui-wm/qindaqt-kwin-6.6.6_p2", "gui-wm/qindaqt-kwin",
                    "gui-wm/qindaqt-kwin-1_bad", "kde-plasma/kwin-6.6.6"):
            self.assert_invalid(lambda g: g["roots"].append(cpv))

    def test_exact_candidate_roots_required(self):
        for atoms in ([], ["=" + DESKTOP], ["gui-wm/qindaqt-desktop"],
                      ["=" + DESKTOP, "=" + DESKTOP], ["=" + DESKTOP, "=gui-wm/qindaqt-kwin-6.6.6*"]):
            with self.subTest(atoms=atoms), self.assertRaises(guard.GraphError):
                guard.exact_roots(atoms)
        self.assertEqual(guard.exact_roots(["=" + DESKTOP, "=" + FORK]), [DESKTOP, FORK])

    def test_single_root_allowed_only_for_installed_diagnostic(self):
        self.assertEqual(guard.exact_roots(["=" + DESKTOP], diagnostic=True), [DESKTOP])

    def test_duplicate_json_key_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "graph.json"
            path.write_text('{"schemaVersion":1,"schemaVersion":1,"roots":[],"nodes":{}}')
            with self.assertRaises(guard.GraphError):
                guard.read_graph(path)


class ResolverEdgeTests(unittest.TestCase):
    class Node:
        def __init__(self, cpv, installed=True):
            self.cpv, self.installed, self.root = cpv, installed, "/"

    class Priority:
        def __init__(self, runtime=False, post=False, slot=False):
            self.runtime, self.runtime_post, self.runtime_slot_op = runtime, post, slot

    class Graph:
        def __init__(self, edges):
            self.nodes = {parent: ({child: priorities for child, priorities in children}, {}, parent)
                          for parent, children in edges.items()}

        def child_nodes(self, node):
            return list(self.nodes[node][0])

    def extract(self, edges, roots):
        return guard.runtime_graph(self.Graph(edges), roots, self.Node, "/", True)

    def test_pdepend_included_build_only_excluded(self):
        root = self.Node(DESKTOP)
        post, build = self.Node(HELPER), self.Node(PLASMA)
        graph = self.extract({root: [(post, [self.Priority(post=True)]),
                                     (build, [self.Priority()])], post: [], build: []}, [root])
        self.assertEqual(graph["nodes"], {DESKTOP: [HELPER], HELPER: []})

    def test_slot_runtime_edge_included(self):
        root, dep = self.Node(FORK), self.Node(SHARED)
        graph = self.extract({root: [(dep, [self.Priority(slot=True)])], dep: []}, [root])
        self.assertEqual(graph["nodes"][FORK], [SHARED])

    def test_noninstalled_runtime_target_fails_diagnostic(self):
        root, dep = self.Node(DESKTOP), self.Node(HELPER, installed=False)
        with self.assertRaises(guard.GraphError):
            self.extract({root: [(dep, [self.Priority(runtime=True)])], dep: []}, [root])

    def test_unrecognized_priority_and_target_fail_closed(self):
        root, dep = self.Node(DESKTOP), self.Node(HELPER)
        with self.assertRaises(guard.GraphError):
            self.extract({root: [(dep, [object()])], dep: []}, [root])
        with self.assertRaises(guard.GraphError):
            self.extract({root: [("not-package", [self.Priority(runtime=True)])]}, [root])

    def test_duplicate_cpv_identity_fails_closed(self):
        root = self.Node(DESKTOP)
        first, second = self.Node(HELPER), self.Node(HELPER)
        with self.assertRaises(guard.GraphError):
            self.extract({root: [(first, [self.Priority(runtime=True)]),
                                 (second, [self.Priority(post=True)])], first: [], second: []}, [root])


class PortageIntegrationTests(unittest.TestCase):
    """Real resolver against disposable recipes/config/root; no merge is invoked."""
    def resolve_fixture(self, forbidden=False, missing_root=False):
        try:
            import portage
        except ImportError:
            self.skipTest("Portage is unavailable")
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)
            repo, config, target = path / "repo", path / "config", path / "root"
            for entry in (repo / "profiles/default", repo / "metadata", config / "etc/portage",
                          target, path / "tmp", path / "cache", path / "dist", path / "packages"):
                entry.mkdir(parents=True)
            (repo / "profiles/repo_name").write_text("pf25-fixture\n")
            (repo / "profiles/categories").write_text("gui-wm\nkde-plasma\nsys-apps\n")
            (repo / "profiles/default/eapi").write_text("8\n")
            (repo / "profiles/default/make.defaults").write_text('ARCH="amd64"\n')
            (repo / "metadata/layout.conf").write_text("masters =\nthin-manifests = true\n")
            (config / "etc/portage/make.profile").symlink_to(repo / "profiles/default")
            (config / "etc/portage/repos.conf").write_text(
                "[DEFAULT]\nmain-repo = pf25-fixture\n[pf25-fixture]\nlocation = " + str(repo) + "\n")
            (config / "etc/portage/make.conf").write_text(
                'ACCEPT_KEYWORDS="amd64"\nACCEPT_LICENSE="*"\nCHOST="x86_64-pc-linux-gnu"\n'
                'FEATURES="-news -sync-rcu"\n')
            recipes = {
                "gui-wm/qindaqt-desktop": ("gui-wm/qindaqt-kwin", "", "kde-plasma/powerdevil"),
                "gui-wm/qindaqt-kwin": ("|| ( kde-plasma/kwayland kde-plasma/libplasma )", "", ""),
                "kde-plasma/kwayland": ("", "sys-apps/helper" if forbidden else "", ""),
                "sys-apps/helper": ("kde-plasma/plasma-workspace", "", ""),
                "kde-plasma/plasma-workspace": ("", "", ""),
                "kde-plasma/libplasma": ("", "", ""),
                "kde-plasma/powerdevil": ("", "", ""),
            }
            if missing_root:
                recipes.pop("gui-wm/qindaqt-kwin")
            for cp, (runtime, post, build) in recipes.items():
                package_dir = repo / cp
                package_dir.mkdir(parents=True)
                name = cp.split("/")[1]
                (package_dir / (name + "-1.0.ebuild")).write_text(
                    'EAPI=8\nDESCRIPTION="fixture"\nHOMEPAGE="https://example.org"\nLICENSE="MIT"\n'
                    'SLOT="0"\nKEYWORDS="amd64"\n'
                    f'RDEPEND="{runtime}"\nPDEPEND="{post}"\nDEPEND="{build}"\n')
            environment = dict(os.environ, PORTAGE_CONFIGROOT=str(config), ROOT=str(target), SYSROOT=str(target),
                               PORTAGE_TMPDIR=str(path / "tmp"), PORTAGE_DEPCACHEDIR=str(path / "cache"),
                               DISTDIR=str(path / "dist"), PKGDIR=str(path / "packages"),
                               PYTHONDONTWRITEBYTECODE="1")
            for name in ("EPREFIX", "PORTAGE_BINHOST"):
                environment.pop(name, None)
            environment["PORTAGE_REPOSITORIES"] = (config / "etc/portage/repos.conf").read_text()
            before = (config / "etc/portage/make.conf").read_bytes()
            result = subprocess.run(
                [str(TOOL), "--resolve", "--root", "=gui-wm/qindaqt-desktop-1.0",
                 "--root", "=gui-wm/qindaqt-kwin-1.0"], env=environment, text=True,
                capture_output=True, timeout=60)
            self.assertEqual((config / "etc/portage/make.conf").read_bytes(), before)
            self.assertFalse(list(target.rglob("CONTENTS")))
            self.assertFalse((target / "var/lib/portage/world").exists())
            return result

    def test_actual_resolver_selects_allowed_alternative_and_ignores_build_only(self):
        result = self.resolve_fixture()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("3 packages; 0 forbidden", result.stdout)

    def test_actual_resolver_follows_transitive_pdepend(self):
        result = self.resolve_fixture(forbidden=True)
        self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
        self.assertIn("kde-plasma/kwayland-1.0 -> sys-apps/helper-1.0 -> kde-plasma/plasma-workspace-1.0",
                      result.stdout)

    def test_actual_resolver_missing_fork_fails_closed(self):
        result = self.resolve_fixture(missing_root=True)
        self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
        self.assertIn("unavailable candidate root", result.stderr)


class CliTests(unittest.TestCase):
    def invoke(self, graph):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "graph.json"
            path.write_text(json.dumps(graph))
            with contextlib.redirect_stdout(io.StringIO()) as out, contextlib.redirect_stderr(io.StringIO()) as err:
                status = guard.main(["--graph", str(path)])
            return status, out.getvalue(), err.getvalue()

    def test_pass_fail_and_invalid_exit_statuses(self):
        self.assertEqual(self.invoke(fixture())[0], 0)
        graph = fixture()
        graph["nodes"][FORK].append(PLASMA)
        graph["nodes"][PLASMA] = []
        status, out, _ = self.invoke(graph)
        self.assertEqual(status, 1)
        self.assertIn(FORK + " -> " + PLASMA, out)
        self.assertIn("not Portage resolution evidence", out)
        graph["nodes"].pop(PLASMA)
        self.assertEqual(self.invoke(graph)[0], 2)

    def test_portage_failure_never_becomes_empty_pass(self):
        with patch.object(guard, "portage_graph", side_effect=RuntimeError("resolver unavailable")):
            with contextlib.redirect_stderr(io.StringIO()) as err:
                self.assertEqual(guard.main(["--resolve", "--root", "=" + DESKTOP,
                                             "--root", "=" + FORK]), 2)
            self.assertIn("resolver unavailable", err.getvalue())


if __name__ == "__main__":
    unittest.main()
