import 'package:ebshop/foundation/foundation.dart';
import 'package:ebshop/pages/utils/Core.dart';
import 'package:ebshop/pages/widgets/DotSwiperPaginationBuilderE.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends StateEvent<SplashPage>  {
  Widget _page;
  SharedPreferences sharedPreferences;
  Countdowner countdowner;

  @override
  void initState() {
    super.initState();

    countdowner = Countdowner();

    _loadSplashData();
    _initAsync();
  }

  void _loadSplashData() async {
    //去加载广告

    //todo save;
  }

  void _initAsync() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(Constant.KEY_GUIDE) != true) {
      sharedPreferences.setBool(Constant.KEY_GUIDE, true);
      _initGuides();
    } else {
      _initSplash();
    }

    invalidate();
  }

  void _initGuides() {
    var len = 5;
    Widget ui;
    ui = Swiper(
      itemBuilder: _itemBuilder,
      itemCount: len,
      pagination: new SwiperPagination(
          margin: const EdgeInsets.all(3.0),
          builder: DotSwiperPaginationBuilderE()),
      scale: 1.0,
      autoplay: true,
    );

    _page = Container(
        color: Colors.grey, width: Ux.px(375), height: Ux.px(200), child: ui);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var url = "assets/guide/$index.jpg";
    if (index == 4) {
      return new Stack(
        children: <Widget>[
          _getImage(url),
          _getEnterBtn(),
        ],
      );
    }
    return _getImage(url);
  }

  Widget _getEnterBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: new Container(
        margin: EdgeInsets.only(bottom: 160.0),
        child: new RaisedButton(
          textColor: Colors.white,
          color: Colors.indigoAccent,
          child: Text(
            '立即体验',
            style: new TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            _goMain();
          },
        ),
      ),
    );
  }

  Widget _getImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.fitWidth,
      width: double.infinity,
      height: double.infinity,
    );
  }

  _initSplash() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var adURL = sharedPreferences.getBool(Constant.KEY_AD);
    if (adURL != null) {
    } else {
      _page = _buildSplashBG();
      countdowner.start(1, tick);
    }

    invalidate();
  }

  void tick(int time) {
    //todo显示倒计时
    if (time == 0) {
      _goMain();
    }
  }

  void _goMain() {
    Core.sharedPreferences = sharedPreferences;
    var token=sharedPreferences.get(Constant.KEY_TOKEN);
    if(token==null){
      RECT.setToken(token);
    }

    var uri = "/MainPage";
    var isLogged = sharedPreferences.containsKey(Constant.KEY_LOGGED);
    if (isLogged == false) {
      uri = '/LoginPage';
    }
    Navigator.of(context).pushReplacementNamed(uri);
  }

  Widget _buildSplashBG() {
    return new Image.asset(
      getImgPath('splash'),
      width: double.infinity,
      fit: BoxFit.cover,
      height: double.infinity,
    );
  }

  String getImgPath(String key) {
    return "assets/guide/$key.jpg";
  }

  @override
  Widget build(BuildContext context) {
    if (_page == null) {
      _page = new Container();
    }

    if (countdowner.isRunnig) {}

    return new Material(child: _page);
  }

  @override
  void dispose() {
    countdowner.stop();
    super.dispose();
  }
}
