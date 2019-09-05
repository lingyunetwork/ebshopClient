part of foundation;

///倒计时工具
class Countdowner {
  Timer _timer;
  int _seconds;
  bool _isRunnig=false;

  bool get isRunnig=>_isRunnig;

  ActionT<int> _handle;
  void start(int value,ActionT<int> handle) {
    _seconds = value;

    stop();
    _isRunnig=true;
    _handle=handle;
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  _tick(Timer timer) {

    if (_seconds == 0) {
      stop();
      return;
    }
    _seconds--;

    _handle(_seconds);    
  }



  /// 取消倒计时的计时器。
  void stop() {
    _isRunnig=false;
    _timer?.cancel();
  }
}