part of app;

class LoginCode extends StatefulWidget {
  
  /// 倒计时的秒数，默认60秒。
  final int countdown;

  /// 用户点击时的回调函数。
  Func onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  final bool available;

  LoginCode({
    this.countdown=60,
    this.onTapCallback,
    this.available: false,
  });

  @override
  _LoginCodeState createState() => _LoginCodeState();
}

class _LoginCodeState extends State<LoginCode> with EStage {
  /// 墨水瓶（`InkWell`）可用时使用的字体样式。
  static final TextStyle _availableStyle = TextStyle(
    fontSize: 16.0,
    color: const Color(0xFF00CACE),
  );

  /// 墨水瓶（`InkWell`）不可用时使用的样式。
  static final TextStyle _unavailableStyle = TextStyle(
    fontSize: 16.0,
    color: const Color(0xFFCCCCCC),
  );

  /// 倒计时的计时器。
  Countdowner _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _timer = Countdowner();
  }

  void tick(int value) {
    if (value == 0) {
      inkWellStyle = _availableStyle;
      _verifyStr = '重新发送';
    } else {
      _verifyStr = '已发送$_seconds' + 's';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 墨水瓶（`InkWell`）组件，响应触摸的矩形区域。
    return widget.available
        ? InkWell(
            child: Text(
              '  $_verifyStr  ',
              style: inkWellStyle,
            ),
            onTap: (_seconds == widget.countdown)
                ? () {
                    _timer.start(widget.countdown, tick);
                    inkWellStyle = _unavailableStyle;
                    _verifyStr = '已发送$_seconds' + 's';
                    setState(() {});
                    widget.onTapCallback();
                  }
                : null,
          )
        : InkWell(
            child: Text(
              '  获取验证码  ',
              style: _unavailableStyle,
            ),
          );
  }
}
