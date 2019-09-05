part of app;

class SwiperCategory extends StatefulWidget {
  final DataProvider dataProvider;
  const SwiperCategory(this.dataProvider, {Key key}) : super(key: key);

  @override
  _SwiperCategoryState createState() => _SwiperCategoryState();
}

class _SwiperCategoryState extends State<SwiperCategory> with EStage {
  List<MenuVO> data;
  @override
  void initState() {
    data = widget.dataProvider.get("iconMenu");
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
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
    List<Widget> navigatorList = List();
    for (var i = 0; i < 10; i++) {
      var item = data[index * 10 + i];
      if (item != null) {
        navigatorList.add(_getItem(context, item));
      }
    }

    return  GridView.count(
      //padding: AppStyle.mainPaddingLR,
      mainAxisSpacing: 10,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      children: navigatorList,
    );
  }

  Widget _getItem(BuildContext context, MenuVO value) {
    //var icon=Image.network(value.icon,fit: BoxFit.fill,);

    var ui = Container(
        //color: Colors.redAccent,
        child: Column(children: <Widget>[
          Expanded(child: Image.asset(value.icon)),
          Text(
            value.name,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
                softWrap:false,
          ),
        ]));

    return InkWell(
      onTap: () {
        navigate(context, value);
      },
      child: Center(child: ui),
    );
  }
}
