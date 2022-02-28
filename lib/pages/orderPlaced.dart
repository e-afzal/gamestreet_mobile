import 'package:flutter/material.dart';

class OrderPlaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String orderMessage =
        'The products will be dispatched at the earliest. Thank you for your purchase.';
    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        title: Text("Order placed"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: .55,
                      child: Image.asset(
                        'assets/Mario_&_Luigi.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.0),
              Text(
                "Order Placed Successfully!",
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26.0,
                    color: Color(0xffffffff)),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                orderMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: 'Lato-Regular',
                    fontSize: 18.0,
                    color: Color(0xffffffff)),
              ),

              // 'Return to Home' button
              SizedBox(height: 45.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  onPressed: () {
                    print('RETURN HOME TAPPED');
                    // Close ALL previous screens leaving only 'Home' to land on.
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  },
                  child: Text(
                    "RETURN HOME",
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

              // 'Return to Dashboard' button
              // SizedBox(height: 15.0),
              // SizedBox(
              //   width: double.infinity,
              //   height: 50.0,
              //   child: ElevatedButton(
              //     autofocus: false,
              //     clipBehavior: Clip.none,
              //     onPressed: () {
              //       // ROUTE to Order History
              //       // Close ALL routes including 'orderPlaced screen' until 'home'
              //       // So when user goes 'back' from 'order history', they land on 'home'
              //       Navigator.popUntil(context, ModalRoute.withName('/home'));
              //       // Navigate to 'Dashboard Order History'
              //       Navigator.pushNamed(context, '/dashboard/orderHistory');
              //     },
              //     child: Text(
              //       "RETURN TO DASHBOARD",
              //       style: TextStyle(
              //           fontFamily: 'FiraSans-Medium',
              //           fontSize: 18.0,
              //           letterSpacing: 0.5),
              //     ),
              //     style: ButtonStyle(
              //         backgroundColor:
              //             MaterialStateProperty.all(Color(0xff20b830))),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
