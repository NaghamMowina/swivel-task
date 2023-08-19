class WordsModel {
  WordsModel({
    required this.wordList,
  });
  late final List<WordList> wordList;

  WordsModel.fromJson(Map<String, dynamic> json) {
    wordList =
        List.from(json['wordList']).map((e) => WordList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['wordList'] = wordList.map((e) => e.toJson()).toList();
    return data;
  }
}

class WordList {
  WordList({
    required this.id,
    required this.word,
    required this.pos,
  });
  late final int id;
  late final String word;
  late final String pos;

  WordList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['word'] = word;
    data['pos'] = pos;
    return data;
  }
}
