# Verify and stage one immutable signed Portage image; never write a live root.
import hashlib,json,os,stat,sys
from pathlib import Path
import portage,portage.gpkg
archive,ledger,destination=map(Path,sys.argv[1:])
assert archive.stat().st_size==62279680
assert hashlib.sha256(archive.read_bytes()).hexdigest()=="5e04a27ec93abec2ed2ec1b2a4c42e97b05b1d72ca6c4c7942aa51d47f050b51"
assert hashlib.sha256(ledger.read_bytes()).hexdigest()=="39d651d641783e5dec824abd9a6a118e62a24bca08ae63e449201cc3b7c72fb3"
assert destination.is_absolute() and destination!=Path("/")
assert not destination.exists() or not any(destination.iterdir())
settings=portage.config()
settings.features.discard("binpkg-ignore-signature")
settings.features.add("binpkg-request-signature")
pkg=portage.gpkg.gpkg(settings,gpkg_file=str(archive),verify_signature=True)
metadata=pkg.get_metadata()
recipes=[v for k,v in metadata.items() if k.endswith(".ebuild")]
assert len(recipes)==1
assert hashlib.sha256(recipes[0]).hexdigest()=="6edd28f825e36b3d41e350147b3369b2c92af5554e01303389ed85a87fc658f9"
assert b'QINDAQT_COMMIT="1a5359e4894700a00b545e80e624e3b3a12952be"' in recipes[0]
assert metadata["PF"].strip()==b"qindaqt-desktop-0.1.0_pre20261002-r23"
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
print("verified-signed-r23-image source=1a5359e paths="+str(len(actual)),flush=True)
