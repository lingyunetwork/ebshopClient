part of app;
class CategoryBar extends StatefulWidget {
  final DataProvider dataProvider;
  final TickerProvider parentState;
  
  const CategoryBar(this.dataProvider,this.parentState,{Key key}) : super(key: key);

  @override
  _CategoryBarState createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  TabController _controller;
  List<MenuVO> data;
  @override
  void initState() { 
    super.initState();
    data=widget.dataProvider.get("tabMenu");
    _controller=TabController(length: data.length,vsync: widget.parentState,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {


   var ui = TabBar(
      labelPadding: EdgeInsets.only(right: 10),
      tabs: data.map((item)=>Util.getMinTab(item.name)).toList(),
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
    return ui;
  }
}