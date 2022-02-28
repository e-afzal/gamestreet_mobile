import 'package:flutter/foundation.dart';

// LOCAL PACKAGES
import 'dart:convert';
import 'package:game_street/models/cart_item_products.dart';

// THIRD PARTY PACKAGES
import 'package:http/http.dart';

class Products extends ChangeNotifier {
  Future<dynamic> fetchSingleProductData({productType, productId}) async {
    var responseData;
    var productData;
    String baseUrl = 'https://gamestreet-api.herokuapp.com';
    Response response =
        await get(Uri.parse('$baseUrl/api/products/$productType/$productId'));
    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
      productData = CartItemProduct(
        itemPrice: responseData['price'],
        itemCountInStock: responseData['countInStock'],
        itemRating: responseData['rating'],
        itemNumReviews: responseData['numReviews'],
        itemProductImages: responseData['productImages'],
        itemId: responseData['_id'],
        itemTitle: responseData['title'],
        itemProductDescription: responseData['productDescription'],
        itemProductFeatures: responseData['productFeatures'],
        itemPlatform: responseData['platform']['name'],
        itemCategory: responseData['category'],
        itemSubCategory: responseData['subCategory'],
      );
      return productData;
    } else {
      print('Status ${response.statusCode} - Unable to fetch Console Data');
    }
  }
}
