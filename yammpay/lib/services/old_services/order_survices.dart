// import 'dart:convert';
// import 'dart:developer';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yamm_refund/models/reaosn.dart';
// import 'package:yamm_refund/models/return_order.dart';
// import 'package:yamm_refund/models/merchant.dart';

// class OrderServices {
//   static final baseURL = 'https://api.yammpay.com/customer';
//   static final checkOrderEndPoint = '/checkOrder';
//   static final returnReasonEndPoint = 'https://api.yammpay.com/returnReasons';
//   static final storesEndPoint = 'https://api.yammpay.com/stores';
//   static final ordersEndPoint = '/orders';

//   Future<http.Response?> checkOrder(String order_id, String store_id) async {
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');

//     try {
//       response = await http.post(
//         Uri.parse(baseURL + checkOrderEndPoint),
//         body: {"order_id": order_id, "store_id": store_id},
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//     return response;
//   }

//   Future<List<Reason>> returnReasons() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');
//     List<Reason> reasons = [];
//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(returnReasonEndPoint),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//           'Content-Type': "application/json",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         reasons = rest.map<Reason>((json) => Reason.fromJson(json)).toList();
//       } else {
//         print('return reasons error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return reasons;
//   }

//   Future<List<Merchant>> returnStores() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');
//     List<Merchant> stores = [];
//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(storesEndPoint),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//           'Content-Type': "application/json",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         stores = rest.map<Merchant>((json) => Merchant.fromMap(json)).toList();
//       } else {}
//     } catch (e) {
//       log(e.toString());
//     }
//     return stores;
//   }

// // * String order_number, String store_id, int agreement_id, int bank_id, List<ItemId> items
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
// }
