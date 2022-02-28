import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/orders.dart';
import 'package:game_street/pages/dashboard_singleOrder.dart';

class DashboardOrderHistory extends StatefulWidget {
  final userInfo;
  DashboardOrderHistory({this.userInfo});

  @override
  _DashboardOrderHistoryState createState() => _DashboardOrderHistoryState();
}

class _DashboardOrderHistoryState extends State<DashboardOrderHistory> {
  var _orderList = [];

  void fetchData() async {
    var data = await Order().fetchOrders(widget.userInfo);
    setState(() {
      _orderList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // Calculation: Loader Padding Top Height
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = AppBar().preferredSize.height;
    double bodyHeight = MediaQuery.of(context).size.height;
    double finalPadding = bodyHeight - (statusbarHeight + appBarHeight);

    return Scaffold(
        backgroundColor: Color(0xff151515),
        appBar: AppBar(
          title: Text("Order History"),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _orderList.length == 0
                  ? [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: finalPadding * 0.40),
                            child: Text(
                              'No order has been placed as yet..',
                              style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontFamily: 'Lato-Regular',
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      )
                    ]
                  : [
                      SizedBox(
                        height: 35,
                      ),

                      // TABLE - Main Table Header
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7)),
                            ),
                            children: [
                              Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text('ID',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xff151515),
                                          fontFamily: 'FiraSans-Medium')),
                                )
                              ]),
                              Column(children: [
                                Text('DATE',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xff151515),
                                        fontFamily: 'FiraSans-Medium'))
                              ]),
                              Column(children: [
                                Text('AMOUNT',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xff151515),
                                        fontFamily: 'FiraSans-Medium'))
                              ]),
                              Column(children: [
                                Text(
                                  '',
                                )
                              ]),
                            ],
                          ),
                        ],
                      ),

                      // TABLE 2 - Contains Each Order
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: _orderList
                            .map<TableRow>((eachOrder) => TableRow(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 1)),
                                  ),
                                  children: [
                                    Text(
                                        eachOrder['_id'].substring(
                                            eachOrder['_id'].length - 5),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontFamily: 'FiraSans-Medium')),
                                    Text(eachOrder['paidAt'].substring(0, 10),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontFamily: 'FiraSans-Medium')),
                                    Text(
                                        'AED ${eachOrder['totalPrice'].toString()}.00',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontFamily: 'FiraSans-Medium')),
                                    Column(children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 10,
                                              right: 10),
                                          child: InkWell(
                                            child: Text('VIEW DETAILS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'FiraSans-Medium')),
                                            onTap: () {
                                              var route = MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashboardSingleOrder(
                                                        orderId:
                                                            eachOrder['_id'],
                                                        userInfo:
                                                            widget.userInfo,
                                                      ));
                                              Navigator.push(context, route);
                                            },
                                          ))
                                    ]),
                                  ],
                                ))
                            .toList(),
                      ),
                    ]),
        ))));
  }
}
