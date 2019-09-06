part of foundation;

typedef void CallBack();
typedef void ActionT<T>(T o);
typedef void Action2T<T,V>(T o,V v);

typedef R Handle<T, R>(T o);

enum NodeActiveState {
  ///正在运行;
  Runing,

  /// 将加入;
  ToDoAdd,

  /// 将删除;
  ToDoDelete
}

abstract class IEventDispatcher {
 bool on(String type, ActionT<EventX> listener, [num priority=0]);
    bool has(String type);
    bool off(String type, ActionT<EventX> listener);
    bool dispatch(EventX e);
}

abstract class IDisposable {}
