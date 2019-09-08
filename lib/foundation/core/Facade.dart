part of foundation;

class Facade{
  static EventDispatcher dispatcher=EventDispatcher();
  static dispatch(String eventType,[dynamic data]){
      dispatcher.simpleDispatch(eventType,data);
  }
  static on(String eventType,ActionT<EventX> listener){
      dispatcher.on(eventType,listener);
  }
  static off(String eventType,ActionT<EventX> listener){
      return dispatcher.off(eventType,listener);
  }

  static offs(String eventType){
      return dispatcher.removeEventListeners(eventType);
  }

}