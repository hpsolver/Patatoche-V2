
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../services/fetch_data_exception.dart';
import 'base_provider.dart';

class SelectPhotoVideoProvider extends BaseProvider{

  Future<void> pickImagesWithLimit(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(limit: 2);

    if (images.isNotEmpty) {
      print('${images.length} images selected.');
      var image = images[0];
      getUploadUrl(context,File(image.path));
      // Process the images
    } else {
      print('No images selected');
    }
  }

  Future<void> getUploadUrl(BuildContext context, File file) async {
    try {


      var model = await api.getUploadUrl(fileName: 'photo.jpg', fileType: 'image/jpeg');

      if (model?.success == true) {
        api.uploadFile(file,model!);

      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
    }
  }

}
