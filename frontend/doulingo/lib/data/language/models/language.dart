class LanguageModel {
  final String? id;
  final String? image;
  final String? language;
  final List<dynamic>? userIds;
  final List<dynamic>? idChapters;
  final List<dynamic>? vowelIds;
  final List<dynamic>? consonantIds;

  LanguageModel({
    required this.id,
    required this.image,
    required this.language,
    required this.userIds,
    required this.idChapters,
    required this.vowelIds,
    required this.consonantIds,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['_id'],
      image: json['image'],
      language: json['title'],
      userIds: json['userIds'],
      idChapters: json['idChapters'],
      vowelIds: json['vowelIds'],
      consonantIds: json['consonantIds'],
    );
  }
}
