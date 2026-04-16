class UserModel {
  final String name;
  final String? username;
  final String email;
  final String? bio;
  final String? website;
  final String? gender;
  final String? birthYear;
  final String? profileImageUrl;

  UserModel({
    required this.name,
    this.username,
    required this.email,
    this.bio,
    this.website,
    this.gender,
    this.birthYear,
    this.profileImageUrl
  });
}