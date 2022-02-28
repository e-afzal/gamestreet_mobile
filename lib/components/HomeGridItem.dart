import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/pages/searchPage.dart';

class HomeGridItem extends StatelessWidget {
  final gridTitle;
  final gridImage;
  final backendCategory;
  final backendPlatform;
  HomeGridItem(
      {this.gridTitle,
      this.gridImage,
      this.backendCategory,
      this.backendPlatform});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var route = MaterialPageRoute(
            builder: (context) => SearchPage(
                productCategory: backendCategory,
                productPlatform: backendPlatform));
        Navigator.push(context, route);
      },
      child: Container(
        height: 190.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                // width: double.infinity,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      gridImage,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                gridTitle,
                style: TextStyle(
                    fontFamily: 'FiraSans-Medium',
                    fontSize: 18.0,
                    color: Color(0xffffffff)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
