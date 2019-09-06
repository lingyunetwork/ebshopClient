import 'package:ebshop/foundation/foundation.dart';
import 'package:ebshop/main.dart';
import 'package:ebshop/pages/utils/Core.dart';
import 'package:ebshop/pages/widgets/FormModelUI.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> with EStage {
  FormModel formModel;

  @override
  void initState() {
    formModel = FormModel();
    formModel.addByName("name");
    formModel.addByName("password");

    super.initState();
  }

  void onSubmitted() async {
    if (formModel.validate() == false) {
      Toast.show("字段不合法", context);
      return;
    }

    var res = await RECT.post(
        "user", {"u": formModel.get("name"), "p": formModel.get("password")});

    if (res.success) {
      Core.login(res.data);

      var uri = '/MainPage';
      goURI(uri);
    } else {
      toast(res.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              FormModelUI(
                model: formModel,
              ),
              sendButton(),
            ],
          ),
        ),
      ),
    );
  }

  sendButton() {
    Widget ui = Container(
      width: 328,
      height: 52,
      margin: EdgeInsets.only(top: 20),
      child: Util.getButton("登录", onPressed: onSubmitted),
    );

    ui = Center(child: ui);
    return ui;
  }
}
