library app;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

//package;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebshop/foundation/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


//pages;
part 'pages/login/Signin.dart';
part 'pages/splash/Splash.dart';
part 'pages/utils/Core.dart';

part 'pages/widgets/DotSwiper.dart';
part "pages/IndexPage.dart";


part 'pages/PersionalPage.dart';
part 'pages/login/LoginPage.dart';
part 'pages/login/LoginMobile.dart';
part 'pages/login/LoginCode.dart';

part 'pages/HomePage.dart';
part 'pages/home/TopTabBar.dart';
part 'pages/home/SearchBar.dart';
part 'pages/home/SubTabBar.dart';
part 'pages/home/Card.dart';
part 'pages/home/SwiperCategory.dart';

part 'pages/post/PostArticlePage.dart';


part 'pages/home/SwiperAd.dart';

part 'pages/widgets/SingleBar.dart';
part 'pages/widgets/FromItem.dart';

part 'pages/utils/Utils.dart';
part "pages/vos/vos.dart";


part 'pages/widgets/FormModelUI.dart';
part 'pages/delegate/search_bar_delegate.dart';
part 'pages/delegate/SliverPersistentHeaderDelegate.dart';

void main()=>
 runApp( App());
class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //设计时的宽度
    Ux.init(375);
    Core.mainContext=context;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      routes: {
        '/MainPage': (ctx) => IndexPage(),
        '/LoginPage': (ctx) => LoginPage(),
        '/SigninPage': (ctx) => SigninPage(),
      },
      home:SplashPage(),
      debugShowCheckedModeBanner: true,
    );
  }
}
