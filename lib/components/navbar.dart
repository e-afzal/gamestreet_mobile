import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// LOCAL PACKAGES
import 'package:game_street/class/cart_items.dart';
import 'package:game_street/pages/cartItems.dart';
import 'package:game_street/pages/cartEmpty.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<CartItemsData>(context).getAllItems;

    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Image.asset(
                    'assets/navbar.png',
                    height: 15.0,
                  ),
                )),
        SvgPicture.asset('assets/GameStreet_Logo-Horizontal.svg', height: 50.0),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff151515))),
          child: SvgPicture.asset(
            'assets/cart.svg',
            width: 30.0,
          ),
          onPressed: () {
            if (cartItems.length == 0) {
              var route = MaterialPageRoute(builder: (context) => EmptyCart());
              Navigator.push(context, route);
            } else {
              var route = MaterialPageRoute(builder: (context) => CartItems());
              Navigator.push(context, route);
            }
          },
        ),
      ]),
    );
  }
}
