part of app;

///个人页面
class Personal extends StatefulWidget {
  Personal({Key key}) : super(key: key);

  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends StateEvent<Personal> {
  @override
  Widget build(BuildContext context) {
    var list = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        banner(),
        _orderTitle(),
        _orderType(),
        _actionList(),
        Center(child: Util.getButton("退出登录", onPressed: loginOut)),
      ],
    );
    return Scaffold(
      body: list,
    );
  }

  loginOut() {
    Core.logout();

    pushReplacementNamed("/LoginPage");
  }

  banner() {
    return Container(
      width: Ux.px(750),
      padding: EdgeInsets.all(20),
      color: Color.fromRGBO(228, 49, 48, 1.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: ClipOval(
              child: Image.network(
                  'http://storage.360buyimg.com/i.imageUpload/6a645f3433313063386533363933346231343733363531343134323131_mid.jpg'),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'crl',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  // 我的订单
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType() {
    return Container(
      width: Ux.px(750),
      height: Ux.px(80),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.query_builder,
                    size: 30,
                  ),
                  Text('代付款')
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.queue_music,
                    size: 30,
                  ),
                  Text('代发货')
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.card_giftcard,
                    size: 30,
                  ),
                  Text('待收货')
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.query_builder,
                    size: 30,
                  ),
                  Text('待评价')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 通用调listtile
  Widget _myListTile(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服管理'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }

  section() {
    var ui = Container(
      height: 100,
    );

    return getCart(ui);
  }

  getCart(Widget ui) {
    return Card(
        elevation: 0, //设置阴影
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            side: BorderSide(
              color: Color.fromARGB(20, 0, 0, 0),
              width: 1.0,
            )), //设置圆角
        child: ui);
  }
}
