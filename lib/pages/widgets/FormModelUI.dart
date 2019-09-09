part of app;
class FormModelUI extends StatefulWidget {
  final FormModel model;
  final Axis scrollDirection;
  FormModelUI({
    Key key,
    this.model,
    this.scrollDirection: Axis.vertical,
  }) : super(key: key);

  _FromState createState() => _FromState();
}

class _FromState extends StateEvent<FormModelUI> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.model._formKey,
      child: ListView.builder(
        scrollDirection: widget.scrollDirection,
        shrinkWrap: true,
        itemCount: widget.model._list.length,
        itemBuilder: itemBuild,
      ),
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    FormItemVO vo = widget.model._list[index];

    FocusNode next;
    if (index < widget.model._list.length - 1) {
      var nexVO = widget.model._list[index + 1];
      if (nexVO != null) {
        next = nexVO._focus;
      }
    }
    return Container(
        height: vo.hasError ? 80 : 60,
        //color: Colors.red,
        margin: EdgeInsets.only(bottom: 5),
        child: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: vo.getView(this, next),
        ));
  }
}

class FormModel {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final List<FormItemVO> _list = [];
  final Map<String, FormItemVO> _map = {};

  ActionT<FormItemVO> onChanged;

  bool get hasEmpty {
    for (var f in _list) {
      if (f.value.length == 0) {
        return true;
      }
    }
    return false;
  }

  add(FormItemVO value) {
    value._formModel = this;
    _list.add(value);
    _map[value.name] = value;
  }

  FormItemVO addByName(String name) {
    var value = FormItemVO(name);
    add(value);
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

  bool validate(StateEvent state) {
    var _form = _formKey.currentState;
    var b = _form.validate();
    if (b) {
      _form.save();
    } else {
      state.invalidate();
    }
    return b;
  }

  String debug() {
    var s = "";
    for (var f in _list) {
      s += "${f.name}:${f.value} \n";
    }
    print(s);
    return s;
  }

  get(String name) {
    var f = _map[name];
    return f != null ? f.value : null;
  }

  void reset() {
    var _form = _formKey.currentState;
    _form.reset();
  }
}

class FormItemVO {
  final String name;
  String desc;
  int maxlen = -1;
  int minlen = -1;
  bool _hasError = false;

  Widget icon;
  TextInputType keyboardType;

  bool get hasError => _hasError;

  TextEditingController controller;
  final FocusNode _focus = FocusNode();
  FormItemVO(this.name) {}

  FormModel _formModel;
  FormModel get formModel => _formModel;

  Handle<String, String> validator;
  InputDecoration decoration;
  String value = "";

  ActionT<FormItemVO> onChanged;
  bool obscureText = false;

  getView(StateEvent state, [FocusNode nextFocus]) {
    if (controller == null) {
      controller = TextEditingController();
    }

    //if (decoration == null) {
    decoration = new InputDecoration(
      labelText: desc ?? name,
      filled: true,
      fillColor: Colors.white,
      hintText: desc ?? name,

      contentPadding: EdgeInsets.fromLTRB(30, 10, 10, 10),

      // focusedBorder: OutlineInputBorder(
      //   borderSide: new BorderSide(color: Colors.grey[200]),
      //   borderRadius: new BorderRadius.circular(25),
      // ),
      enabledBorder: UnderlineInputBorder(
        borderSide: new BorderSide(color: Colors.grey[200]),
        borderRadius: new BorderRadius.circular(25),
      ),

      icon: icon,

      suffixIcon: controller.text.length > 0
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                state.invalidate();
              })
          : null,
    );
    //}

    return TextFormField(
      controller: controller,
      focusNode: _focus,
      decoration: decoration,
      autovalidate: hasError,
      keyboardType: keyboardType,
      validator: (val) {
        val=val.trim();
        if (maxlen > 0) {
          _hasError = val.length > maxlen;
          return _hasError ? "长度至多${maxlen}位" : null;
        }
        if (minlen > 0) {
          _hasError = val.length < minlen;
          return _hasError ? "长度至少${minlen}位" : null;
        }

        if (validator != null) {
          var b = validator(val);
          _hasError = b != null;
          return b;
        }
        _hasError = false;
        return null;
      },
      onFieldSubmitted: (val) {
        val=val.trim();
        if (val.length > 0) {
          //_fieldFocusChange(state.context, _focus, nextFocus);
        }
      },
      onChanged: (v) {
        value = v.trim();
        if (onChanged != null) {
          onChanged(this);
        }
        if (_formModel != null && _formModel.onChanged != null) {
          _formModel.onChanged(this);
        }
      },
      obscureText: obscureText,
      onSaved: (val) {
        value = val.trim();
      },
    );
  }

  // _fieldFocusChange(
  //     BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  //   if (FocusScope.of(context).focusedChild != currentFocus) {
  //     return;
  //   }

  //   currentFocus.unfocus();

  //   if (nextFocus == null) {
  //     return;
  //   }
  //   FocusScope.of(context).requestFocus(nextFocus);
  // }
}
