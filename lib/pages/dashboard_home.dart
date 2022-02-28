import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/user_data.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  var fToast;
  var userData;
  String fName = '';
  String lName = '';
  String email = '';
  String newPassword = '';
  String confirmPassword = '';
  bool passwordError = false;
  String passwordErrorMessage = '';
  var address = '';
  var city = 'Dubai';
  int zipCode = 0;
  var number = '';

  @override
  void initState() {
    // Initiate Toast to show upon successfully updating any input field
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Update successful",
            style: TextStyle(fontFamily: 'FiraSans-Medium'),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  // Check password before updating to new one
  void checkPasswordHandler(BuildContext context) async {
    // Check password fields are empty or not
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = true;
        passwordErrorMessage =
            'Please ensure that the above fields are filled.';
      });
      return;
    }

    // Check password equality
    if (newPassword != confirmPassword) {
      setState(() {
        passwordError = true;
        passwordErrorMessage = 'Passwords do not match. Try again.';
      });
      return;
    }

    setState(() {
      passwordError = false;
    });

    var result = await Provider.of<UserData>(context, listen: false)
        .updatePassword(newPassword);

    setState(() {
      newPassword = '';
      confirmPassword = '';
    });

    showToast();
  }

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserData>(context, listen: true).getUserInfo;

    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        title: Text('Account Settings'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Text(
                "Personal Details",
                style: TextStyle(
                  color: Color(0xff7dd56f),
                  fontFamily: 'FiraSans-Medium',
                  fontSize: 26.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // PERSONAL DETAILS
              TextFormField(
                style: TextStyle(color: Color(0xff525252)),
                initialValue: userInfo['fName'],
                onChanged: (val) {
                  setState(() {
                    fName = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "First name",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
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
                initialValue: userInfo['lName'],
                onChanged: (val) {
                  setState(() {
                    lName = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "Last name",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
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
                initialValue: userInfo['email'],
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff06D2FF))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  onPressed: () {
                    print('PERSONAL DETAILS - SAVED CHANGES');
                    Provider.of<UserData>(context, listen: false)
                        .updatePersonalDetails(
                            fName: fName, lName: lName, email: email);
                    showToast();
                  },
                  child: Text(
                    "SAVE CHANGES",
                    style: TextStyle(
                        fontFamily: 'FiraSans-Medium',
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffdc143c))),
                ),
              ),

              Divider(
                height: 100,
                color: Colors.white24,
                thickness: 1.5,
              ),

              // CHANGE PASSWORD
              Text(
                "Change Password",
                style: TextStyle(
                  color: Color(0xff7dd56f),
                  fontFamily: 'FiraSans-Medium',
                  fontSize: 26.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // New Password
              TextFormField(
                obscureText: true,
                style: TextStyle(color: Color(0xff525252)),
                onChanged: (val) {
                  setState(() {
                    newPassword = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "New password",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff06D2FF))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              // Confirm Password
              TextFormField(
                obscureText: true,
                style: TextStyle(color: Color(0xff525252)),
                onChanged: (val) {
                  setState(() {
                    confirmPassword = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "Confirm password",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff06D2FF))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // PASSWORD ERROR CHECK
              passwordError == true
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_outlined, color: Color(0xffdc143c)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            passwordErrorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'FiraSans-Medium',
                                fontSize: 14.0,
                                color: Colors.pinkAccent[400]),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(height: 0),

              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  onPressed: () => checkPasswordHandler(context),
                  child: Text(
                    "SAVE CHANGES",
                    style: TextStyle(
                        fontFamily: 'FiraSans-Medium',
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffdc143c))),
                ),
              ),

              Divider(
                height: 100,
                color: Colors.white24,
                thickness: 1.5,
              ),

              // DELIVERY ADDRESS
              Text(
                "Delivery Address",
                style: TextStyle(
                  color: Color(0xff7dd56f),
                  fontFamily: 'FiraSans-Medium',
                  fontSize: 26.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Color(0xff525252)),
                initialValue:
                    address.isEmpty ? userInfo['streetAddress'] : address,
                onChanged: (val) {
                  setState(() {
                    address = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "Street address",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff06D2FF))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              // Zip Code
              TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color(0xff525252)),
                initialValue: userInfo['zipCode'].toString(),
                onChanged: (val) {
                  setState(() {
                    zipCode = int.parse(val);
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "Zip Code",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff06D2FF))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),

              // City
              DropdownButton<String>(
                value: userInfo['city'],
                style: TextStyle(
                    color: Color(0xff525252),
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 16.0),
                dropdownColor: Color(0xff151515),
                onChanged: (String? value) {
                  setState(() {
                    city = value!;
                  });
                },
                items: <String>['Dubai', 'Sharjah', 'Abu Dhabi', 'Ajman']
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
              ),

              SizedBox(
                height: 35.0,
              ),

              // Contact Number
              TextFormField(
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Color(0xff525252)),
                initialValue: number.isEmpty ? userInfo['number'] : number,
                onChanged: (val) {
                  setState(() {
                    number = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xff0d0d0d),
                  labelText: "Contact number",
                  labelStyle: TextStyle(
                      color: Color(0xff525252), fontFamily: 'FiraSans-Medium'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff06D2FF))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  onPressed: () {
                    print('DELIVERY DETAILS - SAVED CHANGES');
                    Provider.of<UserData>(context, listen: false)
                        .updateDeliveryAddress(
                            streetAddress: address,
                            zipCode: zipCode,
                            city: city,
                            number: number);
                    showToast();
                  },
                  child: Text(
                    "SAVE CHANGES",
                    style: TextStyle(
                        fontFamily: 'FiraSans-Medium',
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffdc143c))),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
