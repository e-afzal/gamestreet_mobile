import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

// LOCAL PACKAGES
import 'package:game_street/pages/login.dart';
import 'package:game_street/class/user_data.dart';
import 'package:game_street/pages/searchPage.dart';
import 'package:game_street/pages/createAccount.dart';
import 'package:game_street/pages/dashboard_orderHistory.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final List<String> categoryList = [
    "PS4",
    "PS5",
    "Xbox Series X|S",
    "Xbox One",
    "Nintendo Switch"
  ];

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context, listen: true);
    var userInfo = userData.getUserInfo;

    dynamic authUser() {
      if (userInfo.isEmpty) {
        // If User NOT logged in
        return [
          Text("Account",
              style: TextStyle(fontFamily: 'FiraSans-Medium', fontSize: 18.0)),
          SizedBox(height: 3.0),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                      var route = MaterialPageRoute(
                          builder: (context) => Login(
                                cameFrom: '/home',
                              ));
                      Navigator.push(context, route);
                    },
                  text: 'Sign In',
                  style: TextStyle(
                      fontFamily: 'FiraSans-Medium',
                      fontSize: 14.0,
                      color: Colors.black)),
              TextSpan(
                  text: ' or ',
                  style: TextStyle(
                      fontFamily: 'FiraSans-Medium',
                      fontSize: 14.0,
                      color: Colors.black)),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                      // Re-route to HOME after successful signup.
                      var route = MaterialPageRoute(
                          builder: (context) => CreateAccount(
                                cameFrom: '/home',
                              ));
                      Navigator.push(context, route);
                    },
                  text: 'Create Account',
                  style: TextStyle(
                      fontFamily: 'FiraSans-Medium',
                      fontSize: 14.0,
                      color: Colors.black)),
            ]),
          )
        ];
      } else {
        // If user LOGGED IN
        return [
          Text("Welcome ${userInfo['fName']}!",
              style: TextStyle(fontFamily: 'FiraSans-Medium', fontSize: 18.0)),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dashboard');
            },
            child: Text("Account Settings",
                style:
                    TextStyle(fontFamily: 'FiraSans-Medium', fontSize: 14.0)),
          ),
          SizedBox(height: 3.0),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              // Route to 'Order History'
              var route = MaterialPageRoute(
                  builder: (context) => DashboardOrderHistory(
                        userInfo: userInfo,
                      ));
              Navigator.push(context, route);
            },
            child: Text("Order History",
                style:
                    TextStyle(fontFamily: 'FiraSans-Medium', fontSize: 14.0)),
          ),
          SizedBox(height: 3.0),
          InkWell(
            onTap: () {
              print('User has been logged out');
              userData.logoutUser();
              Navigator.pop(context);
            },
            child: Text("Log Out",
                style:
                    TextStyle(fontFamily: 'FiraSans-Medium', fontSize: 14.0)),
          ),
        ];
      }
    }

    return Drawer(
        child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/user_signup_login.svg',
                      width: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: authUser(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shop by Platform",
                      style: TextStyle(
                          fontFamily: 'FiraSans-Medium', fontSize: 26.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categoryList
                          .map((eachPlatform) => GestureDetector(
                                onTap: () {
                                  // Navigate to 'SEARCHPAGE' with filter set as 'consoles' and product set as option chosen
                                  // E.g. PS4, PS5, etc.
                                  print(eachPlatform);
                                  var route = MaterialPageRoute(
                                      builder: (context) => SearchPage(
                                          productPlatform: eachPlatform));
                                  Navigator.pop(context);
                                  Navigator.push(context, route);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      eachPlatform,
                                      style: TextStyle(
                                          fontFamily: 'FiraSans-Medium',
                                          fontSize: 20.0),
                                    ),
                                    Divider(
                                      color: Colors.black54,
                                      height: 30.0,
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
