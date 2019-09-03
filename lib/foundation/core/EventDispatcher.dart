part of foundation;

class EventDispatcher with IEventDispatcher, IDisposable {
  Dictionary<String, Signal> mEventListeners;
  IEventDispatcher mTarget;

  ///** Creates an EventDispatcher. */
  EventDispatcher([IEventDispatcher target]) {
    if (target == null) {
      target = this;
    }
    this.mTarget = target;
  }

  bool addEventListener(String type, ActionT<EventX> listener,
      [num priority = 0]) {
    if (listener == null) {
      return false;
    }

    if (this.mEventListeners == null) {
      this.mEventListeners = new Dictionary<String, Signal>();
    }
    var signal = this.mEventListeners.get(type);
    if (signal == null) {
      signal = new Signal();
      this.mEventListeners.add(type, signal);
    }

    return signal.add(listener, priority);
  }

  bool dispatchEvent(EventX e) {
    if (e == null) {
      return false;
    }
    var bubbles = e.bubbles;

    if (!bubbles &&
        (this.mEventListeners == null ||
            this.mEventListeners.containsKey(e.type) == false)) {
      return false;
    }

    var previousTarget = e.target;
    e.$setTarget(this.mTarget);

    bool b = this.$invokeEvent(e);

    if (previousTarget != null) e.$setTarget(previousTarget);

    return b;
  }

  bool $invokeEvent(EventX e) {
    if (this.mEventListeners == null) {
      return false;
    }

    var signal = this.mEventListeners.get(e.type);
    if (signal == null) {
      return false;
    }

    var t = signal.$firstNode;
    if (t == null) {
      return false;
    }

    var temp = SimpleListPool.get();

    int i = 0;
    while (t != null) {
      temp.add(t);
      t = t.next;
      i++;
    }

    e.$setCurrentTarget(this.mTarget);
    //ActionT<EventX> listener;
    for (int j = 0; j < i; j++) {
      t = temp[j];

      t.action(e);

      if (e.stopsImmediatePropagation) {
        return true;
      }
    }
    SimpleListPool.release(temp);
    return e.stopsPropagation;
  }

  bool hasEventListener(String type) {
    if (this.mEventListeners == null) {
      return false;
    }

    var signal = this.mEventListeners.get(type);
    if (signal != null) {
      return signal != null && signal.$firstNode != null;
    }
    return false;
  }

  bool removeEventListener(String type, ActionT<EventX> listener) {
    if (this.mEventListeners != null) {
      var signal = this.mEventListeners.get(type);
      if (signal == null) {
        return false;
      }
      signal.remove(listener);
    }
    return true;
  }

  removeEventListeners([String type]) {
    if (type != null && this.mEventListeners != null) {
      this.mEventListeners.remove(type);
    } else {
      this.mEventListeners = null;
    }
  }

  dispose() {
    this.$clear();
  }

  bool simpleDispatch(String type, [data]) {
    if (this.hasEventListener(type) == false) {
      return false;
    }
    var e = EventX.fromPool(type, data, false);
    var b = this.dispatchEvent(e);
    EventX.toPool(e);
    return b;
  }

  $clear() {
    if (this.mEventListeners == null) {
      return;
    }

    for (var signal in this.mEventListeners.values) {
      signal.$clear();
    }

    this.mEventListeners = null;
  }
}
