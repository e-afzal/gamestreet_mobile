import 'dart:ui';

import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();

  final marginTop;
  Footer({this.marginTop});
}

class _FooterState extends State<Footer> {
  List productsSection = [
    {
      'index': 1,
      'text': 'Consoles',
    },
    {
      'index': 2,
      'text': 'Video Games',
    },
    {
      'index': 3,
      'text': 'Accessories',
    },
    {
      'index': 4,
      'text': 'Merchandise',
    },
  ];

  List helpSection = [
    {
      'index': 1,
      'text': 'Contact us',
    },
    {
      'index': 2,
      'text': 'Store feedback',
    },
    {
      'index': 3,
      'text': 'Order enquiry',
    },
    {
      'index': 4,
      'text': 'Covid-19 protocols',
    },
  ];

  List aboutSection = [
    {
      'index': 1,
      'text': 'Store locations',
    },
    {
      'index': 2,
      'text': 'About GameStreet',
    },
    {
      'index': 3,
      'text': 'Terms & Conditions',
    },
    {
      'index': 4,
      'text': 'Privacy Policy',
    },
  ];

  String signupEmail = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.marginTop),
      padding: EdgeInsets.symmetric(vertical: 50),
      color: Colors.black,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 'PRODUCTS' section
            Text('Products',
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26,
                    color: Colors.white)),

            SizedBox(height: 6),
            Divider(color: Colors.grey),

            for (var eachItem in productsSection)
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(eachItem['text'],
                      style: TextStyle(
                          fontFamily: 'FiraSans-Medium',
                          fontSize: 18,
                          color: Colors.grey))),

            // 'GET HELP' section
            SizedBox(height: 55),
            Text('Get Help',
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26,
                    color: Colors.white)),

            SizedBox(height: 6),
            Divider(color: Colors.grey),

            for (var eachItem in helpSection)
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(eachItem['text'],
                      style: TextStyle(
                          fontFamily: 'FiraSans-Medium',
                          fontSize: 18,
                          color: Colors.grey))),

            // 'ABOUT' section
            SizedBox(height: 55),
            Text('About',
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26,
                    color: Colors.white)),

            SizedBox(height: 6),
            Divider(color: Colors.grey),

            for (var eachItem in aboutSection)
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(eachItem['text'],
                      style: TextStyle(
                          fontFamily: 'FiraSans-Medium',
                          fontSize: 18,
                          color: Colors.grey))),

            // 'SUBSCRIBE' section
            SizedBox(height: 55),
            Text('Sign up',
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26,
                    color: Colors.white)),

            SizedBox(height: 6),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 16),
              child: Text(
                'Subscribe to receive exclusive promotions, coupons and news on latest events',
                style: TextStyle(
                    height: 1.3,
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 18,
                    color: Colors.grey),
              ),
            ),
            Container(
              height: 55,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 4,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      style: TextStyle(
                          color: Color(0xff31343a),
                          fontFamily: 'Lato-Regular',
                          fontSize: 19),
                      onFieldSubmitted: (val) {
                        setState(() {
                          signupEmail = val.trim();
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          // borderRadius: BorderRadius.circular(6.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              topRight: Radius.zero,
                              bottomRight: Radius.zero),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 17, 20, 17),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10, right: 5),
                            child: Icon(
                              Icons.email_sharp,
                              color: Color(0xff31343a),
                              size: 25,
                            )),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter email',
                        hintStyle: TextStyle(
                            color: Color(0xff31343a),
                            fontFamily: 'Lato-Regular',
                            fontSize: 19),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),

                  // 'JOIN' BUTTON
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      autofocus: false,
                      clipBehavior: Clip.none,
                      onPressed: () {
                        print('JOIN tapped');
                      },
                      child: Text(
                        "JOIN",
                        style: TextStyle(
                            fontFamily: 'FiraSans-Medium',
                            fontSize: 18.0,
                            letterSpacing: 0.5),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.zero,
                                          bottomLeft: Radius.zero,
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5)))),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff20b830))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
