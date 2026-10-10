# Verify and stage one immutable signed Portage image; never write a live root.
import hashlib,json,os,stat,sys,tempfile,shutil,subprocess
from pathlib import Path
import portage,portage.gpkg
archive,ledger,destination,temporary=map(Path,sys.argv[1:])
assert archive.stat().st_size==62392320
assert hashlib.sha256(archive.read_bytes()).hexdigest()=="cc5fd4e7ea7a4e6bca40eeb0da7b12767997728509a860c32be6a8b793dc436f"
assert hashlib.sha256(ledger.read_bytes()).hexdigest()=="cba2ab6086c1b48dfb2b2c9e1fc2bdf4673ce3da8a537c0eb10c4ad2215c9b3e"
assert destination.is_absolute() and destination!=Path("/")
assert not destination.exists() or not any(destination.iterdir())
# Only trusted public verification material enters the sandbox-writable home.
# GPG may create random_seed there; the system keyring and secrets stay untouched.
home=Path(tempfile.mkdtemp(prefix="r28-public-gpg-",dir=temporary))
home.chmod(0o700)
for name in ("pubring.kbx","trustdb.gpg"):
 shutil.copyfile(Path("/etc/portage/gnupg")/name,home/name)
# R28 was signed on the laptop; import only its pinned public verification key.
key=ledger.with_name("qindaqt-r28-signing-key.asc")
assert hashlib.sha256(key.read_bytes()).hexdigest()=="bb6f433c1643aab09bd9fff0d74602ac7b2fa1cbcb6cadb990d41fc425fd134f"
subprocess.run(["/usr/bin/gpg","--batch","--no-autostart","--homedir",str(home),"--import",str(key)],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
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
assert hashlib.sha256(recipes[0]).hexdigest()=="470c8a246e7f3c9c3a197fa28e1659dd44fb5c760ca56caa08f7ddfb77942f46"
assert b'QINDAQT_COMMIT="a9c9768f46d05b3512ab4dd32e267412e994a083"' in recipes[0]
assert metadata["PF"].strip()==b"qindaqt-desktop-0.1.0_pre20261002-r28"
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
print("verified-signed-r28-image source=a9c9768f paths="+str(len(actual)),flush=True)
