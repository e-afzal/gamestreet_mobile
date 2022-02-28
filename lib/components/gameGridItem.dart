import 'package:flutter/material.dart';

class GameGridItem extends StatelessWidget {
  final gridTitle;
  final gridItem;
  GameGridItem(this.gridTitle, this.gridItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gridTitle,
            style: TextStyle(
                fontFamily: 'FiraSans-Medium',
                fontSize: 18.0,
                color: Colors.white),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            gridItem,
            style: TextStyle(
                fontFamily: 'FiraSans-Medium',
                fontSize: 18.0,
                color: Color(0xffa0a0a0)),
          ),
          SizedBox(
            height: 25.0,
          )
        ],
      ),
    );
  }
}
