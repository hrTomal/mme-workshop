import 'package:file_picker/file_picker.dart';

class LocalFilePicker {
  Future<List<String>?> MultipleFilesPick() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<String> filePaths = [];

      for (var file in result.files) {
        filePaths.add(file.path!);
      }

      return filePaths;
    } else {
      return null;
    }
  }
}
