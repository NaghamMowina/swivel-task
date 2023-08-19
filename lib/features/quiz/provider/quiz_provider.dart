import 'dart:convert';
import 'dart:developer' as dvp;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swivel_task/core/helpers/app_toast.dart';
import 'package:swivel_task/features/quiz/data/repository/local_word_repo.dart';
import 'package:swivel_task/features/quiz/model/result_model.dart';
import 'package:swivel_task/features/quiz/model/words_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizProvider extends ChangeNotifier {
  bool? _showLoading = false;
  bool? get showLoading => _showLoading;
  int _score = 0;
  int get score => _score;

  WordsModel? _wordModel;
  WordsModel? get wordModel => _wordModel;
  fetchlocalclass() async {
    try {
      _showLoading = true;
      //notifyListeners();
      _wordModel = await LocalWordRepository().getWords();
      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      dvp.log(e.toString());
    }
  }

  List<ResultModel>? _history;
  List<ResultModel>? get history => _history;
  fetchHistory() async {
    try {
      _showLoading = true;
      //notifyListeners();
      _history = await LocalWordRepository().getHistory();
      dvp.log('history is ${history!.first.toJson().toString()}');
      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      dvp.log(e.toString());
    }
  }

  final List<WordList> _wordList = [];
  List<WordList>? get wordList => _wordList;
  final List<int> _qIds = [];
  List<int>? get qIds => _qIds;
  fetchNewQuestionsList() async {
    // await fetchlocalclass();
    _score = 0;
    _wordList.clear();
    _qIds.clear();
    try {
      _showLoading = true;
      //notifyListeners();
      List historyQids = [];
      for (var element in _history!) {
        // dvp.log('llll ${jsonDecode(element.qIds!)}');
        var dd = jsonDecode(element.qIds!);
        historyQids.addAll(dd);
      }
      // dvp.log('the forbiddenn list is ${historyQids.length.toString()}');
      List<int> numberList = [];
      Random randomizer = Random();
      if (historyQids.length < wordModel!.wordList.length) {
        while (numberList.length < 5) {
          // dvp.log('kkkkk word model ${wordModel!.wordList.length}');
          int randomNumber = randomizer.nextInt(wordModel!.wordList.length) + 1;
          if (!numberList.contains(randomNumber) &&
              !historyQids.contains(randomNumber)) {
            dvp.log('ran is $randomNumber');
            numberList.add(randomNumber);
            _wordList.add(wordModel!.wordList
                .firstWhere((element) => element.id == randomNumber));
            _qIds.add(wordModel!.wordList
                .firstWhere((element) => element.id == randomNumber)
                .id);
          }
        }
      }
      // dvp.log('the qids list is ${_qIds.toString()}');
      // dvp.log('the forbideen list is ${historyQids.toString()}');
      // dvp.log(
      //     'word list length is ${wordList!.length}list is ${numberList.toString()}');

      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      // notifyListeners();
      dvp.log(e.toString());
    }
  }

  correctAnswer() {
    _score += 10;
    notifyListeners();
  }

  resetScore(ResultModel resultModel) async {
    dvp.log('result model is ${resultModel.toJson().toString()}');
    await FirebaseFirestore.instance
        .collection('results')
        .add(resultModel.toJson())
        .catchError((e) {
      AppToast.errorToast(
        e.toString(),
      );
      throw e;
    });
    _score = 0;
    _wordList.clear();
    _qIds.clear();
    notifyListeners();
  }
}
