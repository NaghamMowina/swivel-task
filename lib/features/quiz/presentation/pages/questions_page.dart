import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:swivel_task/core/helpers/session_manager.dart';
import 'package:swivel_task/core/themes/themes.dart';
import 'package:swivel_task/core/widgets/custom_button.dart';
import 'package:swivel_task/features/quiz/model/result_model.dart';
import 'package:swivel_task/features/quiz/presentation/pages/result_page.dart';
import 'package:swivel_task/features/quiz/presentation/widgets/widgets.dart';
import 'package:swivel_task/features/quiz/provider/quiz_provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _questionNumber = 1;
  final PageController _controller = PageController(initialPage: 0);
  List<String> options = ['Verb', 'Adverb', 'Adjective', 'Noun'];
  List<String> optionsLetters = ["A.", "B.", "C.", "D."];
  String? selectedOption, correctAnswer;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Provider.of<QuizProvider>(context, listen: false).fetchlocalclass();
    await Provider.of<QuizProvider>(context, listen: false).fetchHistory();
    // ignore: use_build_context_synchronously
    await Provider.of<QuizProvider>(context, listen: false)
        .fetchNewQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Consumer<QuizProvider>(builder: (_, quizstate, __) {
        return quizstate.showLoading!
            ? const CircularProgressIndicator()
            : quizstate.wordList != null
                ? quizstate.wordList!.isEmpty
                    ? const EmptyQuestion()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Words Quiz",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 14, bottom: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.clear,
                                      color: Colors.white,
                                      weight: 10,
                                    ),
                                  ),
                                  15.horizontalSpace,
                                  SizedBox(
                                    width: 300.w,
                                    child: Text(
                                      ' choose the word right part of speech from 4 options',
                                      style: AppStyles.whiteTextStyle18_700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 12, left: 10, right: 10),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.24),
                                    blurRadius: 20.0,
                                    offset: const Offset(0.0, 10.0),
                                    spreadRadius: 10,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Question $_questionNumber/${quizstate.wordList?.length}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade500),
                                      ),
                                      Expanded(
                                        child: PageView.builder(
                                          controller: _controller,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: quizstate.wordList?.length,
                                          onPageChanged: (value) {
                                            setState(() {
                                              _questionNumber = value + 1;
                                            });
                                          },
                                          itemBuilder: (context, index) {
                                            final myquestions =
                                                quizstate.wordList?[index];
                                            return Column(
                                              children: [
                                                Text(
                                                  myquestions!.word,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontSize: 18,
                                                      ),
                                                ),
                                                15.verticalSpace,
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: 4,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return QuizOption(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedOption =
                                                                options[index]
                                                                    .toLowerCase();
                                                            correctAnswer =
                                                                myquestions.pos;
                                                          });
                                                        },
                                                        selectedOption:
                                                            selectedOption ==
                                                                options[index]
                                                                    .toLowerCase(),
                                                        title: options[index],
                                                        index: optionsLetters[
                                                            index],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: CustomButton(
                                            title: _questionNumber <
                                                    quizstate.wordList!.length
                                                ? 'Next'
                                                : 'Finish',
                                            isDisabled: false,
                                            onPressed: () async {
                                              if (_questionNumber <
                                                  quizstate.wordList!.length) {
                                                log('selected option is $selectedOption and correct ans is $correctAnswer');
                                                if (correctAnswer ==
                                                    selectedOption) {
                                                  await quizstate
                                                      .correctAnswer();
                                                }

                                                _controller.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 800),
                                                  curve: Curves.easeInOut,
                                                );
                                                setState(() {
                                                  selectedOption = null;
                                                  correctAnswer = null;
                                                  _questionNumber++;
                                                });
                                              } else {
                                                if (correctAnswer ==
                                                    selectedOption) {
                                                  await quizstate
                                                      .correctAnswer();
                                                }
                                                var score = quizstate.score;
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultPage(
                                                      score: score,
                                                    ),
                                                  ),
                                                );
                                                String name =
                                                    await sessionManager
                                                        .getUsername();
                                                quizstate.resetScore(
                                                    ResultModel(
                                                        name: name,
                                                        score: score,
                                                        qIds: quizstate.qIds
                                                            .toString(),
                                                        createdAt:
                                                            DateTime.now()));
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                : SizedBox(
                    child: Text(
                      'data',
                      style: AppStyles.whiteTextStyle18_700,
                    ),
                  );
      }),
    );
  }
}
