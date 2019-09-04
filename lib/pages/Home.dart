part of app;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with EStage, TickerProviderStateMixin {
  TabController _tabController;
  Future future;
  @override
  void initState() {
    future = getdata();
    super.initState();
  }

  Future getdata() async {
    var jsonData = await
        DefaultAssetBundle.of(context).loadString("assets/json/Category.json");

    var data = json.decode(jsonData.toString());

    var create = MenuVO();
    List<List<MenuVO>> list = [];

    var tabs=Factory.fromJson(data, "tabMenu", create);
    list.add(tabs);
    list.add(Factory.fromJson(data, "iconMenu", create));
    list.add(Factory.fromJson(data, "swipers", create));

    _tabController=TabController(length:tabs.length,vsync: this,initialIndex: 0 );
    return list;
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

  Widget onDataReady(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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

      if(snapshot.hasData==false){
         return new Center(
          child: new Text("NONDATA"),
        );
      }
    }


    var data = snapshot.data as List<List<MenuVO>>;
    var tabMenuList = data[0];
    var iconMenuList = data[1];
    var swipersList = data[2];

    var listBody = <Widget>[
      SwiperDiy(swipersList),
      SwiperCategory(iconMenuList,),
      SingleBar(),
      CardItem(),
      CardItem(),
      CardItem(),
      CardItem(),
      CardItem(),
    ];

    Widget headerUI = Column(children: <Widget>[
      SearchBar(),
      CategoryBar(tabMenuList,_tabController)
    ]);
    headerUI = Container(
      padding: AppStyle.mainPaddingLR,
      child: headerUI,
    );
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
      body: ListView(children: listBody),
    );
    return ui;
  }
}
