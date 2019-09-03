part of app;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with EStage {
  var _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(onPressed: onjump, child: a()),
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[b(), inputPhone(), d(), e(), f()])));
  }

  onjump() {}

  onSubmitted(String str) {
    _controller.text = "";
    this.invalidate();
  }

  a() {
    Widget ui = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("跳过，看好货",
            style: TextStyle(
              color: Colors.grey,
            )),
        Icon(Icons.keyboard_arrow_right)
      ],
    );
    return ui;
  }

  b() {
    Widget ui = Text("欢迎来到平台\n请您登陆/注册", style: TextStyle(fontSize: 35));
    ui = Container(
      child: ui,
      margin: EdgeInsets.only(top: 60),
    );
    return ui;
  }

  inputPhone() {
    Widget ui =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          child: Text(
        "+86",
        maxLines: 1,
      )),
      Icon(Icons.keyboard_arrow_down),
      Expanded(
          child: TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "电话号码",
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _controller.clear();
                      })),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              //maxLength: 11,
              maxLengthEnforced: true,
              autocorrect: false,
              autofocus: true,
              onSubmitted: onSubmitted,
              onChanged: (v) => this.invalidate()))
    ]);

    ui = Container(
      child: ui,
      margin: EdgeInsets.only(top: 30),
    );
    return ui;
  }

  d() {
    var onPress = null;
    if (this._controller.text.length > 0) {
      onPress = () {
        onSubmitted(this._controller.text);
      };
    }
    Widget ui = Container(
      width: 328,
      height: 52,
      margin: EdgeInsets.only(top: 20),
      child: FlatButton(
        onPressed: onPress,
        color: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        textColor: Colors.white,
        padding: EdgeInsets.all(0),
        disabledColor: Colors.redAccent[100],
        disabledTextColor: Colors.white70,
        child: Text(
          "发送验证码",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );

    ui = Center(child: ui);
    return ui;
  }

  e() {
    var ui = Container(
        margin: EdgeInsets.only(top: 120),
        child: Text("其它登陆方式",
            style: TextStyle(
                color: Color.fromARGB(255, 148, 148, 148), fontSize: 16)));
    return ui;
  }

  f() {
    Widget ui = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _icon(Icons.widgets, "微信"),
          _icon(Icons.dashboard, "QQ"),
          _icon(Icons.account_circle, "账号")
        ]);

    ui = Container(margin: EdgeInsets.only(top: 20), child: ui);
    return ui;
  }

  _icon(IconData icon, String t) {
    Widget ui =
        Column(children: <Widget>[Expanded(child: Icon(icon)), Text(t)]);

    ui = Container(child: ui, width: 60, height: 69);

    return ui;
  }
}
