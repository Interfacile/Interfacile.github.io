import 'package:dotspot_beta_web/model/image.dart';
import 'package:dotspot_common/settings.dart';
import 'package:file_picker/file_picker.dart';

Future<LocalImage?> getImage() async {
  FilePickerResult? result = await FilePicker.platform .pickFiles(type: FileType.custom, allowedExtensions: Settings.allowedImageExtensions, allowMultiple: false);
  if (result != null) {
    return LocalImage(DateTime.now().millisecondsSinceEpoch.toString() + "." + result.files.single.extension!, result.files.single.bytes!);
  } else {
    return null;
  }
}