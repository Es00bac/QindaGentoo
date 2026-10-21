# Verify and stage one immutable signed Portage image; never write a live root.
import hashlib,json,os,stat,sys,tempfile,shutil,subprocess
from pathlib import Path
import portage,portage.gpkg
archive,ledger,destination,temporary=map(Path,sys.argv[1:])
assert archive.stat().st_size==87296000
assert hashlib.sha256(archive.read_bytes()).hexdigest()=="2edd3ee9a80a18b5c9a88b7101fc1d3132f09a47aa08eb3e6af39c19ff4f0f96"
assert hashlib.sha256(ledger.read_bytes()).hexdigest()=="1e299664dca61d64c5aa801c5b5c831e9e1a6777c2bcbaacaef3d43a6f92c8a5"
assert destination.is_absolute() and destination!=Path("/")
assert not destination.exists() or not any(destination.iterdir())
# Only trusted public verification material enters the sandbox-writable home.
# GPG may create random_seed there; the system keyring and secrets stay untouched.
home=Path(tempfile.mkdtemp(prefix="r39-public-gpg-",dir=temporary))
home.chmod(0o700)
# Only this SHA-pinned qinda PUBLIC certificate can verify the fixed R39 input.
# Dearmor writes a public keyring directly, without spawning a signing agent.
key=ledger.with_name("qindaqt-r31-signing-key.asc")
assert hashlib.sha256(key.read_bytes()).hexdigest()=="e248391c2c3fe22968fa0758430cd7730476140aa4faee028e33d52562af892c"
subprocess.run(["/usr/bin/gpg","--batch","--no-autostart","--yes","--dearmor","--output",str(home/"pubring.gpg"),str(key)],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
# Trust only the SHA-pinned certificate in this disposable verification ring.
subprocess.run(["/usr/bin/gpg","--batch","--no-autostart","--homedir",str(home),"--import-ownertrust"],input=b"D1D453A84F0C34DCE86E5B23A8EDE14F4FDA54D2:6:\n",check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
subprocess.run(["/usr/bin/gpg","--batch","--no-autostart","--homedir",str(home),"--check-trustdb"],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
settings=portage.config()
settings["BINPKG_GPG_VERIFY_GPG_HOME"]=str(home)
# This exact SHA/Manifest-pinned signed input is verified as the ebuild user.
# Nobody cannot traverse Portage's private T; sandbox and signatures remain on.
settings["GPG_VERIFY_USER_DROP"]=""
settings["GPG_VERIFY_GROUP_DROP"]=""
settings.features.discard("binpkg-ignore-signature")
settings.features.add("binpkg-request-signature")
pkg=portage.gpkg.gpkg(settings,gpkg_file=str(archive),verify_signature=True)
metadata=pkg.get_metadata()
recipes=[v for k,v in metadata.items() if k.endswith(".ebuild")]
assert len(recipes)==1
assert hashlib.sha256(recipes[0]).hexdigest()=="891ea590c5632f7994529fd30ad8e365995312ec7299f46ca646efb534796268"
assert b'QINDAQT_COMMIT="d4c85a4b5e5fd9c47ec1808b213c3549b9207e2c"' in recipes[0]
assert metadata["PF"].strip()==b"qindaqt-desktop-0.1.0_pre20261002-r39"
pkg.decompress(str(destination))
assert pkg.signature_exist is True
actual=[]
for p in sorted(destination.rglob("*")):
 st=p.lstat(); item={"path":str(p.relative_to(destination)),"mode":oct(stat.S_IMODE(st.st_mode))}
 if stat.S_ISLNK(st.st_mode): item.update(kind="symlink",target=os.readlink(p))
 elif stat.S_ISDIR(st.st_mode): item["kind"]="directory"
 elif stat.S_ISREG(st.st_mode): item.update(kind="file",bytes=st.st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
 else: raise AssertionError("Unexpected image file type")
 actual.append(item)
assert actual==json.loads(ledger.read_text())["items"]
print("verified-signed-r39-image source=d4c85a4b paths="+str(len(actual)),flush=True)
