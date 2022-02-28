import 'dart:convert';
import 'package:flutter/foundation.dart';

// THIRD PARTY PACKAGES
import 'package:http/http.dart';

class CartItemsData extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItemsList = [];

//  Total Calculation related
  int _subtotalQuantity = 0;
  int _subtotalPrice = 0;
  int _deliveryCharge = 25;
  String _deliveryMethod = '';
  int _estdTaxPrice = 0;
  int _totalPrice = 0;

  // Shipping Address related
  var _shippingAddress = {};

// GETTERS
  List get getAllItems => _cartItemsList;
  int get getSubtotalQuantity => _subtotalQuantity;
  int get getSubtotalPrice => _subtotalPrice;
  int get getEstdTaxPrice => _estdTaxPrice;
  int get getTotalPrice => _totalPrice;

  void addCartItems(itemId, itemName, itemPrice, itemDescription, itemImage,
      itemPlatform, itemQuantity, itemEdition, itemCondition, itemCategory) {
// Empty Duplicate LIST
    List duplicates = [];
    // Get Duplicate Item using 'for-in loop'
    for (var eachItem in _cartItemsList) {
      // If duplicate ID matches with the product, that is being added to the cart
      // from the 'SingleGame' Screen, then:
      if (eachItem['itemId'] == itemId) {
        // Add to Duplicates 'LIST'
        duplicates.add(eachItem);
        // Look for item using 'index' in 'cartItemsList' LIST
        // Then SPREAD, contents of that ITEM/MAP
        // And only modify the 'qty' and 'edition'
        // Since they're only 2 things a USER can change/modify
        // i.e. IF the item already exists in the DUPLICATE LIST
        _cartItemsList[_cartItemsList.indexOf(eachItem)] = {
          ...eachItem,
          'qty': itemQuantity,
          'edition': itemEdition,
          // 'itemQuantity': itemQuantity,
          // 'itemEdition': itemEdition,
        };
      }
    }

// If NO DUPLICATES EXIST, add a NEW PRODUCT to the '_cartItemsList'
    if (duplicates.length == 0) {
      // NOTE: These 'property names' are REQUIRED as per the 'orderModel.js'.
      // This is why the property names that DO NOT match with the 'Model' have been changed.
      // Those which were used before are greyed out.
      // If you do not follow this way, the ORDER will NOT be placed at all and won't be posted on the 'DB'.
      var newItem = {
        'itemDescription': itemDescription,
        'itemImage': itemImage,
        'product': itemId,
        'name': itemName,
        'price': itemPrice,
        'platform': itemPlatform,
        'qty': itemQuantity,
        'edition': itemEdition,
        'condition': itemCondition,
        'category': itemCategory,
        'image': itemImage
        // 'itemId': itemId,
        // 'itemName': itemName,
        // 'itemPrice': itemPrice,
        // 'itemPlatform': itemPlatform,
        // 'itemQuantity': itemQuantity,
        // 'itemEdition': itemEdition,
        // 'itemCondition': itemCondition,
        // 'itemCategory': itemCategory
        // 'itemImage': itemImage,
      };
      // Add Item to Cart
      _cartItemsList.add(newItem);
      // Notify all 'Listeners'
      notifyListeners();
    }
  }

  void removeCartItems(dynamic item) {
    _cartItemsList.remove(item);
    notifyListeners();
  }

  void cartCalculations({deliveryMethod}) {
    // ORDER SUMMARY - CALCULATIONS
    List itemPrices = [0];
    List itemQuantities = [0];

    for (var each in _cartItemsList) {
      var quantity = int.parse(each['qty']);
      itemQuantities.add(quantity);
      var price = each['price'];
      itemPrices.add(price * quantity);
    }

    _subtotalPrice = itemPrices.reduce((a, b) => a + b);
    _subtotalQuantity = itemQuantities.reduce((a, b) => a + b);

// 'Tax' and 'Total' amount calculation
    _estdTaxPrice = (_subtotalPrice * 0.05).ceil();
    if (deliveryMethod == "premium") {
      // Set Delivery Method
      _deliveryMethod = deliveryMethod;
      // TAX applied to 'subPrice' & 'delivery charge'
      _estdTaxPrice = ((_subtotalPrice + _deliveryCharge) * 0.05).ceil();
      // Total = 'Subtotal' + 'Delivery charge' +'Tax on subtotal & delivery charge'
      _totalPrice = _subtotalPrice + _estdTaxPrice + _deliveryCharge;
    } else {
      // Set Delivery Method
      _deliveryMethod = 'standard';
      // Total excludes 'premium' delivery charge and 'tax' on 'premium' delivery charge
      _totalPrice = _subtotalPrice + _estdTaxPrice;
    }
  }

  void saveShippingAddress(
      {required String fName,
      required String lName,
      required String address,
      required String city,
      required dynamic number}) {
    _shippingAddress = {
      'fName': fName,
      'lName': lName,
      'streetAddress': address,
      'city': city,
      'number': number.toString(),
      'deliveryMethod': _deliveryMethod
    };
  }

  Future<void> placeOrder({userInfo, cartItems}) async {
    Map body = {
      'user': userInfo['_id'],
      'orderItems': cartItems,
      'shippingAddress': _shippingAddress,
      'paymentMethod': "Credit Card",
      'subtotalPrice': getSubtotalPrice,
      'taxPrice': getEstdTaxPrice,
      'shippingPrice': _deliveryMethod == 'premium' ? 25 : 0,
      'totalPrice': getTotalPrice,
    };

    // Send data to server
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

// Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    var postHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userInfo['token']}'
    };

// POSTED 'ORDER' to BACKEND. No need to ENCODE it any further.
    var response = await post(Uri.parse('$baseUrl/api/orders'),
        headers: postHeader, body: encodedBody);

    // _order = jsonEncode(response.body);

    notifyListeners();
  }

  void emptyCart() {
    _cartItemsList = [];
    notifyListeners();
  }
}
