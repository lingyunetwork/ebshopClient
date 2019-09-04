part of app;

class SwiperDiy extends StatefulWidget {
  final List<MenuVO> dataProvider;
  const SwiperDiy(this.dataProvider,{Key key}) : super(key: key);

  @override
  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<SwiperDiy> with EStage{
  @override
  Widget build(BuildContext context) {
    Widget ui;
    ui = Swiper(
      itemBuilder: _itemBuilder,
      itemCount: widget.dataProvider.length,
      pagination: new SwiperPagination(),
      scale: 1.0,
      autoplay: true,
    );

    return Container(        
        color: Colors.grey, width:Ux.px(375), height:Ux.px(200), child: ui);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var vo=widget.dataProvider[index];
    String url = vo.icon;

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
      onTap: () {
        navigate(context, vo);
      },
      child: ui,
    );
  }
}
