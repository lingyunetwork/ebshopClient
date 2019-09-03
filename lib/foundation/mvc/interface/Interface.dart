part of foundation;
enum InjectEventType {
  Show,
  //always regist facadeDispatchEvent
  Always,
  //proxy event
  Proxy,
}

class InjectEventTypeHandle {
  InjectEventType injectType;
  List<String> events;
  ActionT<EventX> handle;
  InjectEventTypeHandle(this.injectType, this.events, this.handle);
}

abstract class IEventInterester {
  /// @property index:InjectEventType;
  Dictionary<String, List<InjectEventTypeHandle>> get $eventInteresting;
  List<InjectEventTypeHandle> getEventInterests(InjectEventType type);
}

abstract class IView {
  IMVCHost get(String name);
  bool register(IMVCHost host);
  bool remove(IMVCHost host);
}

abstract class IMVCHost extends IAsync with IEventInterester, IInjectable {
  String name;
  onRegister();
  onRemove();
}

abstract class IAsync {
  bool _isReady;

  set $isReady(bool v){
    _isReady=v;
  }
  get isReady=>_isReady;

  bool startSync();
  bool addReayHandle(ActionT<EventX> handle);
}

abstract class INotifier {
  bool simpleDispatch(String type, [data]);
}

abstract class ICommand {
  execute(EventX e);
}

abstract class IInject {
  IInjectable inject(IInjectable target);
}

///是否可注入
abstract class IInjectable {
  bool get $injectable;
}
