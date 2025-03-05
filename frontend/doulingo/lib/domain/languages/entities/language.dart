class LanguageEntity {
  final String? id;
  final String? image;
  final String? language;
  final List<dynamic>? userIds;
  final List<dynamic>? idChapters;
  final List<dynamic>? vowelIds;
  final List<dynamic>? consonantIds;

  LanguageEntity({
    required this.id,
    required this.image,
    required this.language,
    required this.userIds,
    required this.idChapters,
    required this.vowelIds,
    required this.consonantIds,
  });
}
