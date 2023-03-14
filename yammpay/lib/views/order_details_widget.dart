// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/providers/order_provider.dart';
import 'package:yammpay/views/pending_orders_view.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
class PendingOrdersList extends StatelessWidget {
  const PendingOrdersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);

    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        itemCount: _orderProvider.pastOrders.length,
        itemBuilder: (BuildContext context, int index) {
          return OrderDetails(
              orderNumber: _orderProvider.pastOrders[index]['order_number'],
              storeName: _orderProvider.pastOrders[index]['store']['name'],
              price:
                  _orderProvider.pastOrders[index]['final_amount'].toString(),
              button: ButtonOrderWidget(
                  // text: translation(context).pending_title,
                  text: "Pending",
                  onClicked: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PendingOrdersScreen(orderIndex: index)));
                  }));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}

class CompletedOrdersList extends StatelessWidget {
  const CompletedOrdersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(children: [
        OrderDetails(
          orderNumber: 'RB9183892184',
          storeName: 'SHEIN',
          price: '300',
          button: ButtonOrderWidget(
              // text: translation(context).completed_title, onClicked: () {}),
              text: "Completed", onClicked: () {}),
        ),
      ]),
    );
  }
}

class OrderDetails extends StatelessWidget {
  final String orderNumber;
  final String storeName;
  final Widget button;
  final String price;
  const OrderDetails({
    Key? key,
    required this.orderNumber,
    required this.storeName,
    required this.button,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: COLOR_GREY,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderNumber,
                  style: kSubStyle.copyWith(
                      color: COLOR_BLACK, fontWeight: FontWeight.w600),
                ),
                button
              ],
            ),
            Text(
              storeName,
              style: kSubStyle.copyWith(color: COLOR_BLACK),
            ),
            addVerticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SAR$price',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: COLOR_PURPLE),
                ),
                Text('2022/8/17'),
              ],
            ),
          ],
        ));
  }
}

class ButtonOrderWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonOrderWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(COLOR_BLACK),
          // backgroundColor: text == translation(context).pending_title
          backgroundColor: text == "Pending"
              ? MaterialStateProperty.all<Color>(COLOR_YELLOW)
              : MaterialStateProperty.all<Color>(COLOR_GREEN),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: COLOR_WHITE,
              fontSize: 16.sp,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
      );
}

// void goToOrderDetails(context) => Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const OrderDetailsScreen()),
//     );

// void goToPendingOrders(context) => 
//     );
