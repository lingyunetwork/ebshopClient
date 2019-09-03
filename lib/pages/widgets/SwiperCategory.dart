part of app;

class SwiperCategory extends StatelessWidget {
  final List data;
  const SwiperCategory({Key key, this.data}) : super(key: key);

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
    List navigatorList = data[index];
    List<Widget> c = navigatorList.map(
      (item) {
        return _getItem(context, item);
      },
    ).toList();

    return GridView.count(
      padding: EdgeInsets.only(top:10),
      mainAxisSpacing: 0,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      children: c,
    );
  }

  Widget _getItem(BuildContext context, Map data) {
    //var url = data['image'];
    //var title=data["title"];
    //var icon=Image.network(url,fit: BoxFit.fill,);

    var ui = Container(
      height: 62,
      //color: Colors.red,
        child: Column(children: <Widget>[
          Expanded(child:Icon(Feather.message_square)),
          TextU.getDef(
            "消 息",
          )
        ]));

    return InkWell(
      onTap: () {},
      child: Center(child: ui),
    );
  }
}
