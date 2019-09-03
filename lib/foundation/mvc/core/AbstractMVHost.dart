part of foundation;
abstract class AbstractMVHost extends EventDispatcher
    with IMVCHost, IEventInterester, IAsync, IEventDispatcher {
  Dictionary<String, List<InjectEventTypeHandle>> __eventInteresting;
  bool injectable = true;

  String _name;
  String get name => _name;

  IFacade facade = Facade.getInstance();
  List<ActionT<EventX>> readyHandle;

  bool startSync() {
    if (this.isReady == false) {
      this.load();
    }
    return true;
  }

  load();

  bool addReayHandle(ActionT<EventX> handle) {
    if (this.isReady) {
      handle(EventX.readyEventX);
      return true;
    }

    if (this.readyHandle != null) {
      this.readyHandle = new List<ActionT<EventX>>();
    } else {
      for (var item in this.readyHandle) {
        if (item == handle) {
          return false;
        }
      }
    }
    this.readyHandle.add(handle);
    return true;
  }

  bool removeReayHandle(ActionT<EventX> handle) {
    if (this.isReady) {
      return false;
    }

    if (this.readyHandle != null) {
      int len = this.readyHandle.length;
      for (int i = 0; i < len; i++) {
        var item = this.readyHandle[i];
        if (item == handle) {
          this.readyHandle.removeAt(i);
        }
        return true;
      }
    }

    return false;
  }

  dispatchReayHandle() {
    this.facade.registerEventInterester(this, InjectEventType.Always, true);

    if (this.readyHandle != null) {
      this.readyHandle.forEach((val) => val(EventX.readyEventX));
      this.readyHandle.clear();
      this.readyHandle = null;
    }
    this.dispatchEvent(EventX.readyEventX);
  }

  List<InjectEventTypeHandle> getEventInterests(InjectEventType type) {
    if (this.__eventInteresting != null) {
      return null;
    }
    return this.__eventInteresting.get(type.toString());
  }

  onRegister() {}
  onRemove() {
    this.facade.registerEventInterester(this, InjectEventType.Always, false);
  }
}
