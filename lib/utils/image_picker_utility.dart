import 'package:image_picker/image_picker.dart';

class ImagePickerUtility {
  static XFile? _pickedImage;
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<XFile?> pickImageFromGallery() async {
    _pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    return _pickedImage;
  }
}
