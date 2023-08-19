import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swivel_task/core/helpers/assets_helper.dart';
import 'package:swivel_task/core/themes/themes.dart';
import 'package:swivel_task/core/widgets/custom_button.dart';
import 'package:swivel_task/features/quiz/presentation/pages/questions_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.score});
  final int score;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Words Quiz",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsHelper.questions,
                        height: 190.h,
                      ),
                      25.verticalSpace,
                      const Text(
                        "Your Score is",
                        style: TextStyle(
                            fontSize: 30, color: AppColors.blackColor),
                      ),
                      15.verticalSpace,
                      Text(
                        widget.score.toString(),
                        style: AppStyles.primaryTextStyle24_800,
                      ),
                      50.verticalSpace,
                      CustomButton(
                        isDisabled: false,
                        title: 'Try another test',
                        titleStyle: AppStyles.whiteTextStyle18_700,
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const QuestionPage())),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
