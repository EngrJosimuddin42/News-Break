class NewsModel {
  final int id;
  final String category;
  final String title;
  final String author;
  final String timeAgo;
  final String publisherName;
  final String publisherMeta;
  final String? publisherType;
  String totalFollowers;
  final String publisherImageUrl;
  final String imageUrl;
  final String? secondaryImageUrl;
  final String? videoUrl;
  final String imageCaption;
  final String body;
  final String likes;
  final String comments;
  final String shares;
  final String reactions;
  final bool isVerified;
  bool isFollowing;

   NewsModel({
     required this.id,
    required this.category,
    required this.title,
    required this.author,
    required this.timeAgo,
    required this.publisherName,
    required this.publisherMeta,
    this.publisherType,
    this.totalFollowers = '0',
    this.publisherImageUrl = 'assets/images/publisher.png',
    required this.imageUrl,
    this.secondaryImageUrl,
    this.videoUrl,
    this.imageCaption = '',
    required this.body,
    this.likes = '0',
    this.comments = '0',
    this.shares='0',
    this.reactions = '0',
    this.isVerified = true,
    this.isFollowing = false,
  });
}