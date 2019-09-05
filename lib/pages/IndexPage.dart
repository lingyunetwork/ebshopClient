part of app;

class IndexPage extends StatefulWidget {
  @override
  createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin,EStage {
  List<Widget> pages = [];
  List<BottomNavigationBarItem> bars = [];
  // 页面控制
  TabController _tabController;

  @override
  void initState() {
    addTabItem('首页', Icons.home,HomePage());
    addTabItem('推荐', Icons.thumb_up,LoginPage() );
    addTabItem('精选', Icons.av_timer,LoginMobilePage());
    addTabItem('购物车', Icons.shopping_cart);
    addTabItem('个人中心', Icons.people,Personal());

    _tabController = TabController(length: bars.length, vsync: this);
    _tabController.addListener(() {
      invalidate();
    });

    super.initState();
  }

  addTabItem(String name, IconData icon, [Widget page]) {
    var ui = BottomNavigationBarItem(
        icon: Icon(icon),
        activeIcon: Icon(
          icon,
          color: Colors.redAccent,
        ),
        title: Text(name));
    bars.add(ui);

    if (page == null) {
      page = Center(child: Text("hello empty"));
    }
    pages.add(page);
  }

  // 底部栏切换
  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ui = Scaffold(
      body: pages[_tabController.index],
      bottomNavigationBar: BottomNavigationBar(
          items: bars,
          onTap: _onBottomNavigationBarTap,
          //图标大小
          iconSize: 24,
          //当前选中的索引
          currentIndex: _tabController.index,
          //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
          //fixedColor: Colors.pinkAccent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12),
    );

    ui = SafeArea(bottom: false, child: ui);

    return Container(color: Colors.white, child: ui);
  }
}
