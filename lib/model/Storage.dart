import 'package:firebase/firebase.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

imagePicker({required String uid}) {
  return ImagePickerWeb.getImageInfo.then((MediaInfo mediaInfo) {
    uploadFile(mediaInfo, uid, mediaInfo.fileName);
  });
}
uploadFile(MediaInfo mediaInfo, String ref, String? fileName) {
  try {
    String? mimeType = mime(basename(mediaInfo.fileName!));
    var metaData = UploadMetadata(contentType: mimeType);
    StorageReference storageReference = storage().ref(ref).child(fileName!);

    UploadTask uploadTask = storageReference.put(mediaInfo.data, metaData);
    var imageUri;
    uploadTask.future.then((snapshot) => {
      Future.delayed(Duration(seconds: 1)).then((value) => {
        snapshot.ref.getDownloadURL().then((dynamic uri) {
          imageUri = uri;
          print('Download URL: ${imageUri.toString()}');
        })
      })
    });


  } catch (e) {
    print('File Upload Error: $e');
  }
}
