import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;
  const LoadingSpinner({Key? key, this.size = 140}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        size: size,
        itemBuilder: (context, index) {
          final colors = [COLOR_PURPLE, COLOR_PINK, COLOR_YELLOW];
          final color = colors[index % colors.length];
          return DecoratedBox(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle));
        },
      ),
    );
  }
}
