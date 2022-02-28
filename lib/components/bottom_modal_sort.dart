import 'package:flutter/material.dart';

class BottomModalSort extends StatefulWidget {
  @override
  _BottomModalSortState createState() => _BottomModalSortState();

  final sendSort;
  BottomModalSort({this.sendSort});
}

class _BottomModalSortState extends State<BottomModalSort> {
  // Values that'll change based on user selected 'sort' value
  String sortMethod = 'PriceH2L';

  // Radio Buttons Text
  List radioButtonList = [
    {'text': 'Price (Highest to Lowest)', 'value': 'PriceH2L'},
    {'text': 'Price (Lowest to Highest)', 'value': 'PriceL2H'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff151515),
        child: Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort by',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FiraSans-Medium',
                    ),
                  ),
                ],
              ),
              Divider(
                height: 30,
              ),

              // RADIO BUTTONS
              ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: radioButtonList
                    .map((each) => RadioListTile<String>(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            each['text'],
                            style: TextStyle(
                                color: Color(0xff676767),
                                fontFamily: 'Lato-Regular',
                                height: 1.5),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xff676767),
                        value: each['value'],
                        groupValue: sortMethod,
                        onChanged: (value) {
                          setState(() {
                            sortMethod = value.toString();
                          });
                        }))
                    .toList(),
              ),

              // APPLY 'SORT' BUTTON
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
                    print('APPLY SORT TAPPED');
                    widget.sendSort(sortMethod);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "APPLY SORTING",
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
            ])));
  }
}
