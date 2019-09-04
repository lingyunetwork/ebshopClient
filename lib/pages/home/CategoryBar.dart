part of app;
class CategoryBar extends StatelessWidget {
  final List<MenuVO> dataProvider;
  final TabController controller;
  const CategoryBar(this.dataProvider,this.controller,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  

   var ui = TabBar(
      labelPadding: EdgeInsets.only(right: 10),
      tabs: dataProvider.map((item)=>Util.getMinTab(item.name)).toList(),
      controller: controller,
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