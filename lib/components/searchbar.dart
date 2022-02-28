import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/pages/searchPage.dart';

// THIRD PARTY PACKAGES
import 'package:fluttertoast/fluttertoast.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  var fToast;

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
          borderRadius: BorderRadius.circular(25.0), color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cancel_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Please enter a valid search term",
            style: TextStyle(
                fontFamily: 'FiraSans-Medium', color: Colors.black),
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onFieldSubmitted: (val) {
        if (val.trim().length == 0) {
          showToast();
          return;
        }
        var route = MaterialPageRoute(
            builder: (context) => SearchPage(searchTerm: val.trim()));
        Navigator.push(context, route);
      },
      decoration: InputDecoration(
          labelText: "Search Products",
          labelStyle:
              TextStyle(color: Colors.white, fontFamily: 'FiraSans-Medium'),
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff06D2FF))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amberAccent))),
    );
  }
}
