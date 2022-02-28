import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:core';

// THIRD PARTY PACKAGES
import 'package:http/http.dart';

class SearchResults extends ChangeNotifier {
  List _searchResults = [];
  var filterApplied;
  var _filteredResult = [];
  get _getFilteredResult => _filteredResult;

  Future getFilteredResults() async {
    var data = await _getFilteredResult;
    return data;
  }

  Future fetchResults(
      {searchTerm, category, platform, price, availability, sortBy}) async {
    String baseUrl = 'https://gamestreet-api.herokuapp.com';

    Map body = {
      'category': category == null ? '' : category,
      'availability': availability == null ? '' : availability,
      'price': price == null ? '' : price,
      'platform': platform == null ? '' : platform
    };

    // Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    Map<String, String> postHeader = {'Content-Type': 'application/json'};

    var response = await post(Uri.parse('$baseUrl/api/products/search'),
        body: encodedBody, headers: postHeader);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // V.IMPORTANT: EMPTY '_filteredResult' ALWAYS whether using first time.
      // FILTERS or second time. We NEED to EMPTY the 'filteredResult' so that it is
      // populated with the NEW results based on the FILTERS applied.
      _filteredResult.clear();
      _searchResults.clear();
      for (var eachProduct in responseData) {
        // If product IS from 'games' category
        if (eachProduct['category'] == 'games') {
          var newGame = {
            'productTitle': eachProduct['name'].toString(),
            'productPrice': eachProduct['price'].toString(),
            'productImage': eachProduct['box_art'].toString(),
            'productCategory': eachProduct['category'].toString(),
            'productId': eachProduct['_id'].toString(),
          };
          // Add 'GAME' to '_searchResults'
          _searchResults.add(newGame);
        } else {
          // If product is NOT from 'games' category
          var formattedImageString = eachProduct['productImages']
              .toString()
              .substring(1, eachProduct['productImages'].toString().length - 1);
          var newProduct = {
            'productTitle': eachProduct['title'].toString(),
            'productPrice': eachProduct['price'].toString(),
            'productImage': formattedImageString,
            'productCategory': eachProduct['category'].toString(),
            'productId': eachProduct['_id'].toString(),
          };
          // Add 'NEW PRODUCT' to '_searchResults'
          _searchResults.add(newProduct);
        }
      }

      // If no 'search term' provided, return results as is.
      if (searchTerm == null) {
        // RETURN 'UNFILTERED RESULT' since NO SEARCH TERM
        print('SEARCH RESULT: ${_searchResults.length}');
        // notifyListeners();
        return _searchResults;
      }

      // FILTER by 'SEARCH TERM', if 'search term' provided
      List searchFiltered = [];
      var regex = RegExp(searchTerm, caseSensitive: false);
      // _searchResults.length > 0 &&
      if (searchTerm != null) {
        for (var eachProduct in _searchResults) {
          var result = regex.hasMatch(eachProduct['productTitle']);
          if (result == true) {
            searchFiltered.add(eachProduct);
          }
        }
        // RETURN based on 'SEARCH TERM'
        return searchFiltered;
      }
    } else {
      print('ERROR - Status Code:${response.statusCode}');
    }
  }

  Future fetchFilteredResults(
      {category, platform, price, availability, filtersApplied}) async {
    // NOTE: 'filtersApplied' is a 'BOOLEAN' check to ensure that the parameters
    // were set from the 'bottomSheet Widget' when 'FILTER' is tapped. This 'filtersApplied' is used
    // in an IF condition later on.
    filterApplied = filtersApplied == true ? true : false;

    String baseUrl = 'https://gamestreet-api.herokuapp.com';

    Map body = {
      'category': category == null ? '' : category,
      'availability': availability == null ? '' : availability,
      'price': price == null ? '' : price,
      'platform': platform == null ? '' : platform
    };

    // Convert 'body' Map to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    Map<String, String> postHeader = {'Content-Type': 'application/json'};

    var response = await post(Uri.parse('$baseUrl/api/products/search'),
        body: encodedBody, headers: postHeader);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // V.IMPORTANT: EMPTY '_filteredResult' ALWAYS whether first time using
      // FILTERS or second time. We NEED to EMPTY the 'filteredResult' so that it is
      // populated with the NEW results based on the FILTERS applied.
      _filteredResult.clear();
      _searchResults.clear();
      for (var eachProduct in responseData) {
        // If product IS from 'games' category
        if (eachProduct['category'] == 'games') {
          var newGame = {
            'productTitle': eachProduct['name'].toString(),
            'productPrice': eachProduct['price'].toString(),
            'productImage': eachProduct['box_art'].toString(),
            'productCategory': eachProduct['category'].toString(),
            'productId': eachProduct['_id'].toString(),
          };
          // Add 'GAME' to '_filteredResults'
          _filteredResult.add(newGame);
        } else {
          // If product is NOT from 'games' category
          var formattedImageString = eachProduct['productImages']
              .toString()
              .substring(1, eachProduct['productImages'].toString().length - 1);
          var newProduct = {
            'productTitle': eachProduct['title'].toString(),
            'productPrice': eachProduct['price'].toString(),
            'productImage': formattedImageString,
            'productCategory': eachProduct['category'].toString(),
            'productId': eachProduct['_id'].toString(),
          };
          // Add 'NEW PRODUCT' to '_filteredResult'
          _filteredResult.add(newProduct);
        }
      }

      // RETURN 'FILTERED RESULT'
      notifyListeners();
      return _filteredResult;
    } else {
      print('ERROR - Status Code:${response.statusCode}');
    }
  }
}
