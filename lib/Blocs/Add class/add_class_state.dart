import 'package:mid_application/models/class_model.dart';

abstract class ClassState {}

class ClassInitial extends ClassState {}

class ClassLoading extends ClassState {}

class ClassLoaded extends ClassState {
  final List<ClassModel> classes;

  ClassLoaded(this.classes);
}

class ClassError extends ClassState {
  final String error;

  ClassError(this.error);
}

// class AddClassInitial extends ClassState {}

class AddClassLoading extends ClassState {}

class ClassAdded extends ClassState {}

class AddClassError extends ClassState {
  final String error;

  AddClassError(this.error);
}
