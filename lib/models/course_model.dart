class CourseModel {
  final int id;
  final String title;
  final String tag;
  final String description;
  final String status;
  int progressValue = 50;

  CourseModel(
      {required this.id,
      required this.title,
      required this.tag,
      required this.description,
      required this.progressValue,
      required this.status});
}

class SingleCourseModel {
  final int id;
  final String title;
  final String tag;
  final String description;
  final String status;
  final List chapters;
  int progressValue = 50;

  SingleCourseModel(
      {required this.id,
        required this.title,
        required this.tag,
        required this.description,
        required this.progressValue,
        required this.status,
        required this.chapters,
      });
}
