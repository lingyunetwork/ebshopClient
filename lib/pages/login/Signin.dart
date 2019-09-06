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

class _SigninPageState extends StateEvent<SigninPage> {
  FormModel formModel;

  @override
  void initState() {
    formModel = FormModel();
    var u=formModel.addByName("name");
    u.minlen=3;
    formModel.onChanged = onChange;

    var p = formModel.addByName("password");
    p.minlen=3;
    p.obscureText = true;

    super.initState();
  }

  void onSubmitted() async {
    if (formModel.validate(this) == false) {
      Toast.show("字段不合法", context);
      return;
    }

    var res = await RECT.post(
        "user", {"u": formModel.get("name"), "p": formModel.get("password")});

    if (res.success) {
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
      child: Util.getButton("登录", onPressed: formModel.hasEmpty?null:onSubmitted),
    );

    ui = Center(child: ui);
    return ui;
  }

  void onChange(FormItemVO o) {
    invalidate();
  }
}
