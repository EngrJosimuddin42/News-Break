class UserModel {
  final String name;
  final String? username;
  final String? publisherMeta;
  final String email;
  final String? bio;
  final String? website;
  final String? gender;
  final String? birthYear;
  String? profileImageUrl;
  final String? location;
  final String? timeAgo;
  final bool isHighlighted;

  UserModel({
    required this.name,
    this.username,
    this.publisherMeta,
    required this.email,
    this.bio,
    this.website,
    this.gender,
    this.birthYear,
    this.profileImageUrl,
    this.location,
    this.timeAgo,
    this.isHighlighted = false,
  });
}