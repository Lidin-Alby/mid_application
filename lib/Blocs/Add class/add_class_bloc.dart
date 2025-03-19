import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Add%20class/add_class_event.dart';
import 'package:mid_application/Blocs/Add%20class/add_class_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/models/class_model.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial()) {
    on<LoadClasses>(
      (event, emit) async {
        emit(ClassInitial());
        try {
          var url = Uri.parse(
              '$ipv4/v2/getMidClasses/${Uri.encodeComponent(event.schoolCode)}');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            Map data = jsonDecode(res.body);
            print(data);
            List classList = data['classes'];
            List<ClassModel> classes =
                classList.map((e) => ClassModel.fromJson(e)).toList();
            emit(ClassLoaded(classes));
          } else {
            emit(ClassError(res.body));
          }
        } catch (e) {
          ClassError(e.toString());
        }
      },
    );
    on<SaveClassPressed>(
      (event, emit) async {
        final currentState = state as ClassLoaded;

        emit(AddClassLoading());
        var url = Uri.parse('$ipv4/v2/addClassOrBranchMid');
        ClassModel newClass = ClassModel(
            schoolCode: event.schoolCode,
            className: event.className,
            section: event.section,
            classTitle: '${event.className}-${event.section}');
        var res = await http.post(url, body: newClass.toJson());
        if (res.statusCode == 201) {
          final updatedClasses = List<ClassModel>.from(currentState.classes)
            ..add(newClass);
          emit(ClassAdded());
          emit(ClassLoaded(updatedClasses));
        } else {
          emit(AddClassError(res.body));
          emit(ClassLoaded(currentState.classes));
        }
      },
    );
  }
}
