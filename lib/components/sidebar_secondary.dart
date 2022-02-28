import 'package:flutter/material.dart';

class SecondarySidebar extends StatefulWidget {
  @override
  _SecondarySidebarState createState() => _SecondarySidebarState();
}

class _SecondarySidebarState extends State<SecondarySidebar> {
  final List<String> categoryList = [
    "Consoles",
    "Games",
    "Accessories",
    "Merchandises"
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 'RETURN' link
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 22.0,
                      color: Color(0xffdc143c),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'RETURN',
                      style: TextStyle(
                          color: Color(0xffdc143c),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.55
                          ),
                    )
                  ],
                ),
              ),

              // OPTIONS
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Playstation 5",
                      style: TextStyle(
                          fontFamily: 'FiraSans-Medium', fontSize: 26.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categoryList
                          .map((each) => GestureDetector(
                                onTap: () {
                                  print(each);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      each,
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
          ))
        ],
      ),
    );
  }
}
