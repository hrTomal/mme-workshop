import 'package:file_picker/file_picker.dart';

class LocalFilePicker {
  Future<List<String>?> MultipleFilesPick() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<String> fileNames = [];

      for (var file in result.files) {
        fileNames.add(file.path!);
      }

      return fileNames;
    } else {
      return null;
    }
  }
}
