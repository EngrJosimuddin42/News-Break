class CommentModel {
  final int id;
  final String userName;
  final String userProfileImage;
  final String text;
  final String location;
  final String createdAt;
  int likes;
  bool isLiked;

  CommentModel({
    required this.id,
    required this.userName,
    required this.userProfileImage,
    required this.text,
    this.location = '',
    required this.createdAt,
    this.likes = 0,
    this.isLiked = false,
  });
}