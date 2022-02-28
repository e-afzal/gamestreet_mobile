import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/class/search.dart';

// THIRD PARTY PACKAGE
import 'package:dropdown_below/dropdown_below.dart';

class BottomModalFilter extends StatefulWidget {
  @override
  _BottomModalFilterState createState() => _BottomModalFilterState();

  final sendCategory;
  final sendAvailability;
  final sendPrice;
  final sendPlatform;
  final sendFilteredResult;
  BottomModalFilter(
      {this.sendCategory,
      this.sendAvailability,
      this.sendPrice,
      this.sendPlatform,
      this.sendFilteredResult});
}

class _BottomModalFilterState extends State<BottomModalFilter> {
  // Values that'll change based on user selected 'filters'
  var _selectedCategory;
  var _selectedPrice;
  var _selectedAvailability;
  var _selectedPlatform;

  @override
  Widget build(BuildContext context) {
    // CATEGORY related
    List categoryList = [
      {'index': 0, 'category': 'consoles'},
      {'index': 1, 'category': 'games'},
      {'index': 2, 'category': 'accessories'},
      {'index': 3, 'category': 'merchandises'}
    ];

    List<DropdownMenuItem> _categoryDropdownItems = [];

// Loop through function returning EACH item as DropDownMenuItem
    for (var item in categoryList) {
      _categoryDropdownItems.add(DropdownMenuItem(
          value: item['category'], child: Text(item['category'])));
    }

    // AVAILABILITY related
    List availabilityList = [
      {'index': 0, 'availability': 'In Stock'},
      {'index': 1, 'availability': 'Out of Stock'},
    ];

    List<DropdownMenuItem> _availabilityDropdownItems = [];

    // Loop through function adding EACH 'DropDownItem' as DropDownMenuItem in it's 'LIST'
    for (var item in availabilityList) {
      _availabilityDropdownItems.add(DropdownMenuItem(
          value: item['availability'], child: Text(item['availability'])));
    }

    // PRICE related
    List priceList = [
      {'index': 0, 'price': '0-500'},
      {'index': 1, 'price': '500-1000'},
      {'index': 2, 'price': '1000-1500'},
      {'index': 3, 'price': '1500-2000'},
      {'index': 4, 'price': '2000+'},
    ];

    List<DropdownMenuItem> _priceDropdownItems = [];

    // Loop through function returning EACH item as DropDownMenuItem
    for (var item in priceList) {
      _priceDropdownItems.add(
          DropdownMenuItem(value: item['price'], child: Text(item['price'])));
    }

    // PLATFORM related
    List platformList = [
      {'index': 0, 'platform': 'PS5'},
      {'index': 1, 'platform': 'PS4'},
      {'index': 2, 'platform': 'Xbox Series X|S'},
      {'index': 3, 'platform': 'Xbox One'},
      {'index': 4, 'platform': 'Nintendo Switch'},
    ];

    List<DropdownMenuItem> _platformDropdownItems = [];

    // Loop through function returning EACH item as DropDownMenuItem
    for (var item in platformList) {
      _platformDropdownItems.add(DropdownMenuItem(
          value: item['platform'], child: Text(item['platform'])));
    }

    return Container(
      color: Color(0xff151515),
      child: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FILTERS',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FiraSans-Medium',
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        print('RESET FILTERS TAPPED');
                        setState(() {
                          _selectedCategory = null;
                          _selectedAvailability = null;
                          _selectedPrice = null;
                          _selectedPlatform = null;
                        });
                      },
                      child: Icon(
                        Icons.restore,
                        color: Color(0xffdc143c),
                      )),
                ],
              ),
              Divider(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CATEGORY DROPDOWN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                                fontFamily: 'FiraSans-Medium', fontSize: 18),
                          ),
                          DropdownBelow(
                            items: _categoryDropdownItems,
                            value: _selectedCategory,
                            onChanged: (val) {
                              setState(() {
                                _selectedCategory = val;
                              });
                            },
                            hint: Row(
                              children: [
                                Text(_selectedCategory != null
                                    ? _selectedCategory
                                    : 'Select category'),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Color(
                                    0XFFbbbbbb,
                                  ),
                                )
                              ],
                            ),
                            itemWidth: 200,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato-Regular',
                                color: Color(0XFFbbbbbb)),
                            boxPadding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            boxHeight: 45,
                          ),
                        ],
                      ),

                      // PRICE DROPDOWN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                                fontFamily: 'FiraSans-Medium', fontSize: 18),
                          ),
                          DropdownBelow(
                            items: _priceDropdownItems,
                            value: _selectedPrice,
                            onChanged: (val) {
                              setState(() {
                                _selectedPrice = val;
                              });
                            },
                            hint: Row(
                              children: [
                                Text(_selectedPrice == null
                                    ? 'Select price range'
                                    : _selectedPrice),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Color(
                                    0XFFbbbbbb,
                                  ),
                                )
                              ],
                            ),
                            itemWidth: 200,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato-Regular',
                                color: Color(0XFFbbbbbb)),
                            boxPadding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            boxHeight: 45,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AVAILABILITY DROPDOWN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Availability',
                            style: TextStyle(
                                fontFamily: 'FiraSans-Medium', fontSize: 18),
                          ),
                          DropdownBelow(
                            items: _availabilityDropdownItems,
                            value: _selectedAvailability,
                            onChanged: (val) {
                              setState(() {
                                _selectedAvailability = val;
                              });
                            },
                            hint: Row(
                              children: [
                                Text(_selectedAvailability == null
                                    ? 'Select availability'
                                    : _selectedAvailability),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Color(
                                    0XFFbbbbbb,
                                  ),
                                )
                              ],
                            ),
                            itemWidth: 200,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato-Regular',
                                color: Color(0XFFbbbbbb)),
                            boxPadding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            boxHeight: 45,
                          ),
                        ],
                      ),

                      // PLATFORM DROPDOWN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Platform',
                            style: TextStyle(
                                fontFamily: 'FiraSans-Medium', fontSize: 18),
                          ),
                          DropdownBelow(
                            items: _platformDropdownItems,
                            value: _selectedPlatform,
                            onChanged: (val) {
                              setState(() {
                                _selectedPlatform = val;
                              });
                            },
                            hint: Row(
                              children: [
                                Text(_selectedPlatform == null
                                    ? 'Select platform'
                                    : _selectedPlatform),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Color(
                                    0XFFbbbbbb,
                                  ),
                                )
                              ],
                            ),
                            itemWidth: 200,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato-Regular',
                                color: Color(0XFFbbbbbb)),
                            boxPadding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            boxHeight: 45,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

              // APPLY 'FILTERS' BUTTON
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  onPressed: () async {
                    print('APPLY FILTERS TAPPED');
                    widget.sendCategory(_selectedCategory);
                    widget.sendPrice(_selectedPrice);
                    widget.sendAvailability(_selectedAvailability);
                    widget.sendPlatform(_selectedPlatform);

                    var filteredResult = await SearchResults()
                        .fetchFilteredResults(
                            category: _selectedCategory,
                            price: _selectedPrice,
                            availability: _selectedAvailability,
                            platform: _selectedPlatform);
                    widget.sendFilteredResult(filteredResult);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "APPLY FILTERS",
                    style: TextStyle(
                        fontFamily: 'FiraSans-Medium',
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2.5),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffdc143c))),
                ),
              ),
            ],
          )),
    );
  }
}
