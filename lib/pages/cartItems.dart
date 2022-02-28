import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/cart_items.dart';
import 'package:game_street/class/user_data.dart';
import 'package:game_street/pages/shipDetails.dart';
import 'package:game_street/components/bottom_modal_auth.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserData>(context).getUserInfo;
    List cartItems =
        Provider.of<CartItemsData>(context, listen: true).getAllItems;
    Provider.of<CartItemsData>(context).cartCalculations();
    var subtotalQuantity =
        Provider.of<CartItemsData>(context).getSubtotalQuantity;
    var subtotalPrice = Provider.of<CartItemsData>(context).getSubtotalPrice;
    var taxPrice = Provider.of<CartItemsData>(context).getEstdTaxPrice;
    var totalPrice = Provider.of<CartItemsData>(context).getTotalPrice;

    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        title: Text("Cart Items"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: cartItems.length == 0
              ? (CartEmpty())
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Cart Items",
                        style: TextStyle(
                            fontFamily: 'FiraSans-Medium',
                            fontSize: 26.0,
                            color: Color(0xffffffff)),
                      ),

                      SizedBox(
                        height: 25.0,
                      ),

                      // PRODUCT(S)
                      Flexible(
                          fit: FlexFit.loose,
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 1,
                            mainAxisSpacing: 25.0,
                            children: cartItems
                                .map((eachItem) => Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  child: Image.asset(
                                                    'assets${eachItem['itemImage']}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'AED ${eachItem['price'].toString()}.00',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff20b830),
                                                          fontFamily:
                                                              'FiraSans-Medium',
                                                          fontSize: 20.0),
                                                    ),
                                                    SizedBox(height: 7),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Provider.of<CartItemsData>(
                                                                context,
                                                                listen: false)
                                                            .removeCartItems(
                                                                eachItem);
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xffDC143C),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                    SizedBox(
                                                      width: 340,
                                                      child: Text(
                                                          eachItem['name'],
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'FiraSans-Medium')),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Text(
                                                        'Platform: ${eachItem['platform']}',
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color:
                                                                Colors.white)),
                                                    SizedBox(height: 3.0),
                                                    Text(
                                                        'Edition: ${eachItem['edition']}',
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Lato-Regular')),
                                                    SizedBox(height: 3.0),
                                                    Text(
                                                        'Condition: ${eachItem['condition']}',
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Lato-Regular')),
                                                    SizedBox(height: 3.0),
                                                    Text(
                                                        'Quantity: ${eachItem['qty']}',
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Lato-Regular')),
                                                  ]),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )),

                      SizedBox(
                        height: 25.0,
                      ),

                      // ORDER SUMMARY
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text('ORDER SUMMARY',
                                  style: TextStyle(
                                      color: Color(0xffd7d8d7),
                                      fontSize: 26.0,
                                      fontFamily: 'FiraSans-Medium')),
                              SizedBox(height: 20.0),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Subtotal ($subtotalQuantity Item)',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                    Text('AED $subtotalPrice.00',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                  ]),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Charges',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                    Text('FREE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff20b830),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                  ]),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Estimated Tax @ 5%',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                    Text('AED $taxPrice.00',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                  ]),
                              Divider(color: Color(0xffa0a0a0)),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Estimated Total',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                    Text('AED $totalPrice.00',
                                        style: TextStyle(
                                            color: Color(0xffd7d8d7),
                                            fontSize: 15.5,
                                            fontFamily: 'Lato-Regular')),
                                  ]),

                              SizedBox(height: 25.0),

                              // BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton(
                                  autofocus: false,
                                  clipBehavior: Clip.none,
                                  onPressed: () {
                                    print('PROCEED to CHECKOUT TAPPED');
                                    if (userInfo.isEmpty) {
                                      // Open 'Bottom Modal' to provide AUTH options, if
                                      // the user is NOT LOGGED in
                                      showModalBottomSheet(
                                          enableDrag: true,
                                          context: context,
                                          builder: (context) =>
                                              BottomModalAuth());
                                    } else {
                                      // If user LOGGED IN, proceed to 'SHIPPING PAGE'
                                      var routeShip = MaterialPageRoute(
                                          builder: (context) => ShipDetails());
                                      Navigator.push(context, routeShip);
                                    }
                                  },
                                  child: Text(
                                    "PROCEED TO CHECKOUT",
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
                            ],
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

// Show if Cart has ZERO items
class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: .35,
                  child: Image.asset(
                    'assets/Mario_Thinking.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 35.0),
          Text(
            "Your cart is empty",
            style: TextStyle(
                fontFamily: 'FiraSans-Medium',
                fontSize: 26.0,
                color: Color(0xffd0270e)),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Please feel free to look through the catalogue of various gaming products that might be of interest to you:",
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.5,
                fontFamily: 'Lato-Regular',
                fontSize: 18.0,
                color: Color(0xffffffff)),
          ),

          // BUTTON 1
          SizedBox(height: 35.0),
          SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              autofocus: false,
              clipBehavior: Clip.none,
              onPressed: () {
                print('BROWSE PRODUCTS TAPPED');
                Navigator.pushReplacementNamed(context, '/search');
              },
              child: Text(
                "BROWSE PRODUCTS",
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 18.0,
                    letterSpacing: 0.5),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xff20b830))),
            ),
          ),

          // BUTTON 2
          SizedBox(height: 15.0),
          SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              autofocus: false,
              clipBehavior: Clip.none,
              onPressed: () {
                print('HEAD HOME TAPPED');
                Navigator.pop(context);
              },
              child: Text(
                "HEAD HOME",
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 18.0,
                    letterSpacing: 0.5),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xff20b830))),
            ),
          ),
        ],
      ),
    );
  }
}
