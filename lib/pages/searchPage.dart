import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/search.dart';
import 'package:game_street/pages/Singlegame.dart';
import 'package:game_street/pages/Singleproduct.dart';
import 'package:game_street/components/bottom_modal_filter.dart';
import 'package:game_street/components/bottom_modal_sort.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final searchTerm;
  // 'productCategory' as 'backendCategory' from 'HomeGridItem.dart'
  final productCategory;
  // 'productCategory' as 'backendPlatform' from 'HomeGridItem.dart'
  final productPlatform;
  SearchPage({this.searchTerm, this.productCategory, this.productPlatform});
}

class _SearchPageState extends State<SearchPage> {
  var result = [];
  var sortByValue = "PriceH2L";
  var filteredCategory;
  var filteredPrice;
  var filteredAvailability;
  var filteredPlatform;

  void fetchResults() async {
    var data = await SearchResults().fetchResults(
        searchTerm: widget.searchTerm,
        category: widget.productCategory,
        platform: widget.productPlatform);

    // 'container' takes the 'data'
    var container = [];
    setState(() {
      container = data;
    });
    // 1st, sort (desc. order) 'container' on 'productPrice' basis
    container.sort((b, a) => a['productPrice'].compareTo(b['productPrice']));
    // 'result' is finally displayed on UI with price in 'desc. order'.
    setState(() {
      result = container;
    });
    // 'result' is sorted on basis of 'productPrice' LENGTH.
    // E.g. if 'desc. order', order is 3-digits, then 2-digits and single digit prices.
    // E.g. if 'asc. order', order is 1-digit, then 2-digits, three digits, etc.
    result.sort(
        (b, a) => a['productPrice'].length.compareTo(b['productPrice'].length));
  }

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

// CATEGORY HANDLER
  dynamic receiveCategoryFromModal(value) {
    setState(() {
      filteredCategory = value;
    });
  }

// PRICE HANDLER
  dynamic receivePriceFromModal(value) {
    setState(() {
      filteredPrice = value;
    });
  }

// AVAILABILITY HANDLER
  dynamic receiveAvailFromModal(value) {
    setState(() {
      filteredAvailability = value;
    });
  }

// PLATFORM HANDLER
  dynamic receivePlatformFromModal(value) {
    setState(() {
      filteredPlatform = value;
    });
  }

  dynamic receiveFilteredResult(filteredResult) {
    setState(() {
      result = filteredResult;
    });
  }

// SORT HANDLER
// Note: For explanation on why we 'sort' 'length', refer to 'fetchResults' in 'initState'.
  void getSortBy(value) {
    var container = [];
    setState(() {
      sortByValue = value;
      container = result;
    });
    if (sortByValue == 'PriceH2L') {
      // Sort 'price' in 'DESCENDING' ORDER
      container.sort((b, a) => a['productPrice'].compareTo(b['productPrice']));
      container.sort((b, a) =>
          a['productPrice'].length.compareTo(b['productPrice'].length));
      setState(() {
        result = container;
      });
    } else if (sortByValue == 'PriceL2H') {
      // Sort 'price' in 'ASCENDING' ORDER
      container.sort((a, b) => a['productPrice'].compareTo(b['productPrice']));
      container.sort((a, b) =>
          a['productPrice'].length.compareTo(b['productPrice'].length));
      setState(() {
        result = container;
      });
    }
  }

  // PRODUCT CATEGORY CHECK in 'INKWELL' 'onTap' gesture detector
  void ifChecks(index) {
    if (result[index]['productCategory'] == 'games') {
      var route = MaterialPageRoute(
          builder: (context) =>
              SingleGame(productId: result[index]['productId']));
      Navigator.of(context).push(route);
    } else if (result[index]['productCategory'] == 'consoles') {
      var route = MaterialPageRoute(
          builder: (context) => SingleProduct(
                productType: 'consoles',
                productId: result[index]['productId'],
              ));
      Navigator.of(context).push(route);
    } else if (result[index]['productCategory'] == 'accessories') {
      var route = MaterialPageRoute(
          builder: (context) => SingleProduct(
                productType: 'accessories',
                productId: result[index]['productId'],
              ));
      Navigator.of(context).push(route);
    } else if (result[index]['productCategory'] == 'merchandises') {
      var route = MaterialPageRoute(
          builder: (context) => SingleProduct(
                productType: 'merchandises',
                productId: result[index]['productId'],
              ));
      Navigator.of(context).push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff151515),
        appBar: AppBar(
            title: Text('Search Results'),
            backgroundColor: Colors.transparent,
            centerTitle: true),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // FILTER ROW
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      print("FILTER TAPPED");
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => BottomModalFilter(
                              sendCategory: receiveCategoryFromModal,
                              sendPrice: receivePriceFromModal,
                              sendAvailability: receiveAvailFromModal,
                              sendPlatform: receivePlatformFromModal,
                              sendFilteredResult: receiveFilteredResult));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.filter_alt_sharp,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text('Filter',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'FiraSans-Medium',
                                  fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("SORT TAPPED");
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              BottomModalSort(sendSort: getSortBy));
                    },
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_list_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                              'Price ${sortByValue == "PriceH2L" ? "(Highest to Lowest)" : "(Lowest to Highest)"}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'FiraSans-Medium',
                                  fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                ]),

                Divider(
                  height: 30,
                  color: Color(0xffa0a0a0),
                ),

                // PRODUCTS GRID
                result.length == 0
                    ? Text(
                        'Showing ${result.length} products',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FiraSans-Medium',
                            fontSize: 15.5),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Showing ${result.length} ${result.length > 1 ? "products" : "product"}',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'FiraSans-Medium',
                                fontSize: 15.5),
                          ),
                          SizedBox(height: 15.0),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: result.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 25),
                                  child: InkWell(
                                    onTap: () {
                                      ifChecks(index);
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            child: Image.asset(
                                              'assets${result[index]['productImage']}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 10, 7),
                                              child: Text(
                                                result[index]['productTitle'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'FiraSans-Medium',
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 10),
                                              child: Text(
                                                int.parse(result[index]
                                                            ['productPrice']) ==
                                                        0
                                                    ? 'TBA'
                                                    : 'AED ${result[index]['productPrice']}.00',
                                                style: TextStyle(
                                                    color: Color(0xff20b830),
                                                    fontFamily:
                                                        'FiraSans-Medium',
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      )
              ]),
        )));
  }
}
