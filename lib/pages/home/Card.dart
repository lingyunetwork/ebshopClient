part of app;

class CardItem extends StatefulWidget {
  CardItem({Key key}) : super(key: key);

  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    Widget ui;

    var rng = new Random();
    var index = rng.nextInt(100);
    Widget icon = CachedNetworkImage(
      width: Ux.px(375),
      height: Ux.px(200),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
      imageUrl: 'https://picsum.photos/250?image=$index',
      fit: BoxFit.fitWidth,
    );
    icon = Container(
      //color: Colors.red,
      child: icon,
    );

    var title = Text(
      "Flutter布局之Card使用",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      textAlign: TextAlign.left,
    );

    var subTitle = Text(
      "¥49.9",
      style: TextStyle(
          fontSize: 30, color: Colors.redAccent, fontWeight: FontWeight.w500),
      textAlign: TextAlign.left,
    );

    var postTitle = Text(
      "¥100",
      style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.lineThrough),
      textAlign: TextAlign.left,
    );
    var bottomRow1 = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        title,
        Expanded(
          child: Container(),
        ),
        subTitle,
        postTitle
      ],
    );

    var bottomRow2 = Row(
      children: <Widget>[
        Text(
          "¥100",
          style: TextStyle(
              fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );

    var bottom = Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        children: <Widget>[
          bottomRow1,
          SizedBox(
            height: 5,
          ),
          bottomRow2
        ],
      ),
    );

    ui = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[icon, bottom],
    );

    ui = new Card(
        elevation: 0, //设置阴影
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            side: BorderSide(
              color: Color.fromARGB(20, 0, 0, 0),
              width: 1.0,
            )), //设置圆角
        child: ui);

    return ui;
  }
}
