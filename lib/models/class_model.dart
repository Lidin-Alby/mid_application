class ClassModel {
  final String? className;
  final String classTitle;
  final String? section;
  final String? schoolCode;
  final int? totalStudents;

  ClassModel(
      {this.schoolCode,
      required this.classTitle,
      this.className,
      this.section,
      this.totalStudents});

  factory ClassModel.fromJson(json) {
    return ClassModel(
      schoolCode: json['schoolCode'],
      classTitle: json['classTitle'],
      totalStudents: json['totalStudents'] ?? 0,
    );
  }

  Map toJson() {
    return {
      'schoolCode': schoolCode,
      'title': '$className-$section',
      'className': className,
      'sec': section,
    };
  }
}
