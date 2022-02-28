import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/cart_items.dart';
import 'package:game_street/models/cart_item_game.dart';
import 'package:game_street/components/gameSlider.dart';
import 'package:game_street/components/gameGridItem.dart';
import 'package:game_street/components/added_to_cart_bottom_modal.dart';

// THIRD PARTY PACKAGES
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SingleGame extends StatefulWidget {
  final productId;
  SingleGame({this.productId});
  @override
  _SingleGameState createState() => _SingleGameState();
}

class _SingleGameState extends State<SingleGame> {
  // REQUIRED FIELDS
  String qty = '1';
  String edition = '';
  String condition = '';
  bool error = false;

  // FETCH DATA
  Future<void> fetchData() async {
    var responseData;
    var gameData;
    String baseUrl = 'https://gamestreet-api.herokuapp.com';
    Response response =
        await get(Uri.parse('$baseUrl/api/products/games/${widget.productId}'));
    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
      var reformedPlatforms = responseData['platforms'].join(', ');
      var reformedGenres = responseData['genres'].join(', ');
      gameData = CartGameItem(
          gamePlatforms: reformedPlatforms,
          gameScreenshots: responseData['screenshots'],
          gameGenres: reformedGenres,
          gamePrice: responseData['price'],
          gameCountInStock: responseData['countInStock'],
          gameId: responseData['_id'],
          gameName: responseData['name'],
          gameReleased: responseData['released'],
          gameMetacriticScore: responseData['metacriticScore'],
          gameCategory: responseData['category'],
          gamePlatform: responseData['platform']['name'],
          gamePublisher: responseData['publisher'],
          gameDeveloper: responseData['developer'],
          gameDescription: responseData['description'],
          gameBoxArt: responseData['box_art']);
      return gameData;
    } else {
      print('Status ${response.statusCode} - Unable to fetch Game Data');
    }
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
        title: Text('Game Details'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  // Insert SPINNER here, if required.
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: finalPadding * 0.40),
                        child: SpinKitFadingCube(
                          color: Colors.white,
                          size: 40,
                        )),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GameSlider(snapshot.data.gameScreenshots),
                        SizedBox(
                          height: 25.0,
                        ),

                        // CONDITION: If game has NO price(AED 0.00), REMOVE ENTIRE  'ADD TO CART' section.
                        snapshot.data.gamePrice == 0
                            ? SizedBox(
                                height: 0,
                              )
                            : (Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.gameName,
                                    style: TextStyle(
                                        fontFamily: 'FiraSans-Medium',
                                        fontSize: 26.0,
                                        color: Color(0xffffffff)),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    snapshot.data.gamePrice == 0
                                        ? 'TBA'
                                        : 'AED ${snapshot.data.gamePrice}.00',
                                    style: TextStyle(
                                        fontFamily: 'FiraSans-Medium',
                                        fontSize: 20.0,
                                        color: Color(0xff20b830)),
                                  ),

                                  Divider(
                                    height: 50.0,
                                    color: Color(0xffa0a0a0),
                                  ),

                                  // QUANTITY
                                  Text('Quantity',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)),

                                  DropdownButton<String>(
                                    value: qty,
                                    style: TextStyle(color: Colors.white),
                                    dropdownColor: Color(0xff151515),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        qty = newValue!;
                                      });
                                    },
                                    items: <String>['1', '2', '3', '4', '5']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                        .toList(),
                                  ),

                                  Divider(
                                    height: 50.0,
                                    color: Color(0xffa0a0a0),
                                  ),
                                  // EDITION
                                  Text('Edition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  GroupButton(
                                    isRadio: true,
                                    spacing: 15,
                                    selectedColor: Colors.white,
                                    selectedTextStyle:
                                        TextStyle(color: Color(0xff151515)),
                                    borderRadius: BorderRadius.circular(6),
                                    unselectedColor: Colors.transparent,
                                    unselectedTextStyle:
                                        TextStyle(color: Colors.white),
                                    unselectedBorderColor: Colors.white,
                                    buttons: ['Standard', 'Collectors'],
                                    onSelected: (index, isSelected) => {
                                      setState(() {
                                        edition = index == 0
                                            ? 'Standard'
                                            : 'Collectors';
                                      })
                                    },
                                  ),

                                  Divider(
                                    height: 50.0,
                                    color: Color(0xffa0a0a0),
                                  ),
                                  // CONDITION
                                  Text('Condition',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  GroupButton(
                                    isRadio: true,
                                    selectedColor: Colors.white,
                                    selectedTextStyle:
                                        TextStyle(color: Color(0xff151515)),
                                    borderRadius: BorderRadius.circular(6),
                                    unselectedColor: Colors.transparent,
                                    unselectedTextStyle:
                                        TextStyle(color: Colors.white),
                                    unselectedBorderColor: Colors.white,
                                    buttons: ['New'],
                                    onSelected: (index, isSelected) => {
                                      setState(() {
                                        condition = index == 0 ? 'New' : '';
                                      })
                                    },
                                  ),

                                  SizedBox(
                                    height: 25,
                                  ),

                                  // ADD TO CART BUTTON
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50.0,
                                    child: ElevatedButton(
                                      autofocus: false,
                                      clipBehavior: Clip.none,
                                      onPressed: () {
                                        if (edition == '' || condition == '') {
                                          setState(() {
                                            error = true;
                                          });
                                        } else {
                                          // Set Error to 'false'
                                          error = false;
                                          // Add Item to 'Cart'
                                          Provider.of<CartItemsData>(context,
                                                  listen: false)
                                              .addCartItems(
                                                  snapshot.data.gameId,
                                                  snapshot.data.gameName,
                                                  snapshot.data.gamePrice,
                                                  snapshot.data.gameDescription,
                                                  snapshot.data.gameBoxArt,
                                                  snapshot.data.gamePlatform,
                                                  qty,
                                                  edition,
                                                  condition,
                                                  snapshot.data.gameCategory);
                                          // Route to 'Cart Items Page'
                                          // Open 'Bottom Modal' to provide routing option
                                          showModalBottomSheet(
                                              enableDrag: true,
                                              context: context,
                                              builder: (context) =>
                                                  CartBottomModal(
                                                      itemImage: snapshot
                                                          .data.gameBoxArt,
                                                      itemName: snapshot
                                                          .data.gameName));
                                        }
                                      },
                                      child: Text(
                                        "ADD TO CART",
                                        style: TextStyle(
                                            fontFamily: 'FiraSans-Medium',
                                            fontSize: 18.0,
                                            letterSpacing: 0.5),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xff20b830))),
                                    ),
                                  ),

                                  // ERROR CHECK
                                  error == true
                                      ? Center(
                                          child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            'Ensure all the above fields are selected',
                                            style: TextStyle(
                                                fontFamily: 'FiraSans-Medium',
                                                fontSize: 14.0,
                                                color: Colors.pinkAccent[400]),
                                          ),
                                        ))
                                      : SizedBox(height: 0),

                                  SizedBox(
                                    height: 50.0,
                                  ),
                                ],
                              )),

                        // ABOUT SECTION
                        Text(
                          "About ${snapshot.data.gameName}",
                          style: TextStyle(
                              fontFamily: 'FiraSans-Medium',
                              fontSize: 26.0,
                              color: Color(0xffffffff)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('${snapshot.data.gameDescription}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xffb4b4b4),
                                fontSize: 18.0,
                                height: 1.5)),
                        SizedBox(height: 30.0),

                        //  GAME FACTS
                        GameGridItem(
                            'Platforms', '${snapshot.data.gamePlatforms}'),
                        GameGridItem('Metascore',
                            '${snapshot.data.gameMetacriticScore == 0 ? "N/A" : snapshot.data.gameMetacriticScore}'),
                        GameGridItem('Genre', '${snapshot.data.gameGenres}'),
                        GameGridItem(
                            'Release Date', '${snapshot.data.gameReleased}'),
                        GameGridItem(
                            'Developer', '${snapshot.data.gameDeveloper}'),
                        GameGridItem(
                            'Publisher', '${snapshot.data.gamePublisher}'),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
