part of clayui;

class IListItemRender<T> extends IUIView {
  PageList $pageList;
  T data;
  int index = 0;

  bool get isSelected {
    return $pageList._selectedIndex == index;
  }

  @override
  Widget _doGetView() {
    return InkWell(
      onTap: () {
        this.eventHandle(EventX.CLICK, index);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(data.toString(),
            style: TextStyle(color: isSelected ? Colors.pink : Colors.black)),
      ),
    );
    
  }
}

class PageList extends EventDispatcher with IUIView {
  static const List<dynamic> EMPTY = [];
  List<dynamic> _dataProvider;

  int _selectedIndex = -1;

  Func<IListItemRender> createItemRender;

  set dataProvider(List<dynamic> value) {
    _dataProvider = value;
  }

  _onEventHandle(String type, dynamic o) {
    _selectedIndex = o as int;

    triggerState();
  }
  Axis scrollDirection=Axis.vertical;

  PageList([this.scrollDirection=Axis.vertical]);

  @override
  void _init() {
    if (_dataProvider == null) {
      _dataProvider = EMPTY;
    }
    super._init();
  }

  @override
  Widget _doGetView() {
    return Container(
        height: 40,
        color: Colors.white,
        child: $getListView());
  }

  Widget $itemBuilder(BuildContext context, int i) {
    var item = createItemRender();
    item.$pageList = this;
    item.index = i;
    item.$pageList = this;
    item.eventHandle = _onEventHandle;
    item.data = _dataProvider[i];

    return item.getView();
  }

  ListView $getListView() {
    return ListView.builder(
        scrollDirection: scrollDirection,
        itemCount: _dataProvider.length,
        itemBuilder: $itemBuilder);
  }
}
