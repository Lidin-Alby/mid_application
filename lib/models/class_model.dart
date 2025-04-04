class ClassModel {
  final String? className;
  final String classTitle;
  final String? section;
  final String? schoolCode;
  final String? classTeacher;
  final String? profilePic;
  final String? mob;
  final int? totalStudents;
  final int? uncheckCount;
  final int? noPhotoCount;
  final int? readyCount;
  final int? printingCount;
  final int? printedCount;

  ClassModel({
    this.profilePic,
    this.classTeacher,
    this.mob,
    this.schoolCode,
    required this.classTitle,
    this.className,
    this.section,
    this.totalStudents,
    this.uncheckCount,
    this.noPhotoCount,
    this.readyCount,
    this.printingCount,
    this.printedCount,
  });

  factory ClassModel.fromJson(json) {
    return ClassModel(
      schoolCode: json['schoolCode'],
      classTitle: json['classTitle'],
      classTeacher: json['classTeacher'],
      profilePic: json['profilePic'],
      totalStudents: json['totalStudents'] ?? 0,
      uncheckCount: json['uncheckCount'] ?? 0,
      noPhotoCount: json['noPhotoCount'] ?? 0,
      readyCount: json['readyCount'] ?? 0,
      printingCount: json['printingCount'] ?? 0,
      printedCount: json['printedCount'] ?? 0,
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
