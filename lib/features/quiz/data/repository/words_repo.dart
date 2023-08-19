import 'package:swivel_task/features/quiz/model/words_model.dart';

abstract class Words {
  Future<WordsModel> getWords();
}
