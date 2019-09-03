part of foundation;

class ActionNode<T> {
  ActionNode<T> next;
  ActionNode<T> pre;
  Action action;
  dynamic thisObj;
  T data;

  /// <summary>
  /// 0:将删除;
  /// 1:正在运行
  /// 2:将加入;
  /// </summary>
  NodeActiveState $active = NodeActiveState.Runing;
  num priority = 0;
}
