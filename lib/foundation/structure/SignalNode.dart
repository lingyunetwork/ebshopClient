part of foundation;

class SignalNode<T> {
  SignalNode<T> next;
  SignalNode<T> pre;
  ActionT<T> action;

  T data;

  /// <summary>
  /// 0:将删除;
  /// 1:正在运行
  /// 2:将加入;
  /// </summary>
  NodeActiveState $active = NodeActiveState.Runing;
  num priority = 0;
}
