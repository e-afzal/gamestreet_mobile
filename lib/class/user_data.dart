// LOCAL PACKAGES
import 'package:flutter/foundation.dart';
import 'dart:convert';

// THIRD PARTY PACKAGES
import 'package:http/http.dart';

class UserData extends ChangeNotifier {
  Map<String, dynamic> _userInfo = {};

  Map get getUserInfo => _userInfo;

  Future<dynamic> addNewUser(
    fName,
    lName,
    email,
    contactNumber,
    password,
  ) async {
    // Create new user account
    Map body = {
      'fName': fName,
      'lName': lName,
      'email': email,
      'number': contactNumber.toString(),
      'password': password,
    };

// Send data to server
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

// Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    Map<String, String> postHeader = {'Content-Type': 'application/json'};

// Send 'POST' request
    var response = await post(Uri.parse('$baseUrl/api/users'),
        headers: postHeader, body: encodedBody);

    // All User related details AFTER REGISTRATION saved to '_userInfo' to be used in
    // frontend/app.
    // NOTE: If duplicate email is used, you'll get an ERROR from the BACKEND as 'error' object
    // which contains the 'message' property containing the 'error' message
    _userInfo = jsonDecode(response.body);

    // Notify all listeners
    notifyListeners();

    return _userInfo;
  }

  Future<dynamic> loginUser(email, password) async {
    // User Info for login
    Map body = {
      'email': email,
      'password': password,
    };

// Send data to server
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

// Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    Map<String, String> postHeader = {'Content-Type': 'application/json'};

// Send 'POST' request
    var response = await post(Uri.parse('$baseUrl/api/users/login'),
        headers: postHeader, body: encodedBody);

    // All User related details AFTER REGISTRATION saved to '_userInfo' to be used in
    // frontend/app.
    // NOTE: If duplicate email is used, you'll get an ERROR from the BACKEND as 'error' object
    // which contains the 'message' property containing the 'error' message
    _userInfo = jsonDecode(response.body);

    // Notify all listeners
    notifyListeners();

    return _userInfo;
  }

  Future<dynamic> updatePersonalDetails({id, fName, lName, email}) async {
    Map body = {
      'id': _userInfo['_id'],
      'fName': fName.length >= 2 ? fName : _userInfo['fName'],
      'lName': lName.length >= 2 ? lName : _userInfo['lName'],
      'email': email.length >= 2 ? email : _userInfo['email'],
    };

    // Send data to server
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

// Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    var postHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_userInfo['token']}'
    };

    var response = await put(
        Uri.parse('$baseUrl/api/users/profile/personalDetails'),
        headers: postHeader,
        body: encodedBody);

    // _userInfo = jsonEncode(response.body);

    notifyListeners();
  }

  Future<dynamic> updateDeliveryAddress(
      {id, streetAddress, zipCode, city, number}) async {
    Map body = {
      'id': _userInfo['_id'],
      'streetAddress': streetAddress.length >= 2
          ? streetAddress
          : _userInfo['streetAddress'],
      'zipCode':
          zipCode.toString().length == 6 ? zipCode : _userInfo['zipCode'],
      'city': city.length >= 2 ? city : _userInfo['city'],
      'number': number.toString().length >= 2 ? number : _userInfo['number'],
    };

    // Send data to server
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

// Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    var postHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_userInfo['token']}'
    };

    var response = await put(Uri.parse('$baseUrl/api/users/profile/address'),
        headers: postHeader, body: encodedBody);

    var newInfo = jsonEncode(response.body);

    notifyListeners();
  }

  Future<dynamic> updatePassword(newPassword) async {
    Map body = {'id': _userInfo['_id'], 'password': newPassword};

    // Send data to server
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

// Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    var postHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_userInfo['token']}'
    };

    var response = await put(Uri.parse('$baseUrl/api/users/profile/password'),
        headers: postHeader, body: encodedBody);
    // Sending 'response' is not required. But send it anyway.
    notifyListeners();
    return response;
  }

  void logoutUser() {
    _userInfo = {};
  }
}
