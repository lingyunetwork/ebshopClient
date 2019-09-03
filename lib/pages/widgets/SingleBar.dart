part of app;

class SingleBar extends StatelessWidget {
  const SingleBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ui = Row(
      children: <Widget>[
        TextU.getH3("新人专享"),
        RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.remove),
        ),
        Util.getTitleBar("TEST",)
      ],
    );

    

    ui = Row(
      children: <Widget>[Expanded(child: ui), Util.getMore("查看更多")],
    );
    //ui=Expanded(child: ui,);
    return Container(
      height: 40,
      color: Colors.white,
      child: ui,
    );
  }
}
