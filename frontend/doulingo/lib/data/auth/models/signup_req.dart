class SignupModel {
  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final String? password;
  final String? bio;
  final String? courseId;

  SignupModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.password,
    this.bio,
    this.courseId,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'bio': bio,
      'courseId': courseId,
    };
  }
}
