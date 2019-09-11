part of app;

class Util {
  static Widget getMore(String value) {
    return Row(children: <Widget>[
      TextU.getDef(value, Colors.grey),
      Icon(Icons.keyboard_arrow_right)
    ]);
  }

  static Widget getButton(String title, {Function onPressed}) {
    return FlatButton(
      onPressed: onPressed,
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      textColor: Colors.white,
      padding: EdgeInsets.all(0),
      disabledColor: Colors.redAccent[100],
      disabledTextColor: Colors.white70,
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget getTitleBar(String value,
      [Color color = Colors.grey, IconData icon = Icons.dashboard]) {
    return Row(children: <Widget>[
      Icon(icon),
      SizedBox(
        width: 4,
      ),
      TextU.getDef(value, color),
    ]);
  }

  static Tab getMinTab(String value) {
    var ui = Tab(
      text: value,
    );
    return ui;
  }
}

class TextU {
  static Text getH1(String value, [Color color = Colors.black]) {
    return Text(
      value,
      style: TextStyle(fontSize: 30, color: color, fontWeight: FontWeight.bold),
    );
  }

  static Text getH2(String value, [Color color = Colors.black]) {
    return Text(
      value,
      style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w600),
      textAlign: TextAlign.left,
    );
  }

  static Text getH3(String value, [Color color = Colors.black]) {
    return Text(
      value,
      style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w500),
      textAlign: TextAlign.left,
    );
  }

  static Text getDef(String value, [Color color = Colors.black]) {
    return Text(
      value,
      style:
          TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.normal),
      textAlign: TextAlign.left,
    );
  }
}

class AppStyle {
  AppStyle._();
  static Widget defaultGap = SizedBox(width: Ux.px(10));
  static EdgeInsetsGeometry defaultPadding = EdgeInsets.all(10);
  static EdgeInsetsGeometry mainPaddingLR =
      EdgeInsets.only(left: 15, right: 15);
}

class ColorU {
  static Color unselectedColor = Colors.grey;
}
