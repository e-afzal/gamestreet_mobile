import 'package:flutter/material.dart';

// LOCAL packages
import 'package:game_street/pages/home.dart';
import 'package:game_street/pages/searchPage.dart';
import 'package:game_street/pages/Singlegame.dart';
import 'package:game_street/pages/Singleproduct.dart';

import 'package:game_street/pages/createAccount.dart';
import 'package:game_street/pages/login.dart';
import 'package:game_street/pages/dashboard_home.dart';
import 'package:game_street/pages/dashboard_orderHistory.dart';
import 'package:game_street/pages/dashboard_singleOrder.dart';

import 'package:game_street/pages/cartItems.dart';
import 'package:game_street/pages/cartEmpty.dart';
import 'package:game_street/pages/shipDetails.dart';
import 'package:game_street/pages/orderPlaced.dart';

// CLASSES
import 'package:game_street/class/cart_items.dart';
import 'package:game_street/class/user_data.dart';
import 'package:game_street/class/search.dart';
import 'package:game_street/class/orders.dart';

// 3rd Party Packages
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartItemsData()),
      ChangeNotifierProvider(create: (_) => UserData()),
      ChangeNotifierProvider(create: (_) => SearchResults()),
      ChangeNotifierProvider(create: (_) => Order())
    ],
    child: MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/search': (context) => SearchPage(),
        '/singleGame': (context) => SingleGame(),
        '/singleProduct': (context) => SingleProduct(),

        // // ACCOUNT RELATED
        '/account': (context) => CreateAccount(),
        '/login': (context) => Login(),
        '/dashboard': (context) => DashboardHome(),
        '/dashboard/orderHistory': (context) => DashboardOrderHistory(),
        '/dashboard/orderHistory/singleOrder': (context) =>
            DashboardSingleOrder(),

        // // CART RELATED
        '/cart': (context) => CartItems(),
        '/cartEmpty': (context) => EmptyCart(),
        '/ship': (context) => ShipDetails(),
        '/placed': (context) => OrderPlaced(),
      },
    ),
  ));
}
