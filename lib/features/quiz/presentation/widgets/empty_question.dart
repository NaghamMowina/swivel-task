import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swivel_task/core/helpers/assets_helper.dart';
import 'package:swivel_task/core/themes/themes.dart';

class EmptyQuestion extends StatelessWidget {
  const EmptyQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Center(
          child: Container(
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
            // height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsHelper.answers,
                  height: 150.h,
                ),
                35.verticalSpace,
                Text(
                  'You finished all questions',
                  style: AppStyles.blackTextStyle18_700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
