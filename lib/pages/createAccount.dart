import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/user_data.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();

  final cameFrom;
  CreateAccount({this.cameFrom});
}

class _CreateAccountState extends State<CreateAccount> {
  String fName = '';
  String lName = '';
  String email = '';
  String contactNumber = '';
  String password = '';
  String confirmPassword = '';
  bool error = false;
  String errorMessage = '';
  bool passwordError = false;
  String passwordMessage = '';

  void signupHandler(BuildContext context) async {
    print('TAPPED - CREATE ACCOUNT');
    // Input fields check
    if (fName.isEmpty ||
        lName.isEmpty ||
        email.isEmpty ||
        contactNumber.isEmpty) {
      setState(() {
        error = true;
        errorMessage = 'Please ensure all the above fields are filled.';
      });
    } else {
      setState(() {
        error = false;
      });
    }

    // Password Match Check
    if (password != confirmPassword) {
      setState(() {
        passwordError = true;
        passwordMessage = 'Passwords do not match. Try again.';
      });
      return;
    } else {
      setState(() {
        passwordError = false;
      });
    }

    // CREATE NEW USER, if all above conditions are satisfied
    var newResult = await Provider.of<UserData>(context, listen: false)
        .addNewUser(fName, lName, email, contactNumber, password);

// If the new user is created SUCCESSFULLY whereby 'token' is issued, AND passwords match, then:
    if (newResult['token'] != null) {
      if (widget.cameFrom == '/home') {
        // Route to 'HOME',after logging in, whereby 'Home SIDEBAR' has 'user related' options
        Navigator.pop(context);
      }

      if (widget.cameFrom == '/cart') {
        // If user routed to SIGNUP from 'cartItems' page because they're not logged in,
        // they should log in and move to 'shipping page'
        Navigator.pushReplacementNamed(context, '/ship');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff151515),
        appBar: AppBar(
          title: Text("Create Account"),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                Text(
                  "Create an account",
                  style: TextStyle(
                    color: Color(0xffb7b7b7),
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 26.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // FIRST NAME
                TextFormField(
                  style: TextStyle(color: Color(0xff525252)),
                  onChanged: (val) {
                    setState(() {
                      fName = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "First name",
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
                // LAST NAME
                TextFormField(
                  style: TextStyle(color: Color(0xff525252)),
                  onChanged: (val) {
                    setState(() {
                      lName = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "Last name",
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
                // EMAIL
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Color(0xff525252)),
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "Email",
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
                // CONTACT
                TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Color(0xff525252)),
                  onChanged: (val) {
                    setState(() {
                      contactNumber = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "Contact number",
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
                    labelText: "Enter Password",
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
                // CONFIRM PASSWORD
                TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Color(0xff525252)),
                  onChanged: (val) {
                    setState(() {
                      confirmPassword = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff0d0d0d),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                        color: Color(0xff525252),
                        fontFamily: 'FiraSans-Medium'),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff06D2FF))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent)),
                  ),
                ),

                // Password Match Check. Password Error message if mismatch found
                passwordError
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          passwordMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 14.0,
                              color: Colors.pinkAccent[400]),
                        ),
                      ))
                    : SizedBox(height: 0),

                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    autofocus: false,
                    clipBehavior: Clip.none,
                    onPressed: () => signupHandler(context),
                    child: Text(
                      "CREATE ACCOUNT",
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
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 14.0,
                              color: Colors.pinkAccent[400]),
                        ),
                      )
                    : SizedBox(height: 0),
              ],
            ),
          ),
        )));
  }
}
