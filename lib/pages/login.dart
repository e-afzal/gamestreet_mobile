import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/user_data.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  final cameFrom;
  Login({this.cameFrom});
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool error = false;
  String errorMessage = '';

  void loginHandler(BuildContext context) async {
    print('LOGIN TAPPED');
    var receivedInfo = await Provider.of<UserData>(context, listen: false)
        .loginUser(email, password);

    if (receivedInfo['message'] != null) {
      setState(() {
        error = true;
        errorMessage = receivedInfo['message'];
      });
      return;
    }

    if (widget.cameFrom == '/cart') {
      // If user routed to LOGIN from 'cartItems' page because they're not logged in,
      // they should log in and move to 'shipping page'
      Navigator.pushReplacementNamed(context, '/ship');
    }
    if (widget.cameFrom == '/home') {
      // Route to 'HOME',after logging in, whereby 'Home SIDEBAR' has 'user related' options
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff151515),
        appBar: AppBar(
          title: Text(
            "Sign in",
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 30.0),
                // Text(
                //   "Sign in",
                //   style: TextStyle(
                //     color: Color(0xffb7b7b7),
                //     fontFamily: 'FiraSans-Medium',
                //     fontSize: 26.0,
                //   ),
                // ),
                // SizedBox(
                //   height: 20.0,
                // ),
                SizedBox(
                  height: 50.0,
                ),

                // EMAIL
                TextFormField(
                  style: TextStyle(color: Color(0xff525252)),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "Enter email",
                    labelStyle: TextStyle(
                        color: Color(0xff525252),
                        fontFamily: 'FiraSans-Medium'),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff06D2FF))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent)),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),

                // PASSWORD
                TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Color(0xff525252)),
                  onChanged: (val) {
                    setState(() {
                      password = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "Enter password",
                    labelStyle: TextStyle(
                        color: Color(0xff525252),
                        fontFamily: 'FiraSans-Medium'),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff06D2FF))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent)),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    autofocus: false,
                    clipBehavior: Clip.none,
                    onPressed: () => loginHandler(context),
                    child: Text(
                      "SIGN IN",
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

                // ERROR MESSAGE
                error == true
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 14.0,
                              color: Colors.pinkAccent[400]),
                        ),
                      ))
                    : SizedBox(height: 0),
              ],
            ),
          ),
        )));
  }
}
