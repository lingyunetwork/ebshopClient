part of app;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with EStage, TickerProviderStateMixin {
  PageList categoryList;

  TabController _tabController;
  @override
  void initState() {
    categoryList = PageList(Axis.horizontal);
    categoryList.createItemRender = () {
      return IListItemRender();
    };

    var categorys = <String>[];
    for (var i = 0; i < 20; i++) {
      categorys.add('美妆$i');
    }
    categoryList.state = this;
    categoryList.dataProvider = categorys;

    _tabController = TabController(length: 2, vsync: this);

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
    ];

    Widget ui = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            elevation: innerBoxIsScrolled?0:1,
            title: Text("标题"),
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("多出来的标题",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550383267899&di=9b9fe57bd7a0bd55c7d673ad449360b1&imgtype=0&src=http%3A%2F%2Fpptdown.pptbz.com%2Fpptbeijing%2F%25E9%2592%25A2%25E9%2593%2581%25E4%25BE%25A0%25E5%25B8%2585%25E6%25B0%2594%25E6%2589%258B%25E7%25BB%2598%25E8%25AE%25BE%25E8%25AE%25A1PPT%25E8%2583%258C%25E6%2599%25AF%25E5%259B%25BE%25E7%2589%2587.jpg",
                  fit: BoxFit.fill,
                )),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverPersistentHeaderDelegate(TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: "tab1"),
                  Tab(icon: Icon(Icons.person), text: "tab2"),
                ])),
          ),
        ];
      },
      body: ListView(children: list),
    );

    return Column(
      children: <Widget>[
        SearchBar(),
        categoryList.getView(),
        Expanded(child: ui),
      ],
    );
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
