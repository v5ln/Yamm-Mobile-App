import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/themes/constants.dart';

class LogoWidget extends StatelessWidget {
  final String imgPath;

  const LogoWidget({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.h,
      width: 240.w,
      child: Image(
        image: AssetImage(imgPath),
      ),
    );
  }
}

class ChangeLangWidget extends StatelessWidget {
  const ChangeLangWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {},
      child: Text("العربية", style: kLangStyle),
    );
  }
}
