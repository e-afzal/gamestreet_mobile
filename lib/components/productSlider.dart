import 'package:flutter/material.dart';

// THIRD PARTY PACKAGES
import 'package:carousel_slider/carousel_slider.dart';

class ProductSlider extends StatelessWidget {
  final List images;
  ProductSlider(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          height: 275),
      items: images
          .map((item) => Container(
                child: Image.asset(
                  'assets$item',
                  fit: BoxFit.cover,
                  // width: 1000,
                ),
              ))
          .toList(),
    ));
  }
}
