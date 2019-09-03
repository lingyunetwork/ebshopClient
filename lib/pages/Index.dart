
part of app;

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  TabNav tab;

  @override
  void initState() {
    tab = TabNav();

    tab.addEventListener(EventX.CHANGE,update);

    final tabsVO = [
      TabItemVO('首页', Icons.home,LoginPage()),
      TabItemVO('推荐', Icons.thumb_up,HomePage()),
      TabItemVO('精选', Icons.av_timer,LoginMobilePage()),
      TabItemVO('购物车', Icons.shopping_cart),
      TabItemVO('个人中心', Icons.people,Personal())
    ];

    for (var f in tabsVO) {
      tab.add(f);
    }

    super.initState();
  }

  update(EventX e){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      color: Colors.white,
      child:SafeArea(bottom: false,child:tab.getView()));
  }
}
