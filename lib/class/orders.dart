import 'package:flutter/foundation.dart';
import 'dart:convert';

// THIRD PARTY PACKAGES
import 'package:http/http.dart';

class Order extends ChangeNotifier {
  var _orders;
  var _orderDetails;

  dynamic get getOrders => _orders;
  dynamic get getOrderDetails => _orderDetails;

  Future fetchOrders(userInfo) async {
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userInfo['token']}'
    };

    var response = await get(
        Uri.parse(
          '$baseUrl/api/orders/myorders',
        ),
        headers: headers);

    _orders = jsonDecode(response.body);

    notifyListeners();
    return _orders;
  }

  Future fetchSingleOrderDetails({userInfo, orderId}) async {
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userInfo['token']}'
    };

    var response = await get(
        Uri.parse(
          '$baseUrl/api/orders/$orderId',
        ),
        headers: headers);

    _orderDetails = jsonDecode(response.body);

    return _orderDetails;
  }
}
