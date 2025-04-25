import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Bulk%20student%20upload/bulk_student_upload_event.dart';
import 'package:mid_application/Blocs/Bulk%20student%20upload/bulk_student_upload_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:http/http.dart' as http;

class BulkStudentUploadBloc
    extends Bloc<BulkStudentUploadEvent, BulkStudentUploadState> {
  BulkStudentUploadBloc() : super(BulkUploadStudentsInitial()) {
    on<BulkUploadStudents>(
      (event, emit) async {
        emit(BulkUploadingStudents());

        try {
          var url = Uri.parse('$ipv4/uploadCSVStudentUsersMid');

          var req = http.MultipartRequest(
            'POST',
            url,
          );
          var httpDoc = http.MultipartFile.fromBytes('csvFile', event.file,
              filename: 'upl_doc.csv');
          req.files.add(httpDoc);
          req.fields.addAll({'schoolCode': event.schoolCode});
          var res = await req.send();
          var responded = await http.Response.fromStream(res);
          if (res.statusCode == 201) {
            emit(BulkUploadedStudents());
          } else {
            emit(BulkUploadSudentsError(responded.body));
          }
        } catch (e) {
          emit(BulkUploadSudentsError(e.toString()));
        }
      },
    );
  }
}
