class ChapterModel {
  final int id;
  final bool is_completed;
  final String title;
  final String description;
  final String picture;
  final int time_to_complete;

  ChapterModel(
      {required this.id,
      required this.is_completed,
      required this.title,
      required this.description,
      required this.picture,
      required this.time_to_complete});
}
