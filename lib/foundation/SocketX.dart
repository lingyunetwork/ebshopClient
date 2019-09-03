part of foundation;
abstract class IStream {
  num code;
}

class MiStream implements IStream {
  num code;

  static List<MiStream> _pool = new List<MiStream>();

  static IStream fromPool(num code) {
    var s;
    if (_pool.length > 0) {
      s = _pool.removeLast();
    } else {
      s = new MiStream();
    }
    s.code = code;
    return s;
  }

  static toPool(IStream s) {
    if (_pool.length < 100) {
      _pool.add(s);
    }
  }
}

abstract class ISocketSender extends IEventDispatcher {
  bool send(IStream msg);
  bool connected = false;
  close();
}

class SocketX {
  static SocketX instance;
  static ISocketSender _sender;
  static Dictionary<num, Set<ActionT<IStream>>> cmds =
      new Dictionary<num, Set<ActionT<IStream>>>();

  static Set<ActionT<IStream>> onceCmds = new Set<ActionT<IStream>>();

  static SocketX getInstance() {
    if (SocketX.instance == null) {
      SocketX.instance = new SocketX();
    }
    return SocketX.instance;
  }

  static bind(ISocketSender sender) {
    SocketX.getInstance();
    SocketX._sender = sender;
  }

  static bool Send(IStream msg, [ActionT<IStream> handle]) {
    if (handle != null) {
      AddListener(msg.code, handle, true);
    }
    return _sender.send(msg);
  }

  static bool SendCode(num code, [ActionT<IStream> handle]) {
    if (handle != null) {
      AddListener(code, handle, true);
    }

    var msg = MiStream.fromPool(code);
    var b = _sender.send(msg);
    MiStream.toPool(msg);

    return b;
  }

  static get IsConnected {
    return _sender.connected;
  }

  static Close() {
    _sender.close();
  }

  static bool AddEventListener(String type, ActionT<EventX> listener,
      [priority = 0]) {
    return _sender.addEventListener(type, listener, priority);
  }

  static bool RemoveEventListener(String type, ActionT<EventX> listener) {
    return _sender.removeEventListener(type, listener);
  }

  static bool AddListener(num code, ActionT<IStream> handle,
      [bool isOnce = false]) {
    var list = cmds.get(code);
    if (list != null) {
      list = new Set<ActionT<IStream>>();
      cmds.add(code, list);
    }

    list.add(handle);

    if (isOnce) {
      onceCmds.add(handle);
    }

    return true;
  }

  static bool Dispatch(IStream msg) {
    var pool = SimpleListPool.get();

    var list = cmds.get(msg.code);
    pool.addAll(list);

    for (var item in pool) {
      //先把空间里面的删除掉
      if (onceCmds.contains(item)) {
        list.remove(item);
        onceCmds.remove(item);
      }
      item(msg);
    }

    SimpleListPool.release(pool);
    return true;
  }
}
