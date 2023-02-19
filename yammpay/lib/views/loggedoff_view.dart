import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/themes/constants.dart';
import '../view_models/loggedoff_viewmodel.dart';
import 'widget/addspace_widget.dart';

class LoggedOffScreen extends StatelessWidget {
  LoggedOffViewModel viewModel = LoggedOffViewModel();
  LoggedOffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildImage(
          'https://assets2.lottiefiles.com/packages/lf20_n2m0isqh.json', 350.w),
      addVerticalSpace(20.h),
      Padding(
        padding: SIDE_PADDING,
        child: RichText(
          text: TextSpan(children: [
            const TextSpan(
                text: "Oops! You need to be ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: COLOR_BLACK,
                  fontSize: 22,
                )),
            TextSpan(
              text: 'Logged in',
              recognizer: TapGestureRecognizer()
                ..onTap = (() => viewModel.goToLoginPage(context)),
              style: const TextStyle(
                color: COLOR_PURPLE,
                fontWeight: FontWeight.bold,
                //decoration: TextDecoration.underline,
                fontSize: 22,
              ),
            ),
            const TextSpan(
                text: " to view this page's content!",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: COLOR_BLACK,
                  fontSize: 22,
                )),
          ]),
        ),
      ),
    ]);
  }
}

Widget buildImage(String path, double width) =>
    Center(child: Lottie.network(path, width: width));
