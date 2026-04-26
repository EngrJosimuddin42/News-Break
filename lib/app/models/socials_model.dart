class SocialsModel {
  final int id;
  final String category;
  final String userName;
  final String userImageUrl;
  final String text;
  final String userRole;
  final String timeAgo;
  final List<String> imageUrls;
  final String likes;
  final String comments;
  final String shares;

  SocialsModel({
    required this.id,
    this.category = 'Community',
    required this.userName,
    required this.userImageUrl,
    required this.text,
    required this.userRole,
    required this.timeAgo,
    required this.imageUrls,
    this.likes = '0',
    this.comments = '0',
    this.shares = '0',
  });
}