library app;

import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:ebshop/foundation/foundation.dart';

part "pages/Index.dart";


part 'pages/Persional.dart';
part 'pages/register/Login.dart';
part 'pages/register/LoginMobile.dart';

part 'pages/Home.dart';
part 'pages/home/TopTabBar.dart';
part 'pages/home/SearchBar.dart';
part 'pages/home/SubTabBar.dart';
part 'pages/home/Card.dart';
part 'pages/home/SwiperCategory.dart';


part 'pages/home/SwiperAd.dart';

part 'pages/widgets/SingleBar.dart';


part 'pages/utils/Utils.dart';
part "pages/vos/vos.dart";

part 'pages/delegate/search_bar_delegate.dart';
part 'pages/delegate/SliverPersistentHeaderDelegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //设计时的宽度
    Ux.init(375);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(title: 'Flutter Demo Home Page'),

      debugShowCheckedModeBanner: true,
    );
  }
}
