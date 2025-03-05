class UserEntity {
  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final String? bio;
  final num? score;
  final List<String>? followers;
  final List<String>? followings;
  final List<String>? learnDays;
  final List<dynamic>? courseId;

  UserEntity({
    this.id,
    this.name,
    this.username,
    this.email,
    this.bio,
    this.score,
    this.followers,
    this.followings,
    this.learnDays,
    this.courseId,
  });
}
