import 'package:flutter/material.dart';

// THIRD PARTY PACKAGES
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatelessWidget {
  final List<String> images;
  HomeSlider(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 110.0,
        autoPlay: false,
      ),
      items: images
          .map((item) => Container(
                child: Image.asset(
                  item,
                  fit: BoxFit.fitWidth,
                ),
              ))
          .toList(),
    ));
  }
}
