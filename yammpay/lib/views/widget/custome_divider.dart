import 'package:flutter/material.dart';
import '../../config/themes/constants.dart';

class CustomeDivider extends StatelessWidget {
  const CustomeDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: COLOR_PURPLE.withOpacity(0.3),
    );
  }
}
