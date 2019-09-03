part of foundation;
class Signal extends QueueHandle<EventX> {
  bool add(ActionT<EventX> value, [num priority = 0]) {
    if (this.maping == null) {
      this.maping =
          new Dictionary<ActionT<EventX>, SignalNode<EventX>>();
    }

    var t = this.maping.get(value);
    if (t != null) {
      //如果已被删除过程中又被添加(好神奇的逻辑,但必然会有这种情况，不是可能);
      if (t.$active == NodeActiveState.ToDoDelete) {
        if (this.$dispatching) {
          t.$active = NodeActiveState.ToDoAdd;
        } else {
          t.$active = NodeActiveState.Runing;
        }
        return true;
      }
      return false;
    }

    var newNode = this.getSignalNode<EventX>();

    newNode.action = value;
    newNode.priority = priority;

    this.maping.add(value, newNode);

    if (this.$dispatching) {
      newNode.$active = NodeActiveState.ToDoAdd;
    }

    if (this.$firstNode == null) {
      this.len = 1;
      this.$lastNode = this.$firstNode = newNode;
      return true;
    }

    SignalNode<EventX> findNode;
    if (priority > this.$lastNode.priority) {
      t = this.$firstNode;
      SignalNode<EventX> pre;
      //var next:SignalNode;
      while (null != t) {
        if (priority > t.priority) {
          pre = t.pre;
          //next=t.next;
          newNode.next = t;
          t.pre = newNode;

          if (null != pre) {
            pre.next = newNode;
            newNode.pre = pre;
          } else {
            this.$firstNode = newNode;
          }

          findNode = t;

          break;
        }
        t = t.next;
      }
    }

    if (null == findNode) {
      this.$lastNode.next = newNode;
      newNode.pre = this.$lastNode;
      this.$lastNode = newNode;
    }
    this.len++;
    return true;
  }

  bool remove(ActionT<EventX> value) {
    return this.$removeHandle(value);
  }
}
