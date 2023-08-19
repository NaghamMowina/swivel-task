import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swivel_task/core/themes/app_colors.dart';
import 'package:swivel_task/features/quiz/provider/quiz_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Provider.of<QuizProvider>(context, listen: false).fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Consumer<QuizProvider>(builder: (_, quizstate, __) {
          return quizstate.showLoading!
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: quizstate.history!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(quizstate.history![index].score.toString()),
                      trailing: Text(quizstate.history![index].createdAt!
                          .toLocal()
                          .toString()),
                    );
                  },
                );
        }));
  }
}
