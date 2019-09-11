library app;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:ebshop/foundation/foundation.dart';
import 'package:ebshop/pages/car/CartPage.dart';
import 'package:ebshop/pages/home/GoodsCard.dart';
import 'package:ebshop/pages/widgets/CustomShape.dart';
import 'package:ebshop/provide/CartProvide.dart';
import 'package:ebshop/provide/CurrentIndexProvide.dart';
import 'package:ebshop/provide/DetailsProvide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pages/HomePage.dart';
part "pages/IndexPage.dart";
part 'pages/PersionalPage.dart';
part 'pages/delegate/SliverPersistentHeaderDelegate.dart';
part 'pages/delegate/search_bar_delegate.dart';
part 'pages/home/Card.dart';
part 'pages/home/SearchBar.dart';
part 'pages/home/SubTabBar.dart';
part 'pages/home/SwiperAd.dart';
part 'pages/home/SwiperCategory.dart';
part 'pages/home/TopTabBar.dart';
part 'pages/login/LoginCode.dart';
part 'pages/login/LoginMobile.dart';
part 'pages/login/LoginPage.dart';
part 'pages/login/Signin.dart';
part 'pages/post/PostArticlePage.dart';
part 'pages/splash/Splash.dart';

part 'pages/widgets/DotSwiper.dart';
part 'pages/widgets/FormModelUI.dart';
part 'pages/widgets/FromItem.dart';
part 'pages/widgets/SingleBar.dart';

part 'utils/Core.dart';
part 'utils/Utils.dart';
part "vos/vos.dart";

void main() {
  var providers = Providers();
  providers.provide(Provider.value(CurrentIndexProvide()));
  providers.provide(Provider.value(DetailsProvide()));
  providers.provide(Provider.value(CartProvide()));

  
  runApp(ProviderNode(child: App(), providers: providers));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //设计时的宽度
    Ux.init(375);
    Core.mainContext = context;

    return MaterialApp(
      title: 'ebShop',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      home: SplashPage(),
      debugShowCheckedModeBanner: true,
    );
  }

  final Map<String, WidgetBuilder> routes = {
    '/MainPage': (ctx) => IndexPage(),
    '/LoginPage': (ctx) => LoginPage(),
    '/SigninPage': (ctx) => SigninPage(),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final String name = settings.name;
    final Function pageBuilder = this.routes[name];
    if (pageBuilder != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageBuilder(context, arguments: settings.arguments));
      return route;
    }
  }
}
