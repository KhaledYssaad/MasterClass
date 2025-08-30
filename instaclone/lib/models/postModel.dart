class PostModel {
  final String username;
  final String profileImage;
  final String postImage;
  final String caption;

  PostModel({
    required this.username,
    required this.postImage,
    required this.profileImage,
    required this.caption,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      username: json["username"],
      postImage: json["postImage"],
      profileImage: json["profileImage"],
      caption: json["caption"],
    );
  }
}
