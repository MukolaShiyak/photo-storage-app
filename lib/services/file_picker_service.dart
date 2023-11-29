import 'package:file_picker/file_picker.dart';
import 'package:photo_uploader/services/Ifile_picker_service.dart';

class FilePickerService extends IFilePickerService {
  @override
  Future<FilePickerResult?> pickMultiFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );

    return result;
  }

  @override
  Future<bool?> clearTemporaryFiles() async =>
      await FilePicker.platform.clearTemporaryFiles();
}
