class AlbumModel {
  int userId;
  int id;
  String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  AlbumModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int,
        id = json['id'] as int,
        title = json['title'] as String;
}
