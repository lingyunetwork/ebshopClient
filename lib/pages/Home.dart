part of app;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with EStage, TickerProviderStateMixin {
  TabController _tabController;
  List<Widget> categoryTabs;
  @override
  void initState() {
    categoryTabs = List();

    for (var i = 0; i < 20; i++) {
      var text = "美妆$i";
      var tab = Util.getMinTab(text);
      categoryTabs.add(tab);
    }

    _tabController = TabController(length: categoryTabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      swiper(),
      category(),
      SingleBar(),
      CardItem(),
      CardItem(),
      CardItem(),
      CardItem(),
      CardItem(),
    ];

    Widget headerUI = Column(children: <Widget>[SearchBar(), categoryBar()]);
    headerUI=Container(padding: AppStyle.mainPaddingLR,child: headerUI,);
    var header = SliverPersistentHeaderDelegateEx(headerUI);
    header.maxHeight = 93;
    header.minHeight = 93;

    Widget ui = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: header,
          ),
        ];
      },
      body: ListView(children: list),
    );

    return ui;
  }

  Widget categoryBar() {
    var ui = TabBar(
      labelPadding: EdgeInsets.only(right: 10),
      tabs: categoryTabs,
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Colors.yellow,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 5,
      labelColor: ColorU.selectedColor,

      /// 简单暴力的解决办法，左右间距根据上边间隔符的大小决定
      //indicatorPadding: EdgeInsets.only(left: 15, bottom: 0.5, right: 15),
      unselectedLabelColor: ColorU.unselectedColor,
    );
    return ui;
  }

  Widget swiper() {
    var list = <Map>[];

    for (var i = 0; i < 5; i++) {
      var map = <String, dynamic>{};
      map["image"] = "assets/test/timg-2.png";

      list.add(map);
    }

    return SwiperDiy(
      data: list,
    );
  }

  Widget category() {
    var list = [];

    for (var i = 0; i < 2; i++) {
      var t = [];
      for (var i = 0; i < 10; i++) {
        var map = <String, dynamic>{};
        map["title"] = "a";
        map["icon"] = Icons.home;

        t.add(map);
      }

      list.add(t);
    }

    return SwiperCategory(
      data: list,
    );
  }
}

singleBar() {}
