import 'package:ebshop/foundation/foundation.dart';
import 'package:flutter/material.dart';

class FormModelUI extends StatefulWidget {
  final FormModel model;

  FormModelUI({Key key, this.model}) : super(key: key);

  _FromState createState() => _FromState();
}

class _FromState extends State<FormModelUI> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.model._formKey,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.model._list.length,
        itemBuilder: itemBuild,
      ),
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    //ThemeData themeData = Theme.of(context);

    FormItemVO vo = widget.model._list[index];
    var decoration = vo.decoration;
    if (decoration == null) {
      decoration = new InputDecoration(
        labelText: vo.desc ?? vo.name,
        filled: true,
        fillColor: Colors.white,
        hintText: vo.desc ?? vo.name,

        contentPadding: EdgeInsets.fromLTRB(30, 10, 10, 10),

        // focusedBorder: OutlineInputBorder(
        //   borderSide: new BorderSide(color: Colors.grey[200]),
        //   borderRadius: new BorderRadius.circular(25),
        // ),
        enabledBorder: UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey[200]),
          borderRadius: new BorderRadius.circular(25),
        ),
      );
    }
    return Container(
        height: 60,
        //color: Colors.red,
        margin: EdgeInsets.only(bottom: 5),
        child: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: TextFormField(
            decoration: decoration,

            validator: (val) {
              if (vo.maxlen > 0) {
                return val.length > vo.maxlen ? "长度至多${vo.maxlen}位" : null;
              }
              if (vo.maxlen > 0) {
                return val.length < vo.minlen ? "长度至少${vo.minlen}位" : null;
              }

              if (vo.validator != null) {
                return vo.validator(val);
              }

              return null;
            },

            obscureText: vo.obscureText,
            onSaved: (val) {
              vo.value = val.trim();
            },
          ),
        ));
  }
}

class FormModel {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final List<FormItemVO> _list = [];

  add(FormItemVO value) {
    _list.add(value);
  }

  FormItemVO addByName(String name) {
    var value = FormItemVO();
    value.name = name;
    _list.add(value);
    return value;
  }

  Map<String, String> getData() {
    var maps = <String, String>{};
    _list.map((f) {
      maps[f.name] = f.value;
      return f.value;
    });
    return maps;
  }

  bool validate() {
    var _form = _formKey.currentState;
    var b = _form.validate();
    if (b) {
      _form.save();
    }
    return b;
  }

  void print() {}

  get(String name) {
    for (var f in _list) {
      if (f.name == name) {
        return f.value;
      }
    }

    return "";
  }
}

class FormItemVO {
  String name;
  String desc;
  int maxlen = -1;
  int minlen = -1;

  Handle<String, String> validator;
  InputDecoration decoration;
  String value;

  bool obscureText=false;
}
