class Word {
  final String word;
  final String phonetic;
  final List<String> noun;
  final List<String> verb;
  final List<List<String>> sentences;

  Word({
    required this.word,
    required this.phonetic,
    required this.noun,
    required this.verb,
    required this.sentences,
  });
}

class ReciteEntity {
  int id;
  DateTime createdTime;

  ReciteEntity({
    required this.id,
    required this.createdTime,
  });

  factory ReciteEntity.fromJson(Map<String, dynamic> json) {
    return ReciteEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
    };
  }
}