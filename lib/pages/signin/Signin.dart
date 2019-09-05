import 'package:dio/dio.dart';
import 'package:ebshop/foundation/foundation.dart';
import 'package:ebshop/pages/utils/Core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> with EStage {
  var _controller = new TextEditingController();
  var _passController = new TextEditingController();
  void onSubmitted() async{
    var userName = _controller.text;
    var password = _passController.text;
    if (userName.length == 0 || password.length == 0) {
      Toast.show("Toast plugin app", context);
      return;
    }

    
    var res=await RECT.post("login", {"u":userName,"p":password});

    if(res.success){
       var uri = '/LoginPage';
       Navigator.of(context).pushReplacementNamed(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            getCoumn("用户名:"),
            getCoumn("密码:", true),
            sendButton(),
          ],
        ),
      ),
    );
  }

  sendButton() {
    var onPress = null;

    var useName = _controller.text;
    var password = _passController.text;
    if (useName.length > 0 && password.length > 0) {
      onPress = () {
        onSubmitted();
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
          "登录",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );

    ui = Center(child: ui);
    return ui;
  }

  getCoumn(String s, [bool ispass = false]) {
    return Container(
      height: 30,
      margin: EdgeInsets.all(20),
      //padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(s),
            width: 60,
          ),
          Expanded(child: getFormField("", ispass)),
        ],
      ),
    );
  }

  Widget getFormField([String hintText = "", bool ispass = false]) {
    var c = ispass ? _passController : _controller;

    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(11),
        //WhitelistingTextInputFormatter.digitsOnly,
        BlacklistingTextInputFormatter.singleLineFormatter,
      ],
      controller: c,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          //hintText: hintText,
        // contentPadding: EdgeInsets.only(
          //   left: 10,
          // ),
          //border: InputBorder.none,
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                c.clear();
                this.invalidate();
              })),
      style: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      obscureText: ispass,
      //maxLength: 11,
      maxLengthEnforced: true,
      autocorrect: false,
      autofocus: ispass==false,
      onChanged: (v) => this.invalidate(),
    );
  }
}
