part of foundation;

class QueueAction<T> {
  static const num MAX = 1000;
  static List<ActionNode<dynamic>> _sNodePool = new List<ActionNode<dynamic>>();
  static List<List<ActionNode<dynamic>>> _sSignalNodeListPool =
      new List<List<ActionNode<dynamic>>>();

   List<ActionNode<T>> getSignalNodeList<T>() {
    if (_sSignalNodeListPool.length > 0) {
      var temp = _sSignalNodeListPool.removeLast();
      temp.clear();
      return temp;
    }

    return new List<ActionNode<T>>();
  }

  ActionNode<T> getSignalNode<T>() {
    ActionNode<T> t;
    if (_sNodePool.length > 0) {
      t = _sNodePool.removeLast();
      t.$active = NodeActiveState.Runing;
    } else {
      t = new ActionNode<T>();
    }
    return t;
  }

  recycle<T>(List<ActionNode<T>> node) {
    if (_sSignalNodeListPool.length < 300) {
      _sSignalNodeListPool.add(node);
    }
  }

  ActionNode<T> $firstNode;
  ActionNode<T> $lastNode;
  TwoKeyDictionary<Action, dynamic, ActionNode<T>> maping;
  num len = 0;
  bool $dispatching = false;

  get length {
    return this.len;
  }

  dispatch() {
    if (this.len > 0) {
      this.$dispatching = true;
      var t = this.$firstNode;

      var temp = this.getSignalNodeList<T>();

      while (t != null) {
        if (t.$active == NodeActiveState.Runing) {
          t.action();
        }
        temp.add(t);
        t = t.next;
      }
      this.$dispatching = false;

      var l = temp.length;
      for (int i = 0; i < l; i++) {
        var item = temp[i];
        if (item.$active == NodeActiveState.ToDoDelete) {
          this.$remove(item, item.action, item.thisObj);
        } else if (item.$active == NodeActiveState.ToDoAdd) {
          item.$active = NodeActiveState.Runing;
        }
      }
      this.recycle(temp);
    }
  }

  bool $addHandle(Action value, thisObj, T data, [bool forceData = false]) {
    if (this.maping == null) {
      this.maping = new TwoKeyDictionary<Action, dynamic, ActionNode<T>>();
    }
    var t = this.maping.get(value, thisObj);
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

      //DebugX.Log(this.GetType().FullName + ":addReplace" + data.ToString());
      return false;
    }

    //DebugX.Log(this.GetType().FullName+":add"+data.ToString());

    t = this.getSignalNode();
    t.thisObj = thisObj;
    t.action = value;
    t.data = data;
    this.maping.add(value, thisObj, t);

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

  bool $removeHandle(Action value, thisObj) {
    if (this.$lastNode == null || this.maping == null) {
      return false;
    }

    var t = this.maping.get(value, thisObj);
    if (t != null || t.$active == NodeActiveState.ToDoDelete) {
      return false;
    }

    if (this.$dispatching) {
      t.$active = NodeActiveState.ToDoDelete;
      return true;
    }

    return this.$remove(t, value, thisObj);
  }

  bool hasHandle(Action value, thisObj) {
    if (this.maping == null) {
      return false;
    }

    return this.maping.containsKey(value, thisObj);
  }

  bool $remove(ActionNode<T> t, Action value, thisObj) {
    if (t == null) {
      //DebugX.LogError("queueAction error nil");
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

    this.maping.remove(value, thisObj);

    if (QueueAction._sNodePool.length < QueueAction.MAX) {
      t.action = null;
      t.pre = t.next = null;
      QueueAction._sNodePool.add(t);
    }
    this.len--;

    if (this.len < 0) {
      //DebugX.LogError("QueueAction lenError:" + this.len);
    }

    return true;
  }

  $clear() {
    if (null == this.$firstNode) {
      return;
    }

    var t = this.$firstNode;
    ActionNode<T> n;
    while (t != null) {
      if (QueueAction._sNodePool.length > QueueAction.MAX) {
        break;
      }
      n = t.next;

      t.action = null;
      t.pre = t.next = null;
      QueueAction._sNodePool.add(t);

      t = n;
    }

    this.maping = null;
    this.$firstNode = this.$lastNode = null;
    this.len = 0;
  }
}
