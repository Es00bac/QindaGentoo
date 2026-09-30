# Pinned model and test-source provenance

Model: OpenCV Zoo commit 47534e27c9851bb1128ccc0102f1145e27f23f98,
face_detection_yunet_2023mar.onnx, 232589 bytes,
SHA256 8f2383e4dd3cfbb4553ea8718107fc0423210dc964f9f4280604804ed2552fa4.
The [pinned upstream README](https://github.com/opencv/opencv_zoo/blob/47534e27c9851bb1128ccc0102f1145e27f23f98/models/face_detection_yunet/README.md)
licenses every file in that directory under MIT. The matching full LICENSE is
fetched by Portage and installed as MODEL-LICENSE; copyright 2020 Shiqi Yu.
The upstream source checkpoint is libfacedetection.train a61a428929148171b488f024b5d6774f93cdbc13.

Optional test-fixtures are NASA photographs, fetched and hash-pinned by Portage:
[portrait KSC-99pp0310](https://images.nasa.gov/details/KSC-99pp0310), official
portrait of Eileen Collins, and [crew KSC-04pd1239](https://images.nasa.gov/details/KSC-04pd1239),
STS-114 crew portrait. Original source: NASA Kennedy/Johnson Space Centers;
credit NASA. These contain real human faces, not fabricated detector outputs.
The small official rendition URLs are pinned by this version's Manifest; an
upstream byte change requires a version/revision bump, never replacement hashes.

[NASA media policy](https://www.nasa.gov/nasa-brand-center/images-and-media/)
permits factual educational/informational use and requires source acknowledgement;
NASA-authored content generally is not subject to US copyright. These images are
solely numerical/software test fixtures, not advertisements, product packaging,
training data or an endorsement. The NASA attribution describes the source;
landmark/deformation output belongs to this software and is not a NASA statement.
The original photographs remain intact. Runtime tests may construct a two-portrait
contact image in memory; any transformed output must be labelled as a test edit.
No model or image is downloaded at application runtime.
