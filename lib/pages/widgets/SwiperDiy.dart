part of app;

class SwiperDiy extends StatelessWidget {
  final List data;
  const SwiperDiy({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ui;
    ui = Swiper(
      itemBuilder: _itemBuilder,
      itemCount: data.length,
      pagination: new SwiperPagination(),
      autoplay: true,
    );

    return Container(color: Colors.grey, height: 200, child: ui);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    String url = data[index]['image'];

    var rng = new Random();
    var r = rng.nextInt(100);
    url = 'https://picsum.photos/250?image=$r';

    Widget ui;
    if (url.indexOf("assets") == 0) {
      ui = Image.asset(url);
    } else {
      ui = CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        
        imageUrl: url,
        fit: BoxFit.fitWidth,
      );
    }
    return InkWell(
      onTap: () {},
      child: ui,
    );
  }
}
