import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yammpay/models/bank.dart';
// import 'package:yamm_refund/models/address.dart';
// import 'package:yamm_refund/models/delivery.dart';
import 'package:yammpay/models/item.dart';
import 'package:yammpay/models/order.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:yammpay/models/merchant.dart';
import 'package:yammpay/models/reaosn.dart';
import 'package:yammpay/models/return_order.dart';
import 'package:yammpay/services/order_survices.dart';

class OrderProvider extends ChangeNotifier {
  String method = "email";
  String selectedStoreName = "Stores";
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  late Order order;
  List<Item> items = [];
  double total = 0;
  late List<Reason> reasons = [];
  List<Merchant> stores = [];
  late Merchant chosenStore;
  Bank? chosenBank;
  // Address? chosenAddress;
  // Delivery? chosenCarrier;

  late ReturnOrder returnedOrder;

  // int agreement_id = 1;
  int bank_id = 1;
  String order_number = '';

  List<ItemId> itemsId = [];
  List<dynamic> pastOrders = [];

  Future<void> postCheckOrder(String order_id,
      {String email = "empty", String phone_number = "empty"}) async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    http.Response response = (await OrderServices().checkOrder(
        order_id, chosenStore.id, method,
        email: email, phone_number: phone_number))!;
    final jsonResponse = jsonDecode(response.body);
    log(order_id);
    log(chosenStore.id);
    log(phone_number);
    if (response.statusCode == 200) {
      hasError = false;
      order = Order.fromJson(jsonResponse['records']);
    } else {
      hasError = true;
      errorMessage = jsonResponse["errors"][0]["message"];
    }
    isLoading = false;
    notifyListeners();
  }

  // Future<void> postCreateOrder() async {
  //   isLoading = true;
  //   hasError = false;
  //   notifyListeners();
  //   ReturnOrder order = ReturnOrder(
  //       order_number: order_number,
  //       store_id: store_id,
  //       agreement_id: agreement_id,
  //       bank_id: bank_id,
  //       items: itemsId);

  //   http.Response response = (await OrderServices().refundOrder(order))!;
  //   final jsonResponse = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     hasError = false;
  //   } else {
  //     hasError = true;
  //     errorMessage = jsonResponse["errors"][0]["message"];
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  getReasons() async {
    isLoading = true;
    reasons = (await OrderServices().returnReasons());
    isLoading = false;
    notifyListeners();
  }

  switchVerfiyMethod() {
    isLoading = true;
    method = chosenStore.verification_method;
    selectedStoreName = chosenStore.name;
    isLoading = false;
    notifyListeners();
  }

  getStores() async {
    isLoading = true;
    stores = (await OrderServices().returnStores());
    isLoading = false;
    notifyListeners();
  }

  // getPastOrders() async {
  //   isLoading = true;
  //   pastOrders = (await OrderServices().returnPastOrders());
  //   isLoading = false;
  //   notifyListeners();
  // }

  void addItem(String id) {
    log(total.toString());
    Item item = order.items.firstWhere((element) => element.id == id);
    items.add(item);
    total += item.price;
    log(total.toString());
    notifyListeners();
  }

  void removeItem(String id) {
    Item item = items.firstWhere((element) => element.id == id);
    items.remove(item);
    total -= item.price;
    log(total.toString());
    notifyListeners();
  }

  // void addItemsId() {
  //   for (int i = 0; i < items.length; i++) {
  //     itemsId.add(
  //         ItemId(product_id: items[i].productId, quantity: 1, reason_id: 1));
  //   }
  // }

  // void clearData() {
  //   if (items.isNotEmpty) {
  //     items.clear;
  //     total = 0;
  //     order_number = '';
  //     store_id = '';
  //     itemsId.clear;
  //     notifyListeners();
  //   }
  // }
}
