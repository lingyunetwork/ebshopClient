part of app;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with EStage, TickerProviderStateMixin {
  TabController _tabController;
  TabController _slivertabController;
  List<Widget> categoryTabs;
  @override
  void initState() {
    categoryTabs = List();

    for (var i = 0; i < 20; i++) {
      var text = "美妆$i";
      double w = 20 * text.length.toDouble();
      var tab = Container(
        //color: Colors.red,
        width: w,
        height: 30,
        child: Util.getMinTab(text),
      );
      categoryTabs.add(tab);
    }

    _tabController = TabController(length: categoryTabs.length, vsync: this);
    _slivertabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
     
      category(),
      SingleBar(),
      CardItem(),
      CardItem(),
      CardItem(),
    ];

    Widget ui = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverPersistentHeaderDelegate(TabBar(
                controller: _slivertabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "hello",),
                  Tab(text: "world",),
                ])),
          ),
        ];
      },
      body: ListView(children: list),
    );

    return Column(
      children: <Widget>[
        SearchBar(),
        categoryBar(),
         swiper(),
        Expanded(child: ui),
      ],
    );
  }

  Widget categoryBar() {
    var ui = TabBar(
      labelPadding: EdgeInsets.all(0),
      tabs: categoryTabs,
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Colors.yellow,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3,

      labelColor: ColorU.selectedColor,

      /// 简单暴力的解决办法，左右间距根据上边间隔符的大小决定
      //indicatorPadding: EdgeInsets.only(left: 15, bottom: 0.5, right: 15),
      unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 16, color: Colors.black),
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

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverPersistentHeaderDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
