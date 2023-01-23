import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/themes/constants.dart';
import 'HomePage_Widgets.dart';


class PageLayout extends StatelessWidget {
  final Widget child;
  final bool? automaticallyImplyLeading;
  const PageLayout(
      {Key? key, required this.child, this.automaticallyImplyLeading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // * Dismiss the kyeboard if it is open when the user clicks on the screen
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        //  resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0.h), // here the desired height
          child: AppBar(
              automaticallyImplyLeading: automaticallyImplyLeading!,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const LogoWidget(
                imgPath: 'assets/images/logo_eng2.png',
              )
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   SizedBox(
              //     width: 80.w,
              //     height: 80.h,
              //     child: Image.asset('assets/images/011.png'),
              //   ),
              //   Text(
              //     translation(context).yamm_title,
              //     style: TextStyle(
              //       fontSize: 40.sp,
              //       letterSpacing: -3,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: 'IBMPlexSansArabic',
              //     ),
              //   )
              // ]),
              ),
        ),
        backgroundColor: COLOR_WHITE,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xffBC9AFF),
                  COLOR_PINK,
                  COLOR_BLUE,
                  COLOR_PURPLE,
                  Color(0xffBC9AFF),
                ])),
          ),
          Positioned.fill(
            top: 150.h,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: COLOR_WHITE,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.r),
                  topLeft: Radius.circular(50.r),
                ),
              ),
              child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0.h),
                    child: child,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
