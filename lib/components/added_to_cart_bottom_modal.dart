import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/pages/cartItems.dart';

class CartBottomModal extends StatefulWidget {
  @override
  _CartBottomModalState createState() => _CartBottomModalState();

  final itemImage;
  final itemName;
  CartBottomModal({this.itemImage, this.itemName});
}

class _CartBottomModalState extends State<CartBottomModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff151515),
        child: Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: Color(0xff20b830),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Item added to cart',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FiraSans-Medium',
                    ),
                  ),
                ],
              ),
              Divider(
                height: 30,
              ),

              // ITEM IMAGE & TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Container(
                      height: 165,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          'assets${widget.itemImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 7),
                        child: Text(
                          widget.itemName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium', fontSize: 18.0),
                        ),
                      ),
                    ],
                  )),
                ],
              ),

              // 'VIEW CART' Button
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  onPressed: () {
                    print('VIEW CART TAPPED');
                    var route =
                        MaterialPageRoute(builder: (context) => CartItems());
                    Navigator.pushReplacement(context, route);
                  },
                  child: Text(
                    "VIEW CART",
                    style: TextStyle(
                        fontFamily: 'FiraSans-Medium',
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2.5),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffdc143c))),
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('CONTINUE SHOPPING TAPPED');
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Continue Shopping',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Lato-Regular',
                          color: Color(0xff151515),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ])));
  }
}
