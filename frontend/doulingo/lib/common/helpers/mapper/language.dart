import 'package:doulingo/data/language/models/language.dart';
import 'package:doulingo/domain/languages/entities/language.dart';

class LanguageMapper {
  static LanguageEntity toEntity(LanguageModel language) {
    return LanguageEntity(
      id: language.id,
      image: language.image,
      language: language.language,
      userIds: language.userIds,
      idChapters: language.idChapters,
      vowelIds: language.vowelIds,
      consonantIds: language.consonantIds,
    );
  }
}
