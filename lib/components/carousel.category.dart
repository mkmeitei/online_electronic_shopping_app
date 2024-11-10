import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/card.carousel.dart';

class CarouselCategory extends StatelessWidget {
  CarouselCategory({super.key});

  // static pictures used in the carousel
  final List<String> data = [
    'assets/images/discount1.jpg',
    'assets/images/discount2.jpg',
    'assets/images/discount3.png'
  ];


  // main part of the carousel
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: data.length,
        options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            animateToClosest: true,
            viewportFraction: 0.8),
        itemBuilder: (context, index, realIndex) {
          return CardCarousel(discountImagePath: data[index]);
        });
  }
}
