import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/user_data.dart';
import 'package:game_street/class/cart_items.dart';
import 'package:game_street/pages/orderPlaced.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

class ShipDetails extends StatefulWidget {
  @override
  _ShipDetailsState createState() => _ShipDetailsState();
}

class _ShipDetailsState extends State<ShipDetails> {
// FIELDS
  String fName = '';
  String lName = '';
  String address = '';
  String city = 'Dubai';
  String contact = '';
  String deliveryMethod = 'standard';
  bool error = false;

  // Radio Buttons Text
  List radioButtonList = [
    {
      'text': 'Standard Delivery: Delivery within 2 - 5 days (FREE)',
      'value': 'standard'
    },
    {
      'text': 'Premium Delivery: Delivery by tomorrow (charged @ AED 25.00)',
      'value': 'premium'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // PROVIDERS
    var userData = Provider.of<UserData>(context).getUserInfo;
    var cartItems = Provider.of<CartItemsData>(context).getAllItems;
    Provider.of<CartItemsData>(context)
        .cartCalculations(deliveryMethod: deliveryMethod);
    var subtotalQuantity =
        Provider.of<CartItemsData>(context).getSubtotalQuantity;
    var subtotalPrice = Provider.of<CartItemsData>(context).getSubtotalPrice;
    var taxPrice = Provider.of<CartItemsData>(context).getEstdTaxPrice;
    var totalPrice = Provider.of<CartItemsData>(context).getTotalPrice;

    // Set user shipping details with Provider details
    fName = fName == '' ? userData['fName'] : fName;
    lName = lName == '' ? userData['lName'] : lName;
    address = address == '' ? userData['streetAddress'] : address;
    city = city == '' ? userData['city'] : city;
    contact = contact == '' ? userData['number'] : contact;

    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
          title: Text('Shipping Details'),
          backgroundColor: Colors.transparent,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping Details',
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26.0,
                    color: Color(0xffffffff)),
              ),

              // INPUT FIELD ROW 1
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: TextFormField(
                        initialValue:
                            fName.length == 0 ? userData['fName'] : fName,
                        style: TextStyle(
                          color: Color(0xffb4b4b4),
                        ),
                        onChanged: (val) {
                          setState(() {
                            fName = val.trim();
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Color(0xff0d0d0d),
                          labelText: "First name",
                          labelStyle: TextStyle(
                              color: Color(0xffb4b4b4),
                              fontFamily: 'FiraSans-Medium'),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff06D2FF))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: TextFormField(
                        initialValue:
                            lName.length == 0 ? userData['lName'] : lName,
                        style: TextStyle(
                          color: Color(0xffb4b4b4),
                        ),
                        onChanged: (val) {
                          setState(() {
                            lName = val.trim();
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Color(0xff0d0d0d),
                          labelText: "Last name",
                          labelStyle: TextStyle(
                              color: Color(0xffb4b4b4),
                              fontFamily: 'FiraSans-Medium'),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff06D2FF))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // INPUT FIELD ROW 2
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: address.length == 0
                          ? userData['streetAddress']
                          : address,
                      style: TextStyle(
                        color: Color(0xffb4b4b4),
                      ),
                      onChanged: (val) {
                        setState(() {
                          address = val.trim();
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xff0d0d0d),
                        labelText: "Address",
                        labelStyle: TextStyle(
                            color: Color(0xffb4b4b4),
                            fontFamily: 'FiraSans-Medium'),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff06D2FF))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amberAccent)),
                      ),
                    ),
                  ),
                ],
              ),

              // INPUT FIELD ROW 3
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 5.0, left: 12.0),
                        height: 58.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.amberAccent),
                            borderRadius: BorderRadius.circular(4)),
                        child: DropdownButton<String>(
                          value: city.length == 0
                              ? Provider.of<UserData>(context)
                                  .getUserInfo['city']
                              : city,
                          style: TextStyle(
                              color: Color(0xffb4b4b4),
                              fontSize: 16.0,
                              fontFamily: 'FiraSans-Medium'),
                          underline: Container(height: 0),
                          iconSize: 0,
                          dropdownColor: Color(0xff151515),
                          onChanged: (String? newValue) {
                            setState(() {
                              city = newValue.toString().trim();
                            });
                          },
                          items: <String>[
                            'Dubai',
                            'Abu Dhabi',
                            'Sharjah',
                            'Ajman'
                          ]
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: TextFormField(
                        initialValue:
                            contact.length == 0 ? userData['number'] : contact,
                        style: TextStyle(
                          color: Color(0xffb4b4b4),
                        ),
                        onChanged: (val) {
                          setState(() {
                            contact = val.trim();
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Color(0xff0d0d0d),
                          labelText: "Contact number",
                          labelStyle: TextStyle(
                              color: Color(0xffb4b4b4),
                              fontFamily: 'FiraSans-Medium'),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff06D2FF))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // RADIO BUTTONS
              SizedBox(height: 40.0),

              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: radioButtonList
                    .map((each) => RadioListTile<String>(
                        title: Text(
                          each['text'],
                          style: TextStyle(
                              color: Color(0xffb4b4b4),
                              fontFamily: 'Lato-Regular',
                              height: 1.5),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                        activeColor: Color(0xff676767),
                        value: each['value'],
                        groupValue: deliveryMethod,
                        onChanged: (value) {
                          setState(() {
                            deliveryMethod = value.toString().trim();
                          });
                        }))
                    .toList(),
              ),

              SizedBox(height: 40.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Charges',
                                style: TextStyle(
                                    color: Color(0xffd7d8d7),
                                    fontSize: 15.5,
                                    fontFamily: 'Lato-Regular')),
                            Text(
                                deliveryMethod == 'standard'
                                    ? 'FREE'
                                    : 'AED 25.00',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onPressed: () async {
                            print('PLACE ORDER TAPPED');

                            if (fName.length == 0 ||
                                lName.length == 0 ||
                                address.length == 0 ||
                                contact.length == 0 ||
                                city.length == 0) {
                              setState(() {
                                error = true;
                              });
                              return;
                            } else {
                              setState(() {
                                error = false;
                              });
                              Provider.of<CartItemsData>(context, listen: false)
                                  .saveShippingAddress(
                                      fName: fName,
                                      lName: lName,
                                      address: address,
                                      city: city,
                                      number: contact);
                            }
                            // Place Order
                            await Provider.of<CartItemsData>(context,
                                    listen: false)
                                .placeOrder(
                                    userInfo: userData, cartItems: cartItems);
                            // Re-direct to 'ORDER SUCCESS' page after 'placing order'
                            var route = MaterialPageRoute(
                                builder: (context) => OrderPlaced());
                            // EMPTY the Cart upon SUCCESSFUL Order placement
                            Provider.of<CartItemsData>(context, listen: false)
                                .emptyCart();
                            // Navigator.pushReplacementNamed(context, '/placed');
                            Navigator.pushReplacementNamed(context, '/placed');
                          },
                          child: Text(
                            "PLACE ORDER",
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

                      // ERROR CHECK
                      error == true
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Ensure all the above fields are filled',
                                style: TextStyle(
                                    fontFamily: 'FiraSans-Medium',
                                    fontSize: 14.0,
                                    color: Colors.pinkAccent[400]),
                              ),
                            ))
                          : SizedBox(height: 0),

                      // SizedBox(
                      //   height: 25.0,
                      // ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
