import 'dart:convert';
// import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:swivel_task/core/helpers/session_manager.dart';
import 'package:swivel_task/features/quiz/data/repository/words_repo.dart';
import 'package:swivel_task/features/quiz/model/result_model.dart';
import 'package:swivel_task/features/quiz/model/words_model.dart';

class LocalWordRepository implements Words {
  @override
  Future<WordsModel> getWords() async {
    final String response =
        await rootBundle.loadString('assets/json/WordList.json');
    // log('ress $response');
    return WordsModel.fromJson(jsonDecode(response));
  }

  Future<List<ResultModel>> getHistory() async {
    String name = await sessionManager.getUsername();
    return await FirebaseFirestore.instance
        .collection('results')
        .where('name', isEqualTo: name)
        .orderBy("createdAt", descending: false)
        .get()
        .then((event) =>
            event.docs.map((e) => ResultModel.fromJson(e.data())).toList());
  }
}
