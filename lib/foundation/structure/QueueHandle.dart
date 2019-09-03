part of foundation;

class QueueHandle<T> {
  static const num MAX = 1000;
  static List<SignalNode<dynamic>> _sNodePool = new List<SignalNode<dynamic>>();

  static List<List<SignalNode<dynamic>>> _sSignalNodeListPool =
      new List<List<SignalNode<dynamic>>>();
  static List<SignalNode<T>> getSignalNodeList<T>() {
    if (QueueHandle._sSignalNodeListPool.length > 0) {
      var temp = QueueHandle._sSignalNodeListPool.removeLast();
      temp.clear();
      return temp;
    }
    return new List<SignalNode<T>>();
  }

   SignalNode<T> getSignalNode<T>() {
    SignalNode<T> t;
    if (QueueHandle._sNodePool.length > 0) {
      t = QueueHandle._sNodePool.removeLast();
      t.$active = NodeActiveState.Runing;
    } else {
      t = new SignalNode<T>();
    }
    return t;
  }

  recycle<T>(List<SignalNode<T>> node) {
    if (QueueHandle._sSignalNodeListPool.length < 300) {
      QueueHandle._sSignalNodeListPool.add(node);
    }
  }

  SignalNode<T> $firstNode;
  SignalNode<T> $lastNode;
  Dictionary<ActionT<T>, SignalNode<T>> maping;
  num len = 0;
  bool $dispatching = false;
  num get length {
    return this.len;
  }

  dispatch(T e) {
    if (this.len > 0) {
      this.$dispatching = true;
      var t = this.$firstNode;
      var temp = QueueHandle.getSignalNodeList<T>();
      while (t != null) {
        if (t.$active == NodeActiveState.Runing) {
          t.action(e);
        }
        temp.add(t);
        t = t.next;
      }
      this.$dispatching = false;
      var l = temp.length;
      for (int i = 0; i < l; i++) {
        var item = temp[i];
        if (item.$active == NodeActiveState.ToDoDelete) {
          this.$remove(item, item.action);
        } else if (item.$active == NodeActiveState.ToDoAdd) {
          item.$active = NodeActiveState.Runing;
        }
      }
      this.recycle(temp);
    }
  }

  bool $addHandle(ActionT<T> value, T data,
      [bool forceData = false]) {
    if (this.maping == null) {
      this.maping = new Dictionary<ActionT<T>, SignalNode<T>>();
    }
    SignalNode<T> t = this.maping.get(value);
    if (t != null) {
      if (t.$active == NodeActiveState.ToDoDelete) {
        if (this.$dispatching) {
          t.$active = NodeActiveState.ToDoAdd;
        } else {
          t.$active = NodeActiveState.Runing;
        }
        t.data = data;
        return true;
      }
      if (forceData) {
        t.data = data;
      }
      return false;
    }

    t = this.getSignalNode();
    t.action = value;
    t.data = data;
    this.maping.add(value, t);

    if (this.$dispatching) {
      t.$active = NodeActiveState.ToDoAdd;
    }

    if (this.$lastNode != null) {
      this.$lastNode.next = t;
      t.pre = this.$lastNode;
      this.$lastNode = t;
    } else {
      this.$firstNode = this.$lastNode = t;
    }

    this.len++;
    return true;
  }

  bool $removeHandle(ActionT<T> value) {
    if (this.$lastNode == null || this.maping == null) {
      return false;
    }

    SignalNode<T> t = this.maping.get(value);
    if (t == null || t.$active == NodeActiveState.ToDoDelete) {
      return false;
    }

    if (this.$dispatching) {
      t.$active = NodeActiveState.ToDoDelete;
      return true;
    }

    return this.$remove(t, value);
  }

  bool hasHandle(ActionT<T> value) {
    if (this.maping == null) {
      return false;
    }
    return this.maping.get(value) != null;
  }

  bool $remove(SignalNode<T> t, ActionT<T> value) {
    if (t == null) {
      //DebugX.LogError("queueHandle error nil");
    }
    var pre = t.pre;
    var next = t.next;
    if (pre != null) {
      pre.next = next;
    } else {
      this.$firstNode = next;
    }

    if (next != null) {
      next.pre = pre;
    } else {
      this.$lastNode = pre;
    }
    t.$active = NodeActiveState.ToDoDelete;

    this.maping.remove(value);

    if (QueueHandle._sNodePool.length < QueueHandle.MAX) {
      t.action = null;
      t.pre = t.next = null;
      QueueHandle._sNodePool.add(t);
    }
    this.len--;

    if (this.len < 0) {
      //DebugX.LogError("QueueHandle lenError:" + this.len);
    }

    return true;
  }

  $clear() {
    if (null == this.$firstNode) {
      return;
    }
    var t = this.$firstNode;
    SignalNode<T> n;
    while (t != null) {
      t.action = null;
      if (QueueHandle._sNodePool.length > QueueHandle.MAX) {
        break;
      }
      n = t.next;

      t.action = null;
      t.pre = t.next = null;
      QueueHandle._sNodePool.add(t);

      t = n;
    }
    this.maping = null;
    this.$firstNode = this.$lastNode = null;
    this.len = 0;
  }
}
