import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String emptyMessage =
        "Please feel free to look through the catalogue of various gaming products that might be of interest to you:";
        
    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        title: Text("Empty Cart"),
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
                emptyMessage,
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
        ),
      ),
    );
  }
}
