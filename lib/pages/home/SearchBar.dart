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
        getNewsIcon(),
        SizedBox(width: 10),
        Expanded(child: _SearchBar()),
        SizedBox(width: 10),
        getAllIcon(),
      ],
    );
  }

  Widget getAllIcon(){
    return Icon(Icons.dashboard,color: Colors.grey,);
  }
  Widget getNewsIcon(){
    return Icon(Icons.message,color: Colors.grey,);
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            child: Row(children: <Widget>[
              Icon(Icons.search,color: Colors.grey),
              SizedBox(width: 10),
              Text('搜索',style:TextStyle(color: Colors.grey)),
              Expanded(child: Container()),
              Icon(Icons.camera,color: Colors.grey),
            ]),
            onTap: () =>
                showSearch(context: context, delegate: SearchBarDelegate())),
        padding: const EdgeInsets.fromLTRB(12,8,20,8),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(50))));
  }
}