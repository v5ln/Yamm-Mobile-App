import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'config/routing/routes.dart';
import 'config/themes/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

        // ? Iphone 13 Pro Max size.
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'FiraSans',
              primarySwatch: primaryColors(),
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: routes,
            initialRoute: "nav",
          );
        });
  }
}
