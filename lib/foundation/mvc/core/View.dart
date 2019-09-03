part of foundation;

class View implements IView {
  Dictionary<String, IMVCHost> hostMap = new Dictionary<String, IMVCHost>();
  IMVCHost get(String name) {
    return this.hostMap.get(name);
  }

  bool register(IMVCHost host) {
    var name = host.name;
    if (this.hostMap.containsKey(name)) {
      DebugX.warn("duplicate:" + name);
      return false;
    }
    this.hostMap.add(name, host);
    host.onRegister();
    return true;
  }

  bool remove(IMVCHost host) {
    var name = host.name;
    if (this.hostMap.containsKey(name) == false) {
      DebugX.warn("not eixst:" + name);
      return false;
    }
    this.hostMap.remove(name);
    host.onRemove();
    return true;
  }
}
