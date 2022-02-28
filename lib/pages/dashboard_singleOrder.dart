import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/orders.dart';

// THIRD PARTY PACKAGES
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardSingleOrder extends StatefulWidget {
  final orderId;
  final userInfo;
  DashboardSingleOrder({this.orderId, this.userInfo});

  @override
  _DashboardSingleOrderState createState() => _DashboardSingleOrderState();
}

class _DashboardSingleOrderState extends State<DashboardSingleOrder> {
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
        title: Text('Return to Dashboard'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: Order().fetchSingleOrderDetails(
                  userInfo: widget.userInfo, orderId: widget.orderId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: finalPadding * 0.40),
                        child: SpinKitFadingCube(
                          color: Colors.white,
                          size: 40,
                        )),
                  );
                } else {
                  var orderInfo = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SHIPPING DETAILS
                        Text(
                          "Shipping Details",
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 26.0,
                              color: Color(0xffd7d8d7)),
                        ),
                        SizedBox(
                          height: 17.5,
                        ),
                        Text(
                          'Name: ${orderInfo['shippingAddress']['fName']} ${orderInfo['shippingAddress']['lName']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato-Regular',
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Contact number: ${orderInfo['shippingAddress']['number']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato-Regular',
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'City: ${orderInfo['shippingAddress']['city']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato-Regular',
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Address: ${orderInfo['shippingAddress']['streetAddress']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato-Regular',
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Delivery method: ',
                                style: TextStyle(
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 17,
                                    color: Colors.white)),
                            TextSpan(
                                text: toBeginningOfSentenceCase(
                                    orderInfo['shippingAddress']
                                        ['deliveryMethod']),
                                style: TextStyle(
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 17,
                                    color: Colors.white)),
                          ]),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Delivery status: ',
                                style: TextStyle(
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 17,
                                    color: Colors.white)),
                            TextSpan(
                                text:
                                    '${orderInfo['isDelivered'] == false ? 'Under process' : 'Delivered'}',
                                style: TextStyle(
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: orderInfo['isDelivered'] == false
                                        ? Color(0xffdc143c)
                                        : Color(0xff20b830))),
                          ]),
                        ),

                        Divider(
                          color: Color(0xffa0a0a0),
                          height: 50,
                          thickness: 1,
                        ),

                        // PAYMENT DETAILS
                        Text(
                          "Payment Details",
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 26.0,
                              color: Color(0xffd7d8d7)),
                        ),
                        SizedBox(
                          height: 17.5,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Payment status: ',
                                style: TextStyle(
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 17,
                                    color: Colors.white)),
                            TextSpan(
                                text: 'PAID',
                                style: TextStyle(
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff20b830))),
                          ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Payment date: ${orderInfo['paidAt'].substring(0, 10)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato-Regular',
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Mode of Payment: ${orderInfo['paymentMethod']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato-Regular',
                              fontSize: 17),
                        ),
                        Divider(
                          color: Color(0xffa0a0a0),
                          height: 50,
                          thickness: 1,
                        ),

                        // ORDER ITEMS
                        Text(
                          "Order Items",
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 26.0,
                              color: Color(0xffd7d8d7)),
                        ),
                        SizedBox(
                          height: 17.5,
                        ),

                        // ITEMS GRID
                        Flexible(
                            fit: FlexFit.loose,
                            child: GridView.count(
                              mainAxisSpacing: 25,
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [...orderInfo['orderItems']]
                                  .map((eachItem) => SingleOrderItem(
                                      eachItem['image'],
                                      eachItem['name'],
                                      eachItem['platform'],
                                      eachItem['price'],
                                      eachItem['qty'],
                                      eachItem['edition'],
                                      eachItem['condition']))
                                  .toList(),
                            )),

                        SizedBox(
                          height: 25.0,
                        ),

                        // ORDER SUMMARY
                        OrderSummary(
                            orderInfo['subtotalPrice'],
                            orderInfo['shippingPrice'],
                            orderInfo['taxPrice'],
                            orderInfo['totalPrice']),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

// SINGLE GRID ITEM
class SingleOrderItem extends StatelessWidget {
  // String itemImage;
  // String itemName;
  // String itemPlatform;
  // int itemPrice;
  // int itemQuantity;
  // String itemEdition;
  // String itemCondition;

  final itemImage;
  final itemName;
  final itemPlatform;
  final itemPrice;
  final itemQuantity;
  final itemEdition;
  final itemCondition;

  SingleOrderItem(this.itemImage, this.itemName, this.itemPlatform,
      this.itemPrice, this.itemQuantity, this.itemEdition, this.itemCondition);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ITEM IMAGE
              Flexible(
                  fit: FlexFit.loose,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      'assets$itemImage',
                      fit: BoxFit.cover,
                    ),
                  )),
              // ITEM PRICE & 'REMOVE'
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'AED $itemPrice.00',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Color(0xff20b830),
                            fontFamily: 'FiraSans-Medium',
                            fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: 340,
                    child: Text('$itemName',
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontFamily: 'FiraSans-Medium')),
                  ),
                  SizedBox(height: 10.0),
                  Text('Platform: $itemPlatform',
                      style: TextStyle(fontSize: 15.5, color: Colors.white)),
                  SizedBox(height: 3.0),
                  Text(
                      'Quantity ordered: ${itemQuantity == 1 ? "$itemQuantity unit" : "$itemQuantity units"}',
                      style: TextStyle(fontSize: 15.5, color: Colors.white)),
                  SizedBox(height: 3.0),
                  Text('Edition: $itemEdition edition',
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Colors.white,
                          fontFamily: 'Lato-Regular')),
                  SizedBox(height: 3.0),
                  Text('Condition: $itemCondition',
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Colors.white,
                          fontFamily: 'Lato-Regular')),
                  SizedBox(height: 3.0),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

// ORDER SUMMARY
class OrderSummary extends StatelessWidget {
  // int subtotalPrice;
  // int shippingPrice;
  // int taxPrice;
  // int totalPrice;

  final subtotalPrice;
  final shippingPrice;
  final taxPrice;
  final totalPrice;

  OrderSummary(
      this.subtotalPrice, this.shippingPrice, this.taxPrice, this.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          children: [
            Text('ORDER SUMMARY',
                style: TextStyle(
                    color: Color(0xffd7d8d7),
                    fontSize: 26.0,
                    fontFamily: 'FiraSans-Medium')),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Subtotal (0 Items)',
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Delivery Charges',
                  style: TextStyle(
                      color: Color(0xffd7d8d7),
                      fontSize: 15.5,
                      fontFamily: 'Lato-Regular')),
              Text('${shippingPrice == 0 ? 'FREE' : "AED $shippingPrice.00"}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff20b830),
                      fontSize: 15.5,
                      fontFamily: 'Lato-Regular')),
            ]),
            SizedBox(
              height: 4.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          ],
        ));
  }
}
