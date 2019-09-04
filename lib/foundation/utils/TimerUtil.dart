part of foundation;

///倒计时工具
class Countdowner {
  Timer _timer;
  int _seconds;

  ActionT<int> _handle;
  void start(int value,ActionT<int> handle) {
    _seconds = value;

    _cancelTimer();
    _handle=handle;
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  _tick(Timer timer) {
    _seconds--;

    _handle(_seconds);

    if (_seconds <= 0) {
      _cancelTimer();
    }
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
  }
}