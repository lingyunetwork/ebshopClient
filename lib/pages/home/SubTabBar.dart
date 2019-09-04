part of app;
class SubTabBar extends StatefulWidget {
  final DataProvider dataProvider;
  final TickerProvider parentState;
  
  const SubTabBar(this.dataProvider,this.parentState,{Key key}) : super(key: key);

  @override
  _SubTabBarState createState() => _SubTabBarState();
}

class _SubTabBarState extends State<SubTabBar> {
  TabController _controller;
  List<MenuVO> data;
  @override
  void initState() { 
    super.initState();
    data=widget.dataProvider.get("tabMenu");
    _controller=TabController(length: data.length,vsync: widget.parentState,initialIndex: 0);
  }
    Widget getTabItem(MenuVO vo){
    var ui = Text(vo.name,style:TextStyle(fontSize: 18),);
    return Center(child: ui);
  }

  @override
  Widget build(BuildContext context) {

   var ui = TabBar(
      //labelPadding: EdgeInsets.only(right: 10),
      tabs: data.map((item)=>getTabItem(item)).toList(),
      controller: _controller,
      isScrollable: true,
      indicatorColor: Colors.yellow,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 5,
      labelColor: ColorU.selectedColor,

      /// 简单暴力的解决办法，左右间距根据上边间隔符的大小决定
      //indicatorPadding: EdgeInsets.only(left: 15, bottom: 0.5, right: 15),
      unselectedLabelColor: ColorU.unselectedColor,
    );
    return Container(
      child: ui,
      width: Ux.px(375),
      height: 40,
      color: Colors.white,
    );
  }
}