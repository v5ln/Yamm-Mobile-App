import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';

class OrderDetailCard extends StatelessWidget {
  final String itemName, imgPath;
  final int itemPrice;
  final int status;
  const OrderDetailCard(
      {Key? key,
      required this.itemName,
      required this.itemPrice,
      required this.status,
      required this.imgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: COLOR_WHITE,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ItemStatus(status: status),
        Row(children: [
          Container(
            height: 120.h,
            width: 120.w,
            child: Image.network(imgPath),
          ),
          addHorizontalSpace(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(10.h),
                RichTextWidget(
                  title: 'Item name: ',
                  conent: itemName,
                ),
                addVerticalSpace(10.h),
                RichTextWidget(
                  title: 'Item Price: ',
                  conent: 'SAR$itemPrice',
                ),
                addVerticalSpace(10.h),
                RichTextWidget(
                  title: 'Reason of return: ',
                  conent: 'Other',
                ),
                addVerticalSpace(10.h),
              ],
            ),
          )
        ]),
        status == 2
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: RichTextWidget(
                  title: 'Reason of rejection: ',
                  conent: 'THE ITEM(s) ARE DAMAGED!',
                ),
              )
            : Text(''),
      ]),
    );
  }
}

class ItemStatus extends StatelessWidget {
  const ItemStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  final int status;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: status == 3
            ? Text(
                'Pending',
                style: kItemReturnedStatusStyle.copyWith(color: COLOR_YELLOW),
              )
            : status == 2
                ? Text('Rejected',
                    style: kItemReturnedStatusStyle.copyWith(color: COLOR_PINK))
                : Text('Accepted',
                    style:
                        kItemReturnedStatusStyle.copyWith(color: COLOR_GREEN)));
  }
}

class RichTextWidget extends StatelessWidget {
  final String title, conent;
  const RichTextWidget({
    Key? key,
    required this.title,
    required this.conent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$title',
          style: TextStyle(
              color: COLOR_BLACK.withOpacity(0.9),
              fontWeight: FontWeight.w300)),
      TextSpan(
        text: '$conent',
        style: TextStyle(
            color: COLOR_BLACK, fontWeight: FontWeight.w500, fontSize: 15.sp),
      ),
    ]));
  }
}
