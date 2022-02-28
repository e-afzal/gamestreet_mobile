import 'package:flutter/material.dart';

// THIRD PARTY PACKAGES
import 'package:carousel_slider/carousel_slider.dart';

class GameSlider extends StatelessWidget {
  final List images;
  GameSlider(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          height: 275),
      items: images
          .map((item) => Container(
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  // width: 1000,
                ),
              ))
          .toList(),
    ));
  }
}
