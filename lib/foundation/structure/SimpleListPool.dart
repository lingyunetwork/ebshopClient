part of foundation;
/// <summary>
/// 列表池 临时列表
/// </summary>
/// <typeparam name="T"></typeparam>
class SimpleListPool {
  static List<List> _sPools = new List<List>();
  static List get() {
    if (_sPools.length > 0) {
      return _sPools.removeLast();
    }
    return new List();
  }

  static release(List value) {
    if (_sPools.length < 100) {
      value.clear();
      _sPools.add(value);
    }
  }
}
