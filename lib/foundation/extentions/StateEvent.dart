part of foundation;

abstract class StateEvent<T extends StatefulWidget> extends State<T> {
  @protected
  BuildContext innerContext;
  @protected
  bool isStage = false;

  @override
  void initState() {
    super.initState();

    if (isStage) {
      Facade.on(EventX.ERROR, _onError);
      Facade.on(EventX.UNLOGIN, _onUnLogin);
    }
  }

  dispose() {
    if (isStage) {
      Facade.off(EventX.ERROR, _onError);
      Facade.off(EventX.UNLOGIN, _onUnLogin);
    }
    super.dispose();
  }

  invalidate() {
    this.setState(_empty);
  }

  //不做任何事
  _empty() {}

  toast(String value) {
    var c = innerContext;
    if (c == null) {
      c = context;
    }
    Scaffold.of(c).showSnackBar(SnackBar(
      content: Text('$value'),
    ));
  }

  goURI(String uri) {
    Navigator.of(context).pushReplacementNamed(uri);
  }

  navigate(BuildContext context, dynamic value) async {
    if (value.url != null) {
      launch(value.url);
    }
  }

  void _onError(EventX o) {
    toast(o.data);
  }

  void _onUnLogin(EventX o) {
    goURI("");
  }
}
