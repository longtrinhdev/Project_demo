import 'package:doulingo/data/auth/models/user.dart';
import 'package:doulingo/domain/auth/entities/user.dart';

class UserMapper {
  static UserEntity toEntity(UserModel user) {
    return UserEntity(
      id: user.id,
      name: user.name,
      email: user.email,
      bio: user.bio,
      score: user.score,
      username: user.username,
      followers: user.followers,
      followings: user.followings,
      learnDays: user.learnDays,
      courseId: user.courseId,
    );
  }
}
