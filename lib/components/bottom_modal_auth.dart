import 'package:flutter/material.dart';

// LOCAL PARTY PACKAGES
import 'package:game_street/pages/createAccount.dart';
import 'package:game_street/pages/login.dart';

class BottomModalAuth extends StatefulWidget {
  @override
  _BottomModalAuthState createState() => _BottomModalAuthState();
}

class _BottomModalAuthState extends State<BottomModalAuth> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign-In Required',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FiraSans-Medium',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Icon(
                      Icons.login_rounded,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Divider(
                height: 30,
              ),
              Text(
                'To proceed further with placing an order, you are required to have an account.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato-Regular',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please tap the login button if you have an account or tap the signup button to create a new account.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato-Regular',
                ),
              ),

              // BUTTONS
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 'LOGIN' BUTTON
                  Expanded(
                    child: ElevatedButton(
                      autofocus: false,
                      clipBehavior: Clip.none,
                      onPressed: () {
                        print('LOGIN TAPPED');
                        var routeLogin = MaterialPageRoute(
                            builder: (context) => Login(cameFrom: '/cart'));
                        // Route to 'LOGIN' if user is NOT logged in
                        Navigator.pop(context);
                        Navigator.push(context, routeLogin);
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontFamily: 'FiraSans-Medium',
                            fontSize: 18.0,
                            letterSpacing: 0.5),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(top: 10, bottom: 10)),
                          elevation: MaterialStateProperty.all(2.5),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff20b830))),
                    ),
                  ),

                  SizedBox(
                    width: 15,
                  ),

                  // 'SIGN UP Button'
                  Expanded(
                    child: ElevatedButton(
                      autofocus: false,
                      clipBehavior: Clip.none,
                      onPressed: () {
                        print('SIGNUP TAPPED');
                        var routeSignup = MaterialPageRoute(
                            builder: (context) =>
                                CreateAccount(cameFrom: '/cart'));
                        // Route to 'LOGIN' if user is NOT logged in
                        Navigator.pop(context);
                        Navigator.push(context, routeSignup);
                      },
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(
                            fontFamily: 'FiraSans-Medium',
                            fontSize: 18.0,
                            letterSpacing: 0.5),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(top: 10, bottom: 10)),
                          elevation: MaterialStateProperty.all(2.5),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffdc143c))),
                    ),
                  ),
                ],
              ),
            ])));
  }
}
