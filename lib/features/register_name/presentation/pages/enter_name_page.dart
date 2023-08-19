import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swivel_task/core/helpers/assets_helper.dart';
import 'package:swivel_task/core/helpers/session_manager.dart';
import 'package:swivel_task/core/themes/app_colors.dart';
import 'package:swivel_task/core/themes/app_styles.dart';
import 'package:swivel_task/core/widgets/custom_button.dart';
import 'package:swivel_task/features/quiz/presentation/pages/questions_page.dart';
import 'package:swivel_task/features/register_name/presentation/widgets/widgets.dart';

class RegisterName extends StatefulWidget {
  const RegisterName({super.key});

  @override
  State<RegisterName> createState() => _RegisterNameState();
}

class _RegisterNameState extends State<RegisterName> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                'Please enter your name',
                style: AppStyles.primaryTextStyle24_400,
              ),
              25.verticalSpace,
              CustomTextField(
                keyboardType: TextInputType.name,
                filled: true,
                controller: nameController,
              ),
              35.verticalSpace,
              CustomButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    sessionManager.setUsername(name: nameController.text);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const QuestionPage()));
                  }
                },
                title: 'Start Quiz',
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
