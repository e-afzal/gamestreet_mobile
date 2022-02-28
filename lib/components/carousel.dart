import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/pages/Singlegame.dart';

// THIRD PARTY PACKAGES
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
  final List images;
  Carousel(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(enlargeCenterPage: true, height: 390.0),
      items: images
          .map((item) => GestureDetector(
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (context) => SingleGame(
                            productId: item['id'],
                          ));
                  Navigator.push(context, route);
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(
                    item['url'],
                    fit: BoxFit.scaleDown,
                    height: 390.0,
                  ),
                ),
              ))
          .toList(),
    ));
  }
}
