import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swivel_task/core/helpers/assets_helper.dart';
import 'package:swivel_task/core/helpers/session_manager.dart';
import 'package:swivel_task/core/themes/app_colors.dart';
import 'package:swivel_task/core/themes/app_styles.dart';
import 'package:swivel_task/core/widgets/custom_button.dart';
import 'package:swivel_task/features/history/presentation/pages/history_page.dart';
import 'package:swivel_task/features/quiz/presentation/pages/questions_page.dart';
import 'package:swivel_task/features/register_name/presentation/pages/enter_name_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          IconButton(
              onPressed: () {
                sessionManager.setUsername(name: '');
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const RegisterName()));
              },
              icon: const Icon(Icons.login_outlined))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsHelper.welcome,
                height: 200.h,
              ),
              25.verticalSpace,
              Text(
                'Welcome $name ,',
                style: AppStyles.primaryTextStyle24_400,
              ),
              25.verticalSpace,
              CustomButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const QuestionPage()));
                },
                title: 'Start Quiz',
                titleStyle: AppStyles.whiteTextStyle18_700,
                isDisabled: false,
                width: double.infinity,
              ),
              35.verticalSpace,
              CustomButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const HistoryPage()));
                },
                title: 'History',
                titleStyle: AppStyles.whiteTextStyle18_700,
                isDisabled: false,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
