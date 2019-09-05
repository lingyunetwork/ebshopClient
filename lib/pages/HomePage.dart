part of app;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with EStage, TickerProviderStateMixin {
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
        getLastListSlive(data)
      ],
    );
    return ui;
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
      pinned: true,
      floating: false,
      delegate: header,
    );
  }

  Widget getSwiperSlive(DataProvider value) {
    Widget ui = Column(
      children: <Widget>[
        SwiperCategory(
          value,
        ),
        SwiperAd(value),
      ],
    );

    return SliverToBoxAdapter(
      child: ui,
    );
  }

  Widget getSecondTabSlive(DataProvider value) {
    Widget ui = SubTabBar(value, this);
    var header = SliverPersistentHeaderDelegateEx(ui);
    header.maxHeight = 40;
    header.minHeight = 40;

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

  Widget getLastListSlive(DataProvider value) {
    var ui = SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('list item $index'),
          );
        },
      ),
    );

    return ui;
  }
}
