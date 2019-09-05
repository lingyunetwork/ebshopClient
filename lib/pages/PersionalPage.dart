part of app;

///个人页面
class Personal extends StatefulWidget {
  Personal({Key key}) : super(key: key);

  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    var list = Column(
      children: <Widget>[
        banner(),

        section()
      ],
    );
    return SafeArea(
      child: list,
    );
  }

  banner() {
    var url = "";
    var icon = CircleAvatar(
      backgroundImage: NetworkImage(url),
    );

    return Row(
      children: <Widget>[
        icon,
      ],
    );
  }


  section(){

    var ui=Container(
      height: 100,
    );

    return getCart(ui);
  }


    getCart(Widget ui){
    return Card(
        elevation: 0, //设置阴影
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            side: BorderSide(
              color: Color.fromARGB(20, 0, 0, 0),
              width: 1.0,
            )), //设置圆角
        child: ui);
  }
}
