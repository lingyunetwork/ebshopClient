part of foundation;

abstract class StateEvent<T extends StatefulWidget> extends State<T> {
  invalidate() {
    this.setState(_empty);
  }

  //不做任何事
  _empty() {}

  toast(String value) {
    Toast.show(value, context);
  }

  goURI(String uri){
    Navigator.of(context).pushReplacementNamed(uri);
  }

  navigate(BuildContext context, MenuVO value) async {
    if (value.url != null) {
      launch(value.url);
    }
  }
}
