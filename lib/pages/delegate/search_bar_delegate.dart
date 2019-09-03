part of app;

class SearchBarDelegate extends SearchDelegate<String> {
  /// 这个方法返回一个控件列表，显示为搜索框右边的图标按钮，这里设置为一个清除按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Offstage(
          offstage: query == "" || query == null,
          child:
              IconButton(icon: Icon(Icons.clear), onPressed: () => query = ""))
    ];
  }

  /// 这个方法返回一个控件，显示为搜索框左侧的按钮，一般设置为返回，这里返回一个具有动态效果的返回按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  /// 这个方法返回一个控件，显示为搜索内容区域的搜索结果内容
  @override
  Widget buildResults(BuildContext context) {
    return Text("re");//SearchPage(query: query);
  }

  /// 这个方法返回一个控件，显示为搜索内容区域的建议内容
  @override
  Widget buildSuggestions(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('大家都在搜'),
                  AppStyle.defaultGap,
                  Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: QDailyKeys.map((key) => InputChip(
                          label: Text('$key'),
                          onPressed: () => query = key)).toList())
                ])));
  }

  /// 这个方法返回一个主题，也就是可以自定义搜索界面的主题样式
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
}

const List<String> QDailyKeys = <String>[
  "好莱坞",
  "亚马逊",
  "阿里巴巴",
  "音乐节",
  "特斯拉",
  "腾讯",
  "苹果",
  "海淘",
  "百度",
  "Google",
  "小米",
  "时尚",
  "迪士尼",
  "万达",
  "星巴克",
  "人工智能",
  "无人机",
  "华为",
  "MUJI",
  "宜家"
];
