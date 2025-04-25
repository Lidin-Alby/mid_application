abstract class BulkStudentUploadState {}

class BulkUploadStudentsInitial extends BulkStudentUploadState {}

class BulkUploadingStudents extends BulkStudentUploadState {}

class BulkUploadedStudents extends BulkStudentUploadState {}

class BulkUploadSudentsError extends BulkStudentUploadState {
  final String error;

  BulkUploadSudentsError(this.error);
}
