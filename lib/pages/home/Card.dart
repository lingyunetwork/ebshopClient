part of app;

class CardItem extends StatefulWidget {
  CardItem({Key key}) : super(key: key);

  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    //final TextStyle descriptionStyle = theme.textTheme.subhead;

    Widget ui;

    var rng = new Random();
    var index = rng.nextInt(5);
    Widget icon = CachedNetworkImage(
      width: Ux.px(375),
      height: Ux.px(200),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
      imageUrl: 'https://picsum.photos/250?image=$index',
      fit: BoxFit.fitWidth,
    );

    icon = Stack(
      children: <Widget>[
        icon,
        Positioned(
          bottom: 5.0,
          left: 16.0,
          right: 16.0,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              "Flutter布局之Card使用",
              style: titleStyle,
            ),
          ),
        ),
      ],
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
      padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
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

    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0, 2),
              spreadRadius: 0,
              blurRadius: 10)
        ]),
        child: ui);
  }
}
