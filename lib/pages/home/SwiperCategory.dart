part of app;

class SwiperCategory extends StatefulWidget {
  final DataProvider dataProvider;
  const SwiperCategory(this.dataProvider, {Key key}) : super(key: key);

  @override
  _SwiperCategoryState createState() => _SwiperCategoryState();
}

class _SwiperCategoryState extends State<SwiperCategory> {
  List<Widget> navigatorList;
  List<MenuVO> data;
  @override
  void initState() {
    data=widget.dataProvider.get("iconMenu");
    navigatorList = List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        color: Colors.white,
        child: Swiper(
          itemBuilder: _itemBuilder,
          itemCount: 2,
          pagination: new SwiperPagination(),
          autoplay: false,
          loop: false,
        ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    navigatorList.clear();
    for (var i = 0; i < 10; i++) {
      var item = data[index * 10 + i];
      if (item != null) {
        navigatorList.add(_getItem(context, item));
      }
    }

    return GridView.count(
      padding: EdgeInsets.only(top: 10),
      mainAxisSpacing: 0,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      children: navigatorList,
    );
  }

  Widget _getItem(BuildContext context, MenuVO value) {
    //var icon=Image.network(value.icon,fit: BoxFit.fill,);

    var ui = Container(
        height: 62,
        //color: Colors.red,
        child: Column(children: <Widget>[
          Expanded(child: Icon(Feather.message_square)),
          TextU.getDef(
            value.name,
          )
        ]));

    return InkWell(
      onTap: () {},
      child: Center(child: ui),
    );
  }
}
