import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/models/reaosn.dart';
import 'package:yammpay/providers/order_provider.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/loading_widget.dart';
import 'package:yammpay/views/widget/snackbar_widget.dart';

class SelectItemCard extends StatefulWidget {
  final String? title;
  final String? image;
  final bool? isRefundable;
  final int? price;
  final String? variantTitle;
  final String id;

  const SelectItemCard({
    Key? key,
    this.title,
    this.image,
    this.isRefundable = true,
    this.price,
    this.variantTitle,
    required this.id,
  }) : super(key: key);

  @override
  State<SelectItemCard> createState() => _SelectItemCardState();
}

class _SelectItemCardState extends State<SelectItemCard> {
  bool isSelected = false;
  Reason? selectedReason;

  void ChangeState() {
    setState(() {
      var id = widget.id;
      if (widget.isRefundable!) {
        isSelected == false ? isSelected = true : isSelected = false;
        var _orderProvider = Provider.of<OrderProvider>(context, listen: false);
        isSelected == true
            ? _orderProvider.addItem(id)
            : _orderProvider.removeItem(id);
      } else {
        // showActionSnackBar(context, 'You cannot return this item!');
        YammSnackBar.show(
            header: "Try Again", body: 'You cannot return this item!');
      }
    });
  }

  @override
  void initState() {
    final _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.getReasons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    return GestureDetector(
      onTap: () => {ChangeState()},
      // behavior: HitTestBehavior.deferToChild,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12),
        decoration: BoxDecoration(
          color: widget.isRefundable! ? COLOR_PURPLE_OPCITY : COLOR_GREY,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isSelected ? COLOR_PURPLE : COLOR_BLACK.withOpacity(0),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (widget.isRefundable!) ...[
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: Checkbox(
                value: isSelected,
                onChanged: ((value) => ChangeState()),
                checkColor: COLOR_WHITE,
                activeColor: COLOR_PURPLE,
              ),
            ),
            addVerticalSpace(16.sp),
          ],
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FullScreenWidget(
              backgroundColor: COLOR_WHITE.withOpacity(0.2),
              child: Container(
                color: COLOR_WHITE,
                width: 90.w,
                height: 75.h,
                child: Image.network(
                  widget.image ??
                      'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            addHorizontalSpace(32.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title ?? '',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600)),

                //  addVerticalSpace(5.h),
                Text(
                  widget.price.toString(),
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: COLOR_PURPLE),
                ),
                Text(widget.variantTitle ?? '',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
              ],
            )
          ]),
          addVerticalSpace(16.sp),
          const Divider(
            thickness: 2,
          ),
          addVerticalSpace(16.sp),
          widget.isRefundable!
              ? isSelected
                  ? _orderProvider.isLoading
                      ? const Center(child: LoadingSpinner())
                      : DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Choose a reason",
                              fillColor: COLOR_WHITE),
                          style: const TextStyle(color: COLOR_PURPLE),
                          dropdownColor: COLOR_WHITE,
                          isDense: true,
                          isExpanded: true,
                          value: selectedReason,
                          items: _orderProvider.reasons
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.name,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectedReason = item as Reason;
                            log(item.id);
                          }),
                        )
                  : const RefundableText()
              : const NotRefundableText(),
        ]),
      ),
    );
  }
}

class NotRefundableText extends StatelessWidget {
  const NotRefundableText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "This item ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: COLOR_BLACK,
                  fontSize: 16.sp,
                )),
            TextSpan(
              text: 'cannot be refunded',
              style: TextStyle(
                color: COLOR_PINK,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ]),
        ),
        addVerticalSpace(16.h),
        SizedBox(
          width: double.infinity,
          child: BuildButton(
            text: 'More Info',
            onClicked: () {},
            textColor: COLOR_PURPLE,
            buttonnColor: COLOR_WHITE,
          ),
        )
      ],
    );
  }
}

class RefundableText extends StatelessWidget {
  const RefundableText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "This item ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: COLOR_BLACK,
              fontSize: 16.sp,
            )),
        TextSpan(
          text: 'can be refunded',
          style: TextStyle(
            color: COLOR_GREEN,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ]),
    );
  }
}
