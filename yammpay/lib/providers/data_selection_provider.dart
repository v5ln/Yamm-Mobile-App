import 'dart:core';

import 'package:flutter/material.dart';
import 'package:yammpay/models/item.dart';
// import 'package:yamm_refund/models/item.dart';

class DataSelection extends ChangeNotifier {
  int selectedItem = 0;
  List<Item> items = [];
  double total = 0;
  bool isLoggedin = true;
  bool get authed => isLoggedin;

  void addItem(Item item) {
    items.add(item);
    total += item.price;
    notifyListeners();
  }

  void removeItem(Item item) {
    for (int i = 0; i < items.length; i++) {
      if (item.title == items[i].title) {
        items.removeAt(i);
        total -= item.price;
      }
    }
  }

  double calcTotal() {
    total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].price;
    }
    notifyListeners();
    return total;
  }
}
