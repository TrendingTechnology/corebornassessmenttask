class CommentModel {
  int userId;
  int id;
  String name;
  String email;
  String body;

  CommentModel({
    required this.userId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  CommentModel.fromJson(Map<String, dynamic> json)
      : userId = json['postId'] as int,
        id = json['id'] as int,
        name = json['name'] as String,
        email = json['email'] as String,
        body = json['body'] as String;
}
