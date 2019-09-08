part of foundation;

abstract class StateEvent<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();

    Core.on(EventX.ERROR, _onError);
    Core.on(EventX.UNLOGIN, _onUnLogin);
  }

  dispose() {
    Core.off(EventX.ERROR, _onError);
    Core.off(EventX.UNLOGIN, _onUnLogin);
    super.dispose();
  }

  invalidate() {
    this.setState(_empty);
  }

  //不做任何事
  _empty() {}

  toast(String value) {
    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('$value'),
                      ));
  }

  goURI(String uri) {
    Navigator.of(context).pushReplacementNamed(uri);
  }

  navigate(BuildContext context, MenuVO value) async {
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
