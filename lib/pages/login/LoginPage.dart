part of app;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateEvent<LoginPage> {
  var _controller = new TextEditingController();
  var _codeController = new TextEditingController();

  onWeixin() {}
  onQQ() {}
  onAccount() {
    goURI("/SigninPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(onPressed: onjump, child: doNext()),
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  welcome(),
                  inputPhone(),
                  sendButton(),
                  otherTitle(),
                  other()
                ])));
  }

  onjump() {}

  onSubmitted(String str) {
    _controller.text = "";
    this.invalidate();
  }

  doNext() {
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

  welcome() {
    Widget ui = Text("欢迎来到平台\n请您登陆/注册", style: TextStyle(fontSize: 35));
    ui = Container(
      child: ui,
      margin: EdgeInsets.only(top: 60),
    );
    return ui;
  }

  inputPhone() {
    Widget ui =
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
        width: 60,
        child: Row(
          children: <Widget>[
            Text(
              "+86",
              maxLines: 1,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      Expanded(
        child: Util.getInput("电话号码", _controller, onSubmitted, this),
      )
    ]);

    var phone = Container(
      height: 30,
      child: ui,
      margin: EdgeInsets.only(top: 30),
    );

    return phone;

    // return Column(
    //   children: <Widget>[phone, phoneCode()],
    // );
  }

  phoneCode() {
    Widget ui =
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      SizedBox(width: 60),
      Expanded(
          child: TextFormField(
              inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(8),
            WhitelistingTextInputFormatter.digitsOnly,
            BlacklistingTextInputFormatter.singleLineFormatter,
          ],
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "验证码",
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _codeController.clear();
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
              onFieldSubmitted: onSubmitted,
              onChanged: (v) => this.invalidate()))
    ]);

    ui = Container(
      height: 30,
      child: ui,
      margin: EdgeInsets.only(top: 30, bottom: 30),
    );

    return ui;
  }

  sendButton() {
    var onPress = null;

    var text = _controller.text;
    if (ValidateUtil.isPoneAvailable(text)) {
      onPress = () {
        onSubmitted(text);
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

  otherTitle() {
    var ui = Container(
        margin: EdgeInsets.only(top: 120),
        child: Text("其它登录方式",
            style: TextStyle(color: Colors.redAccent, fontSize: 16)));
    return ui;
  }

  other() {
    Widget ui = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _icon(Icons.widgets, "微信", onWeixin),
        _icon(Icons.dashboard, "QQ", onQQ),
        _icon(Icons.account_circle, "账号", onAccount)
      ],
    );

    ui = Container(margin: EdgeInsets.only(top: 20), child: ui);
    return ui;
  }

  _icon(IconData icon, String t, Function onTap) {
    Widget ui =
        Column(children: <Widget>[Expanded(child: Icon(icon)), Text(t)]);

    ui = Container(child: ui, width: 60, height: 69);

    return InkWell(
      child: ui,
      onTap: onTap,
    );
  }
}
