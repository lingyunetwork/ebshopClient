part of app;

class SwiperDiy extends StatefulWidget {
  final List data;
  const SwiperDiy({Key key, this.data}) : super(key: key);

  @override
  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<SwiperDiy> {
  @override
  Widget build(BuildContext context) {
    Widget ui;
    ui = Swiper(
      itemBuilder: _itemBuilder,
      itemCount: widget.data.length,
      pagination: new SwiperPagination(),
      scale: 1.0,
      autoplay: true,
    );

    return Container(        
        color: Colors.grey, width:Ux.px(375), height:Ux.px(200), child: ui);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    String url = widget.data[index]['image'];

    var rng = new Random();
    var r = rng.nextInt(5);
    url = 'https://picsum.photos/250?image=$r';

    Widget ui;
    if (url.indexOf("assets") == 0) {
      ui = Image.asset(url);
    } else {
      ui = CachedNetworkImage(
        placeholder: (context, url) => Center(child:CircularProgressIndicator()),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        imageUrl: url,
        fit: BoxFit.fitWidth
      );
    }
    return InkWell(
      onTap: () {},
      child: ui,
    );
  }
}
