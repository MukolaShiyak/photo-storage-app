import 'package:file_picker/file_picker.dart';

abstract class IFilePickerService {
  Future<FilePickerResult?> pickMultiFiles();
  Future<bool?> clearTemporaryFiles();
}
