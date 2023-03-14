// import 'dart:core';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class DeliveryServices {
//   static final baseURL = 'https://api.yammpay.com/customer';
//   static final shippingConpaniesEndPoint = '/shippingCompanies';

//   Future<http.Response?> deliveryCompanies(
//       String address_id, String store_id) async {
//     http.Response? response;
//     var prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');

//     try {
//       response = await http.post(
//         Uri.parse(baseURL + shippingConpaniesEndPoint),
//         body: {
//           "address_id": address_id,
//           "store_id": store_id,
//         },
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//     return response;
//   }
// }
