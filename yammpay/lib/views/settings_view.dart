import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/views/loggedoff_view.dart';

import '../config/themes/constants.dart';
import 'widget/page_layout_widget.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  static const String id = '/SettingsView';

  @override
  Widget build(BuildContext context) {
    // var _userProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: COLOR_BLACK,
      body: PageLayout(
        child: 
        // false
        //     ? Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           PageTitle(title: translation(context).settings_title),
        //           Padding(
        //             padding: EdgeInsets.all(PADDING),
        //             child: Column(
        //               children: [
        //                 SettingItem(
        //                     title: translation(context).email_field,
        //                     icon: const Icon(Icons.email),
        //                     onClick: () => Navigator.pushNamed(
        //                         context, ChangeEmailScreen.id)),
        //                 SettingItem(
        //                     title: translation(context).mycards_title,
        //                     icon: const Icon(Icons.credit_card),
        //                     onClick: () =>
        //                         Navigator.pushNamed(context, MyCardsScreen.id)),
        //                 SettingItem(
        //                     title: translation(context).myaddresses_title,
        //                     icon: const Icon(Icons.home_filled),
        //                     onClick: () => Navigator.pushNamed(
        //                         context, MyAdressesScren.id)),
        //               ],
        //             ),
        //           ),
        //           Spacer(),
        //           // addVerticalSpace(8.h),
        //           TermsCard(
        //             title: translation(context).termsandconditions_title,
        //             icon: const Icon(Icons.shield_outlined),
        //             ontap: () =>
        //                 Navigator.pushNamed(context, TermsAndConditions.id),
        //           ),
        //           TermsCard(
        //             title: translation(context).faq_title,
        //             icon: const Icon(Icons.question_answer_outlined),
        //             ontap: () => Navigator.pushNamed(context, FAQScreen.id),
        //           ),
        //           TermsCard(
        //             title: translation(context).privacy_title,
        //             icon: const Icon(Icons.privacy_tip_outlined),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.all(PADDING),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: [
        //                 Text(translation(context).contactus_title,
        //                     style: kContactStyle),
        //                 Text(translation(context).whosus_title,
        //                     style: kContactStyle),
        //                 Text(translation(context).aboutus_title,
        //                     style: kContactStyle),
        //               ],
        //             ),
        //           ),
        //         ],
        //       )
            // :
              LoggedOffScreen(),
      ),
    );
  }
}
