abstract class ClassEvent {}

class LoadClasses extends ClassEvent {
  final String schoolCode;

  LoadClasses(this.schoolCode);
}

class SaveClassPressed extends ClassEvent {
  final String className;
  final String section;
  final String schoolCode;

  SaveClassPressed(
      {required this.className,
      required this.section,
      required this.schoolCode});
}
