import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swivel_task/core/helpers/assets_helper.dart';
import 'package:swivel_task/core/helpers/session_manager.dart';
import 'package:swivel_task/features/home/presentation/pages/home_page.dart';
import 'package:swivel_task/features/register_name/presentation/pages/enter_name_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _navigationTimer() async {
    Timer(const Duration(seconds: 2), () async {
      String name = await sessionManager.getUsername();
      if (name != '') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
                  name: name,
                )));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const RegisterName()));
        // context.router.replace(const LoginWithPhoneNumberRoute());
      }
    });
  }

  @override
  void initState() {
    _navigationTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AssetsHelper.questions,height: 200.h,),
      ),
    );
  }
}
