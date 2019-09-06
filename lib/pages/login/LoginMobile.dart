part of app;

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({Key key}) : super(key: key);

  @override
  createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends StateEvent<LoginMobilePage>{
  var _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text("没收到验证码？",
                  style: TextStyle(
                      //color: Colors.grey,
                      )),
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[b(), b1(), c(), d()])));
  }

  b() {
    Widget ui = Text("请输入验证码",
        style: TextStyle(
          fontSize: 35,
        ));
    ui = Container(
      child: ui,
      margin: EdgeInsets.only(top: 60),
    );
    return ui;
  }

  b1() {
    Widget ui = Text("我们已向189****0201发送验证码,请在下方输入",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ));
    ui = Container(child: ui);
    return ui;
  }

  c() {
    Widget ui = TextField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: "输入验证码",
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
        autocorrect: false,
        onSubmitted: onSubmitted,
        onChanged: (v) => this.invalidate());
    ui = Container(
      child: ui,
      margin: EdgeInsets.only(top: 30),
    );
    return ui;
  }

  onSubmitted(String str) {
    _controller.text = "";
    this.invalidate();
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
        disabledColor: Colors.redAccent[100],
        disabledTextColor: Colors.white70,
        padding: EdgeInsets.all(0),
        child: Text(
          "登录",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );

    ui = Center(child: ui);
    return ui;
  }
}
