part of foundation;
class Facade extends EventDispatcher with IFacade {
  Dictionary<String, dynamic> mvcInjectLock = new Dictionary<String, dynamic>();
  Dictionary<String, dynamic> commandsMap = new Dictionary<String, dynamic>();
  IInject injecter;
  IView view;
  IView model;
  static IFacade instance;

  static IFacade getInstance() {
    if (Facade.instance == null) {
      Facade.instance = new Facade();
    }
    return Facade.instance;
  }

  Facade() {
    this.view = new View();
    this.model = new View();
    this.injecter = new MVCInject(this);
  }

  bool hasMediatorByName(String mediatorName) {
    return this.view.get(mediatorName) != null;
  }

  bool hasMediator<T extends IMediator>(ClassT<T> c) {
    var aliasName = Singleton.GetAliasName(c);
    return this.hasMediatorByName(aliasName);
  }

  IMediator getMediatorByName(String mediatorName) {
    var mediator = this.view.get(mediatorName) as IMediator;
    if (mediator == null) {
      var cls = Singleton.GetClass(mediatorName);
      if (cls!=null) {
        mediator = this.routerCreateInstance(cls) as IMediator;
        mediator.name = mediatorName;
        this.$unSafeInjectInstance(mediator, mediatorName);
        this.registerMediator(mediator);
      } else {
        print(mediatorName + " isn't registed!");
      }
    }
    return mediator;
  }

  registerMediator(IMediator mediator) {
    this.view.register(mediator);
  }

  registerProxy(IProxy proxy) {
    this.model.register(proxy);
  }

  bool registerCommand<T>(String eventType, ClassT<T> c) {
    
    if (this.commandsMap.containsKey(eventType)) {
      return false;
    }
    this.commandsMap.add(eventType, c);
    return true;
  }

  bool removeCommand<T>(String eventType, ClassT<T> c) {
    if (this.commandsMap.containsKey(eventType)) {
      this.commandsMap.remove(eventType);
      return true;
    }
    return false;
  }

  bool hasCommand(String eventType) {
    return this.commandsMap.containsKey(eventType);
  }

  $unSafeInjectInstance(IMVCHost host, [String hostName]) {
    if (hostName == null) {
      hostName = host.name;
    }

    this.mvcInjectLock.add(hostName, host);
    //给类的成员变量赋值、注册这个类
    this.inject(host);
    this.mvcInjectLock.remove(hostName);
  }

  dynamic getInjectLock(String className) {
    return this.mvcInjectLock.get(className);
  }


  dynamic routerCreateInstance(Class type) {
    return type();
  }

  IInjectable inject(IInjectable target) {
    if (this.injecter != null) {
      return this.injecter.inject(target);
    }
    return target;
  }

  T getMediator<T extends IMediator>(ClassT<T> c) {
    var aliasName = Singleton.GetAliasName(c);
    var ins = this.getMediatorByName(aliasName);
    if (ins != null) {
      Singleton.RegisterClass(c, aliasName);
      ins = this.getMediatorByName(aliasName);
    }

    return ins;
  }

  static T GetMediator<T extends IMediator>(ClassT<T> c) {
    return Facade.getInstance().getMediator(c);
  }

  static T GetProxy<T extends IProxy>(ClassT<T> c) {
    return Facade.getInstance().getProxy(c);
  }

  static T ToggleMediator<T extends IMediator>(ClassT<T> c) {
    return Facade.getInstance().toggleMediator(c);
  }

  bool hasProxyByName(String proxyName) {
    return this.model.get(proxyName) != null;
  }

  bool hasProxy<T extends IProxy>(ClassT<T> c) {
    var aliasName = Singleton.GetAliasName(c);
    return this.hasProxyByName(aliasName);
  }

  IProxy getProxyByName(String proxyName) {
    var proxy = this.model.get(proxyName);
    if (proxy == null) {
      var cls = Singleton.GetClass(proxyName);
      if (cls != null) {
        proxy = this.routerCreateInstance(cls);
        this.$unSafeInjectInstance(proxy, proxyName);
        this.registerProxy(proxy);
      }
    }
    return proxy;
  }

  T getProxy<T extends IProxy>(ClassT<T> c) {
    var aliasName = Singleton.GetAliasName(c);
    var ins = this.getProxyByName(aliasName);
    if (ins != null) {
      Singleton.RegisterClass(c, aliasName);
      ins = this.getProxyByName(aliasName);
    }

    return ins;
  }

  IMediator toggleMediatorByName(String mediatorName, [num type = -1]) {
    if (mediatorName == null) {
      return null;
    }

    if (type == 0) {
      if (this.hasMediatorByName(mediatorName) == false) {
        return null;
      }
    }

    var mediator = this.getMediatorByName(mediatorName);
    if (mediator == null) {
      return null;
    }

    //如果是异步的 并且isReady为false 就先执行startAsync方法，并把toggleMediator方法添加到readyHandle队列，返回mediator
    if (mediator.isReady == false) {
      mediator
          .addReayHandle((e) => this.toggleMediatorByName(mediatorName, type));
      mediator.startSync();
      return mediator;
    }

    //获取view，根据type决定调用show或hide
    var view = mediator.getView();
    switch (type) {
      case 1:
        if (view.isShow == false) {
          view.show();
        } else {
          view.bringTop();
        }
        break;
      case 0:
        if (view.isShow) {
          view.hide();
        }
        break;
      case -1:
        if (view.isShow) {
          view.hide();
        } else {
          view.show();
        }
        break;
    }
    return mediator;
  }

  T toggleMediator<T extends IMediator>(ClassT<T> c, [num type = -1]) {
    var aliasName = Singleton.GetAliasName(c);
    var t = this.toggleMediatorByName(aliasName, type);
    if (t == null) {
      Singleton.RegisterClass(c, aliasName);
      t = this.toggleMediatorByName(aliasName, type);
    }

    return t;
  }

  registerEventInterester(
      IEventInterester eventInterester, InjectEventType injectEventType,
      [bool isBind = true, IEventDispatcher dispatcher]) {
    if (eventInterester == null) {
      return;
    }
    var eventInterests = eventInterester.getEventInterests(injectEventType);
    if (eventInterests == null) {
      return;
    }

    if (dispatcher == null) {
      dispatcher = this;
    }

    if (isBind) {
      for (var typeEventsHandle in eventInterests) {
        for (var eventType in typeEventsHandle.events) {
          dispatcher.addEventListener(
              eventType, typeEventsHandle.handle);
        }
      }
    } else {
      for (var typeEventsHandle in eventInterests) {
        for (var eventType in typeEventsHandle.events) {
          dispatcher.removeEventListener(
              eventType, typeEventsHandle.handle);
        }
      }
    }
  }

  autoInitialize(String type) {}
  static bool SimpleDispatch(String eventType, [data]) {
    return Facade.getInstance().simpleDispatch(eventType, data);
  }

  bool simpleDispatch(String eventType, [data]) {
    if (!this.hasEventListener(eventType)) {
      return false;
    }

    //从事件池中取一个项，用于事件发布,发布完后，再压进事件池;
    var e = EventX.fromPool(eventType, data);
    var commandClassRef = this.commandsMap.get(eventType);
    if (commandClassRef) {
      var command = commandClassRef();
      command.execute(e);
    }

    var b = this.dispatchEvent(e);
    EventX.toPool(e);

    return b;
  }
}
