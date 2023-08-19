import 'package:flutter/material.dart';
import 'package:swivel_task/core/themes/app_colors.dart';

class QuizOption extends StatelessWidget {
  const QuizOption(
      {super.key,
      required this.title,
      required this.index,
      this.onTap,
      required this.selectedOption});
  final String title, index;
  final Function()? onTap;
  final bool selectedOption;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: selectedOption
                  ? AppColors.primaryColor
                  : Colors.transparent)),
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        leading: Text(index),
      ),
    );
  }
}
