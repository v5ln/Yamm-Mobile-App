import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yamm_refund/models/reaosn.dart';
// import 'package:yamm_refund/models/return_order.dart';
import 'package:yammpay/models/merchant.dart';
import 'package:yammpay/models/reaosn.dart';

class OrderServices {
  static const baseURL = 'https://api.yammrefund.com/customer';
  static const checkOrderEndPoint = '/checkOrder';
  static const returnReasonEndPoint =
      'https://api.yammrefund.com/returnReasons';
  static const storesEndPoint = 'https://api.yammrefund.com/stores';
  // static const ordersEndPoint = '/orders';

  Future<http.Response?> checkOrder(
      String order_id, String store_id, String method,
      {String? email, String? phone_number}) async {
    http.Response? response;
    try {
      response = await http.post(
        Uri.parse(baseURL + checkOrderEndPoint),
        body: method == "email"
            ? {"order_id": order_id, "store_id": store_id, "email": email}
            : {
                "order_id": order_id,
                "store_id": store_id,
                "phone_number": phone_number
              },
      );
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<List<Reason>> returnReasons() async {
    List<Reason> reasons = [];
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(returnReasonEndPoint),
        headers: {
          'Content-Type': "application/json",
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        var rest = (jsonResponse['records']) as List;
        reasons = rest.map<Reason>((json) => Reason.fromJson(json)).toList();
      } else {
        log('return reasons error');
      }
    } catch (e) {
      log(e.toString());
    }
    return reasons;
  }

  Future<List<Merchant>> returnStores() async {
    var prefs = await SharedPreferences.getInstance();
    // String? lang = prefs.getString('LanguageCode');
    // lang == 'ar' ? lang = 'en' : lang = 'ar';
    List<Merchant> stores = [];
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(storesEndPoint),
        headers: {
          "Accept-Language": "en",
          'Content-Type': "application/json",
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        var rest = (jsonResponse['records']) as List;
        stores = rest.map<Merchant>((json) => Merchant.fromMap(json)).toList();
        // stores = List<Merchant>.from(jsonResponse.map((model)=> Merchant.fromJson(model)));
        // stores.forEach((element) {print(element);});
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return stores;
  }

// * String order_number, String store_id, int agreement_id, int bank_id, List<ItemId> items
//   Future<http.Response?> refundOrder(ReturnOrder order) async {
//     http.Response? response;
//     var prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     var item = [];
//     for (int i = 0; i < order.items.length; i++) {
//       item.add({
//         "product_id": order.items[i].product_id,
//         "quantity": order.items[i].quantity,
//         "reason_id": order.items[i].reason_id
//       });
//     }
//     var body = jsonEncode({
//       "order_number": order.order_number,
//       "store_id": order.store_id,
//       "agreement_id": order.agreement_id,
//       "bank_id": order.bank_id,
//       "items": item,
//     });
//     try {
//       response = await http.post(
//         Uri.parse(baseURL + ordersEndPoint),
//         body: body,
//         headers: {
//           "Authorization": "Bearer $token",
//           'Content-Type': "application/json",
//         },
//       );
//     } catch (e) {
//       log(e.toString());
//     }

//     return response;
//   }

//   Future<List<dynamic>> returnPastOrders() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     http.Response? response;
//     List<dynamic> orders = [];
//     try {
//       response = await http.get(
//         Uri.parse(baseURL + ordersEndPoint),
//         headers: {
//           "Authorization": "Bearer $token",
//           'Content-Type': "application/json",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         //  orders = PastOrder.fromJson(jsonResponse['data']) as List<PastOrder>?;
//         orders = (jsonResponse['data']) as List;
//         //  print(orders[0]['items'][0]['name']);
//         //  print(orders.length);
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return orders;
//   }
}
