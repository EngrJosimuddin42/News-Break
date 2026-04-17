class ReelModel {
  int? id;
  String imageUrl;
  String userProfileImage;
  String userName;
  String description;
  String? source;
  int likes;
  int comments;
  int shares;
  bool isFollowing;
  bool isLiked;

  ReelModel({
    this.id,
    this.imageUrl = '',
    this.userName = '',
    this.userProfileImage = '',
    this.description = '',
    this.source,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isFollowing = false,
    this.isLiked = false,
  });
}