part of app;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  createState() => _HomePageState();
}

class _HomePageState extends StateEvent<HomePage>
    with TickerProviderStateMixin {
  Future<DataProvider> future;
  @override
  void initState() {
    future = getdata();
    super.initState();
  }

  Future<DataProvider> getdata() async {
    var jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/Category.json");

    var data = json.decode(jsonData.toString());

    var create = MenuVO();
    var provider = DataProvider();

    data.forEach((key, value) {
      var list = Factory.fromJson(value, create);
      provider.add(key, list);
    });
    return provider;
  }

  //刷新数据,重新设置future就行了
  Future refresh() async {
    setState(() {
      future = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: onDataReady,
    );
  }

  Widget onDataReady(
      BuildContext context, AsyncSnapshot<DataProvider> snapshot) {
    if (snapshot.connectionState == ConnectionState.active ||
        snapshot.connectionState == ConnectionState.waiting) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return new Center(
          child: new Text("ERROR"),
        );
      }

      if (snapshot.hasData == false) {
        return new Center(
          child: new Text("NONDATA"),
        );
      }
    }

    var data = snapshot.data;
    Widget ui = CustomScrollView(
      slivers: <Widget>[
        getTopSliver(data),
        getSwiperSlive(data),
        getSecondTabSlive(data),
        getLastTitleSlive(data),
        getCardListSlive(),
        getLastTitleSlive(data),
        getLastListSlive(data)
      ],
    );
    return Container(color: Colors.white, child: SafeArea(child: ui));
  }

  Widget getTopSliver(DataProvider value) {
    Widget headerUI = Column(children: <Widget>[
      TopTabBar(value, this),
      SearchBar(),
    ]);
    headerUI = Container(
      padding: AppStyle.mainPaddingLR,
      child: headerUI,
    );
    var header = SliverPersistentHeaderDelegateEx(headerUI);
    header.maxHeight = 90;
    header.minHeight = 90;

    return SliverPersistentHeader(
      pinned: false,
      floating: true,
      delegate: header,
    );
  }

  Widget getSwiperSlive(DataProvider value) {
    Widget ui = Column(
      children: <Widget>[
        SwiperAd(value),
        SwiperCategory(
          value,
        ),
      ],
    );

    return SliverToBoxAdapter(
      child: ui,
    );
  }

  Widget getSecondTabSlive(DataProvider value) {
    Widget ui = SubTabBar(value, this);
    var header = SliverPersistentHeaderDelegateEx(ui);
    header.maxHeight = Ux.px(40);
    header.minHeight = Ux.px(40);

    return SliverPersistentHeader(
      pinned: true,
      delegate: header,
    );
  }

  Widget getLastTitleSlive(DataProvider value) {
    Widget ui = SingleBar();
    return SliverToBoxAdapter(
      child: ui,
    );
  }

  Widget getCardListSlive() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CardItem();
        },
        childCount: 3,
      ),
    );
  }

  List<GoodsVO> products;
  Widget getLastListSlive(DataProvider value) {
    if (products == null) {
      Random rnd = new Random();
      products = List.generate(50, (i) {
        var vo = GoodsVO.test(rnd);
        vo.name = "TEST$i";
        return vo;
      });
    }
    ;
    Widget ui = SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      staggeredTileBuilder: (_) => StaggeredTile.fit(1),
      itemBuilder: (context, index) => GoodsCard(
        goodsVO: products[index],
      ),
      itemCount: products.length,
    );

    return ui;
  }
}
