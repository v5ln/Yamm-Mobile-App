import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/providers/bank_provider.dart';
import 'package:yammpay/providers/data_selection_provider.dart';
import 'package:yammpay/providers/order_provider.dart';

import 'config/routing/routes.dart';
import 'config/themes/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // // Set the background messaging handler early on, as a named top-level function
  // AwesomeNotifications().initialize(
  //   // ? The Android notification icon, null = default app icon or you can specify a different one by giving the path
  //   null,
  //   [
  //     NotificationChannel(
  //       // ? Assign this channel to different notification
  //       channelKey: 'basic_channel',
  //       // ? The name that will be displayed in the Android notifications settings
  //       channelName: 'Basic Notifications',
  //       // ? The channel descrption which will be visible to user on Android
  //       channelDescription: 'Notification',
  //       defaultColor: COLOR_PURPLE,
  //       // ? To display the notification on Android
  //       importance: NotificationImportance.High,
  //       // ? Showing a badge on the app icon to show there is a notification waiting for you
  //       channelShowBadge: true,
  //     ),
  //     NotificationChannel(
  //       channelKey: 'timed_channel',
  //       channelName: 'Timed Notifications',
  //       channelDescription: 'Notifications that can be timed to set',
  //       defaultColor: COLOR_PURPLE,
  //       locked: true,
  //       importance: NotificationImportance.High,
  //       // soundSource:
  //     ),
  //   ],
  // );
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
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => OrderProvider()),
              ChangeNotifierProvider(create: (context) => BankProvider()),
              ChangeNotifierProvider(create: (context) => DataSelection()),
              ChangeNotifierProvider(create: (context) => AuthProvider()),
            ],
            child: GetMaterialApp(
              theme: ThemeData(
                fontFamily: 'FiraSans',
                primarySwatch: primaryColors(),
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: routes,
              initialRoute: "nav",
            ),
          );
        });
  }
}
