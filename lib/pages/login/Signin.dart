part of app;

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends StateEvent<SigninPage> {
  FormModel formModel;

  @override
  void initState() {
    formModel = FormModel();
    var u = formModel.addByName("name");
    u.minlen = 3;
    formModel.onChanged = onChange;

    var p = formModel.addByName("password");
    p.minlen = 3;
    p.obscureText = true;

    isStage = true;
    super.initState();
  }

  void onSubmitted() async {
    if (formModel.validate(this) == false) {
      toast("字段不合法");
      return;
    }

    var res = await RECT.post(
        "user", {"u": formModel.get("name"), "p": formModel.get("password")});

    var test=true;
    if (res.success || test) {
      Core.login(res.data);
      formModel.reset();

      var uri = '/MainPage';
      goURI(uri);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
      ),
      body: Builder(
          // Create an inner BuildContext so that the snackBar onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          builder: buildBody),
    );
  }

  sendButton() {
    Widget ui = Container(
      width: 328,
      height: 52,
      margin: EdgeInsets.only(top: 20),
      child: Util.getButton("登录",
          onPressed: formModel.hasEmpty ? null : onSubmitted),
    );

    ui = Center(child: ui);
    return ui;
  }

  void onChange(FormItemVO o) {
    invalidate();
  }

  Widget buildBody(BuildContext context) {
    this.innerContext = context;
    Widget ui = Column(
      children: <Widget>[
        FormModelUI(
          model: formModel,
        ),
        sendButton(),
      ],
    );

    ui = Padding(
      padding: const EdgeInsets.all(10.0),
      child: ui,
    );
    ;
    ui = SafeArea(
      child: ui,
    );
    return ui;
  }
}
