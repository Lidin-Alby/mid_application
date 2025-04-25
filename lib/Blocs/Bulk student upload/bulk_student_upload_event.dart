import 'dart:typed_data';

abstract class BulkStudentUploadEvent {}

class BulkUploadStudents extends BulkStudentUploadEvent {
  final String schoolCode;
  final Uint8List file;

  BulkUploadStudents(this.schoolCode, this.file);
}
