import 'package:flutter/material.dart';

// Local Packages
import 'package:game_street/class/products.dart';
import 'package:game_street/class/cart_items.dart';
import 'package:game_street/components/productSlider.dart';
import 'package:game_street/components/added_to_cart_bottom_modal.dart';

// 3rd Party Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:group_button/group_button.dart';

class SingleProduct extends StatefulWidget {
  @override
  _SingleProductState createState() => _SingleProductState();
  final productType;
  final productId;
  SingleProduct({this.productType, this.productId});
}

class _SingleProductState extends State<SingleProduct> {
  // REQUIRED FIELDS
  var productDetails;
  String qty = '1';
  String edition = '';
  String condition = '';
  var splitFeatures = [];
  bool error = false;
  bool receivedData = false;

  void fetchData() async {
    var data = await Products().fetchSingleProductData(
        productId: widget.productId, productType: widget.productType);
    setState(() {
      productDetails = data;
      splitFeatures = productDetails.itemProductFeatures.split('|');
      receivedData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // Calculation: Loader Padding Top Height
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = AppBar().preferredSize.height;
    double bodyHeight = MediaQuery.of(context).size.height;
    double finalPadding = bodyHeight - (statusbarHeight + appBarHeight);

    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: receivedData == false
                    ? Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: finalPadding * 0.40),
                            child: SpinKitFadingCube(
                              color: Colors.white,
                              size: 40,
                            )),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductSlider(productDetails.itemProductImages),
                          SizedBox(
                            height: 25.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productDetails.itemTitle,
                                style: TextStyle(
                                    fontFamily: 'FiraSans-Medium',
                                    fontSize: 26.0,
                                    color: Color(0xffffffff)),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                productDetails.itemCountInStock == 0
                                    ? 'Out of Stock'
                                    : 'AED ${productDetails.itemPrice}.00',
                                style: TextStyle(
                                    fontFamily: 'FiraSans-Medium',
                                    fontSize: 20.0,
                                    color: productDetails.itemCountInStock >= 1
                                        ? Color(0xff20b830)
                                        : Color(0xffdc143c)),
                              ),

                              productDetails.itemCountInStock == 0
                                  ? Divider(
                                      height: 24.0,
                                      color: Color(0xffa0a0a0),
                                    )
                                  : Divider(
                                      height: 50.0,
                                      color: Color(0xffa0a0a0),
                                    ),

                              productDetails.itemCountInStock == 0
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // QUANTITY
                                        Text('Quantity',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white)),

                                        DropdownButton<String>(
                                          value: qty,
                                          style: TextStyle(color: Colors.white),
                                          dropdownColor: Color(0xff151515),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              qty = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5'
                                          ]
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                      DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      ))
                                              .toList(),
                                        ),

                                        Divider(
                                          height: 50.0,
                                          color: Color(0xffa0a0a0),
                                        ),
                                        // EDITION
                                        Text('Edition',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white)),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        GroupButton(
                                          isRadio: true,
                                          spacing: 15,
                                          selectedColor: Colors.white,
                                          selectedTextStyle: TextStyle(
                                              color: Color(0xff151515)),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          unselectedColor: Colors.transparent,
                                          unselectedTextStyle:
                                              TextStyle(color: Colors.white),
                                          unselectedBorderColor: Colors.white,
                                          buttons: ['Standard', 'Collectors'],
                                          onSelected: (index, isSelected) => {
                                            setState(() {
                                              edition = index == 0
                                                  ? 'Standard'
                                                  : 'Collectors';
                                            })
                                          },
                                        ),

                                        Divider(
                                          height: 50.0,
                                          color: Color(0xffa0a0a0),
                                        ),
                                        // CONDITION
                                        Text('Condition',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white)),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        GroupButton(
                                          isRadio: true,
                                          selectedColor: Colors.white,
                                          selectedTextStyle: TextStyle(
                                              color: Color(0xff151515)),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          unselectedColor: Colors.transparent,
                                          unselectedTextStyle:
                                              TextStyle(color: Colors.white),
                                          unselectedBorderColor: Colors.white,
                                          buttons: ['New'],
                                          onSelected: (index, isSelected) => {
                                            setState(() {
                                              condition =
                                                  index == 0 ? 'New' : '';
                                            })
                                          },
                                        ),

                                        SizedBox(
                                          height: 25,
                                        ),

                                        // ADD TO CART BUTTON
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50.0,
                                          child: ElevatedButton(
                                            autofocus: false,
                                            clipBehavior: Clip.none,
                                            onPressed: () {
                                              if (edition == '' ||
                                                  condition == '') {
                                                setState(() {
                                                  error = true;
                                                });
                                              } else {
                                                // Set Error to 'false'
                                                error = false;
                                                // Add Item to 'Cart'
                                                Provider.of<CartItemsData>(
                                                        context,
                                                        listen: false)
                                                    .addCartItems(
                                                        productDetails.itemId,
                                                        productDetails
                                                            .itemTitle,
                                                        productDetails
                                                            .itemPrice,
                                                        productDetails
                                                            .itemProductDescription,
                                                        productDetails
                                                                .itemProductImages[
                                                            0],
                                                        productDetails
                                                            .itemPlatform,
                                                        qty,
                                                        edition,
                                                        condition,
                                                        productDetails
                                                            .itemCategory);
                                                // Open 'Bottom Modal' to provide routing option
                                                showModalBottomSheet(
                                                    enableDrag: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        CartBottomModal(
                                                            itemImage:
                                                                productDetails
                                                                        .itemProductImages[
                                                                    0],
                                                            itemName:
                                                                productDetails
                                                                    .itemTitle));
                                              }
                                            },
                                            child: Text(
                                              "ADD TO CART",
                                              style: TextStyle(
                                                  fontFamily: 'FiraSans-Medium',
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xff20b830))),
                                          ),
                                        ),

                                        // ERROR CHECK
                                        error == true
                                            ? Center(
                                                child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  'Ensure all the above fields are selected',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'FiraSans-Medium',
                                                      fontSize: 14.0,
                                                      color: Colors
                                                          .pinkAccent[400]),
                                                ),
                                              ))
                                            : SizedBox(height: 0),

                                        SizedBox(
                                          height: 50.0,
                                        ),
                                      ],
                                    ),

                              // DESCRIPTION SECTION
                              Text(
                                "Product Description",
                                style: TextStyle(
                                    fontFamily: 'FiraSans-Medium',
                                    fontSize: 26.0,
                                    color: Color(0xffffffff)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('${productDetails.itemProductDescription}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Lato-Regular',
                                      color: Color(0xffb4b4b4),
                                      fontSize: 18.0,
                                      height: 1.5)),
                              SizedBox(height: 30.0),

                              // FEATURES SECTION
                              Text(
                                "Product Features",
                                style: TextStyle(
                                    fontFamily: 'FiraSans-Medium',
                                    fontSize: 26.0,
                                    color: Color(0xffffffff)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              for (var eachFeature in splitFeatures)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(eachFeature,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Lato-Regular',
                                          color: Color(0xffb4b4b4),
                                          fontSize: 18.0,
                                          height: 1.5)),
                                )
                            ],
                          ),
                        ],
                      ))),
      ),
    );
  }
}
