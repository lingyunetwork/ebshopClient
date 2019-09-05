part of app;
class TopTabBar extends StatefulWidget {
  final DataProvider dataProvider;
  final TickerProvider parentState;
  
  const TopTabBar(this.dataProvider,this.parentState,{Key key}) : super(key: key);

  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> {
  TabController _controller;
  List<MenuVO> data;
  @override
  void initState() { 
    super.initState();
    data=widget.dataProvider.get("topTab");
    _controller=TabController(length: data.length,vsync: widget.parentState,initialIndex: 0);
  }

  Widget getTabItem(MenuVO vo){
    var ui = Text(vo.name,style: TextStyle(fontSize: 20),);
    return Center(child: ui);
  }

  @override
  Widget build(BuildContext context) { ThemeData themeData = Theme.of(context);

   var ui = TabBar(
      labelPadding: EdgeInsets.only(left:10,right: 10),
      tabs: data.map(getTabItem).toList(),
      controller: _controller,
      isScrollable: true,
      indicatorColor: themeData.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorPadding: EdgeInsets.only(bottom:0),
      labelColor:  themeData.primaryColor,

      /// 简单暴力的解决办法，左右间距根据上边间隔符的大小决定
      //indicatorPadding: EdgeInsets.only(left: 15, bottom: 0.5, right: 15),
      unselectedLabelColor: ColorU.unselectedColor,
    );
    return Container(
      child: ui,
      padding: EdgeInsets.only(bottom: 10),
    );
  }
}