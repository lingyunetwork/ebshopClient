part of clayui;

abstract class IUIView {
  bool _inited = false;
  Widget getView() {
    if (_inited == false) {
      _init();
      _inited = true;
    }

    return _doGetView();
  }

  EStage state;

  void triggerState(){
    if(state!=null){
      state.invalidate();
    }
  }

  ActionST<dynamic> eventHandle; 

  void _init(){
    
  }
  Widget _doGetView();
}

class TabItemVO {
  String name;
  IconData icon;

  Widget content;

  TabItemVO(this.name, this.icon, [this.content]);
}

///
class TabNav extends EventDispatcher with IUIView {
  List<TabItemVO> tabs = <TabItemVO>[];

  List<Widget> pages = <Widget>[];
  List<BottomNavigationBarItem> bars = <BottomNavigationBarItem>[];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  add(TabItemVO item) {
    this.tabs.add(item);
  }

  @override
  Widget _doGetView() {
    var v = Scaffold(
      body: _buildPage(),
      bottomNavigationBar: _buildBar(),
    );
    return v;
  }

  _init() {
    for (var item in tabs) {
      if (item.content == null) {
        item.content = Center(child: Text("hello empty"));
      }

      this.pages.add(item.content);

      var bar = _buidBarItem(item);
      this.bars.add(bar);
    }
  }

  _buidBarItem(TabItemVO item) {
    return BottomNavigationBarItem(
        icon: Icon(item.icon),
        activeIcon: Icon(
          item.icon,
          color: Colors.redAccent,
        ),
        title: Text(item.name));
  }

  _buildPage() {
    return IndexedStack(
      index: _selectedIndex,
      children: pages,
    );
  }

  _buildBar() {
    return BottomNavigationBar(
      items: bars,
      onTap: (int index) {
        _selectedIndex = index;
        this.simpleDispatch(EventX.CHANGE, index);
      },
      //图标大小
      iconSize: 24,
      //当前选中的索引
      currentIndex: _selectedIndex,
      //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
      fixedColor: Colors.pinkAccent,
      type: BottomNavigationBarType.fixed,
      selectedFontSize:12
    );
  }
}
