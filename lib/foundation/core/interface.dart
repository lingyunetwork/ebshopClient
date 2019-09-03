part of foundation;

typedef void Action();
typedef void ActionT<T>(T o);
typedef void ActionST<T>(String type,T o);

typedef R Handle<T, R>(T o);
typedef R Func<R>();

typedef ClassT<T> =T Function();
typedef Class = dynamic Function();

enum NodeActiveState {
  ///正在运行;
  Runing,

  /// 将加入;
  ToDoAdd,

  /// 将删除;
  ToDoDelete
}

abstract class IEventDispatcher {
 bool addEventListener(String type, ActionT<EventX> listener, [num priority=0]);
    bool hasEventListener(String type);
    bool removeEventListener(String type, ActionT<EventX> listener);
    bool dispatchEvent(EventX e);
}

abstract class IDisposable {}
