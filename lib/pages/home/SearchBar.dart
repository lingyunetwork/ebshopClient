part of app;

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _Icon(),
        SizedBox(width: 10),
        Expanded(child: _SearchBar()),
        SizedBox(width: 10),
        _IconCategory(),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            child: Row(children: <Widget>[
              Icon(Feather.search,color: Colors.grey),
              SizedBox(width: 10),
              Text('搜索',style:TextStyle(color: Colors.grey)),
              Expanded(child: Container()),
              Icon(Feather.camera,color: Colors.grey),
            ]),
            onTap: () =>
                showSearch(context: context, delegate: SearchBarDelegate())),
        padding: const EdgeInsets.fromLTRB(12,8,20,8),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(50))));
  }
}

class _Icon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Icon(Feather.message_square),
      Text("消 息",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 8,
            fontFamily: "PingFang SC",
            fontWeight: FontWeight.w600,
          ))
    ]);
  }
}

class _IconCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Icon(Feather.bookmark),
      Text("分 类",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 8,
            fontFamily: "PingFang SC",
            fontWeight: FontWeight.w600,
          ))
    ]);
  }
}
