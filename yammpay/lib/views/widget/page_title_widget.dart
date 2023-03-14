import 'package:flutter/material.dart';

import '../../config/themes/constants.dart';
import 'custome_divider.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, left: 40, right: 25),
          child: Text(
            title,
            style: kPageTitleStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: PADDING,
          ),
          child: CustomeDivider(),
        ),
      ],
    );
  }
}
