import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashboardImageCarousel extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();

  DashboardImageCarousel({
    Key? key,
  }) : super(key: key);

  final List<String> items = [
    //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzD87JlVDN3LaBfRfMPsf2mKEXltAigADgW-6nXeAKc9LSJnYlgZ0HnHd2XCBnMN7Heb4&usqp=CAU',
    //'https://st.depositphotos.com/1000423/4113/i/450/depositphotos_41137937-stock-photo-cute-boy-with-banner.jpg',
    //'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX26669067.jpg',
    'https://i.ibb.co/7YQTWkH/meetingme-banner.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // return Container(
    //   child: Container(
    //       padding: EdgeInsets.only(top: height * .015),
    //       //color: Colors.red,
    //       width: width * 1,
    //       height: height * .153,
    //       //margin: EdgeInsets.only(top: height * .01),
    //       child: CarouselSlider.builder(
    //         itemCount: items.length,
    //         options: CarouselOptions(
    //           autoPlay: true,
    //           aspectRatio: 2.0,
    //           enlargeCenterPage: true,
    //         ),
    //         itemBuilder: (context, index, realIdx) {
    //           return Center(
    //             child: Image.network(
    //               items[index],
    //               fit: BoxFit.cover,
    //               width: MediaQuery.of(context).size.width * .9,
    //             ),
    //           );
    //         },
    //       )),
    // );
    return Container(
      //padding: EdgeInsets.only(top: height * .018),
      margin: EdgeInsets.only(top: height * .024),
      child: Center(
        child: Image.network(
          'https://i.ibb.co/7YQTWkH/meetingme-banner.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 1,
          height: height * .13,
        ),
      ),
    );
  }
}
