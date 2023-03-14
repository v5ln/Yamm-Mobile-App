import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/providers/bank_provider.dart';
import 'package:yammpay/views/loggedoff_view.dart';
import 'package:yammpay/views/widget/add_new_card.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/loading_widget.dart';
import 'package:yammpay/views/widget/page_layout_widget.dart';
import 'package:yammpay/views/widget/page_title_widget.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({Key? key}) : super(key: key);
  static const String id = '/CardsScreen';
  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  @override
  Widget build(BuildContext context) {
    var _bankProvider = Provider.of<BankProvider>(context);
    return PageLayout(
      child: Column(
        children: [
          // PageTitle(title: translation(context).mycards_title),
          const PageTitle(title: "My Cards"),
          addVerticalSpace(40.h),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: Padding(
                padding: SIDE_PADDING,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListOfBanks(bankProvider: _bankProvider),
                    addVerticalSpace(15.h),
                    AddNewCardWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddNewCardWidget extends StatelessWidget {
  const AddNewCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextButton(
          child: Text(
            '+ Add a new card',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            // _addBankAcount();
            Future.delayed(const Duration(seconds: 0), () {
              addNewCardDialog(context);
            });
          }),
    );
  }
}

class ListOfBanks extends StatelessWidget {
  const ListOfBanks({
    Key? key,
    required BankProvider bankProvider,
  })  : _bankProvider = bankProvider,
        super(key: key);

  final BankProvider _bankProvider;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: const EdgeInsets.all(12),
      borderType: BorderType.RRect,
      radius: Radius.circular(20.r),
      dashPattern: const [20, 20],
      color: COLOR_PURPLE,
      strokeWidth: 2,
      child: _bankProvider.isLoading
          ? Center(child: LoadingSpinner(size: 80.w))
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
              ),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2),
              width: MediaQuery.of(context).size.width,
              child: _bankProvider.banks.isEmpty
                  ? Center(
                      child: buildImage(
                          'https://assets3.lottiefiles.com/packages/lf20_x7qdpjsr.json',
                          200.w),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      primary: true,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      itemCount: _bankProvider.banks.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                            title: Text(
                                '${_bankProvider.banks[index].firstName} ${_bankProvider.banks[index].middleName} ${_bankProvider.banks[index].lastName}'),
                            subtitle: Text(
                              _bankProvider.banks[index].iban,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: COLOR_PURPLE),
                            ),
                            trailing: SizedBox(
                              width: 50.w,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: COLOR_PINK,
                                ),
                                onPressed: (() =>
                                    _bankProvider.deleteBankAccount(
                                        _bankProvider.banks[index].id
                                            .toString())),
                              ),
                            ));
                      }),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
            ),
    );
  }
}
