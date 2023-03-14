import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';

class PageTitleAndSubtitle extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  const PageTitleAndSubtitle(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: title,
        ),
        addVerticalSpace(8.h),
        subtitle,
      ],
    );
  }
}
