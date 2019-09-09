import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:saveat/model/MyCarousel.dart';
import 'package:saveat/requestHandler/myHandler.dart';
import 'package:saveat/widgets/myCarousel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselMain extends StatefulWidget {
  @override
  _CarouselMainState createState() => _CarouselMainState();
}

class _CarouselMainState extends State<CarouselMain> {
  List<MyCarouselModel> categorylist = List();
  Future<dynamic> _fetchBanners() async {
    var responseBody =
        await makeGetRequest('http://192.168.1.2:8080/API-banners');
    // var responseJson = json.decode(responseBody) as List;
    setState(() {
      categorylist = (json.decode(responseBody)['mainBanner'] as List)
          .map((data) => MyCarouselModel.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    var parentHeight = MediaQuery.of(context).size.height;
    var parentWidth = MediaQuery.of(context).size.width;
    Widget carousel = categorylist == null
        ? CircularProgressIndicator()
        : CarouselSlider(
            items: categorylist.map((it) {
              return new Container(
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(),
                child: new Image.asset(it.toString()),
              );
            }).toList(),
            autoPlay: true,
            //  autoPlayDuration: new Duration(seconds: 2),
            height: 200,
          );

    return carousel;
  }
}
