import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../config/themes/constants.dart';
import 'widget/addspace_functions.dart';
import 'widget/page_layout_widget.dart';
import 'widget/page_title_widget.dart';
import 'loggedoff_view.dart';


class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);
  static const String id = '/OrdersScreen';

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
   

    return DefaultTabController(
      length: 2,
      child: PageLayout(
        child: true
            ? Column(children: [
                PageTitle(title: "Orders"),
                Padding(
                  padding: EdgeInsets.all(PADDING),
                  child: Container(
                    decoration: BoxDecoration(
                      color: COLOR_GREY,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                          labelColor: COLOR_WHITE,
                          labelStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'IBMPlexSansArabic'),
                          unselectedLabelColor: COLOR_PURPLE,
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'IBMPlexSansArabic'),
                          indicator: BoxDecoration(
                            color: COLOR_PURPLE,
                            border: Border.all(
                                color: COLOR_PURPLE.withOpacity(0.4), width: 3),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          tabs: [
                            Tab(
                              text:"Pending",
                            ),
                            Tab(
                              text: "Completed",
                            ),
                          ]),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    true
                        ? Center(
                            child: Text(
                            'You Do not Have Any Orders Yet :(',
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ))
                        :  LoggedOffScreen(),
                     LoggedOffScreen(),
                  ]),
                ),
                addVerticalSpace(10.h),
              ])
            :  LoggedOffScreen(),
      ),
    );
  }
}
