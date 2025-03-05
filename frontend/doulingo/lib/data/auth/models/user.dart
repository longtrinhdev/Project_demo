class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      score: json['score'] ?? 0,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      followings: (json['followings'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      learnDays: (json['learnDays'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      courseId: json['courseId'],
    );
  }
}
