part of foundation;

abstract class IFacade extends INotifier with IEventDispatcher {

  IMediator getMediatorByName(String name);
  T getMediator<T extends IMediator>(ClassT<T> c);

  bool hasMediatorByName(String mediatorName);
  bool hasMediator<T extends IMediator>(ClassT<T> c);

  IMediator toggleMediatorByName(String mediatorName, [num type = -1]);
  T toggleMediator<T extends IMediator>(ClassT<T> c, [num type = -1]);
  registerMediator(IMediator mediator);

  /// @param proxyName 数据管理类

  IProxy getProxyByName(String proxyName);
  T getProxy<T extends IProxy>(ClassT<T> c);

  bool hasProxyByName(String proxyName);
  bool hasProxy<T extends IProxy>(ClassT<T> c);
  registerProxy(IProxy proxy);

  /// @param eventType 注册事件
  /// @param c 事件独立处理类
  bool registerCommand<T>(String eventType, ClassT<T> c);
  bool removeCommand<T>(String eventType, ClassT<T> c);
  bool hasCommand(String eventType);

  /// @param eventInterester 关注事件处理类
  /// @param injectEventType 关注类型
  /// @param isBind 添加还是删除

  registerEventInterester(
      IEventInterester eventInterester, InjectEventType injectEventType,
      [bool isBind = true, IEventDispatcher dispatcher]);

  /// 用于限制互相依赖的锁
  /// @param className

  dynamic getInjectLock(String className);

  $unSafeInjectInstance(IMVCHost toLockInstance, [String className]);

  IInjectable inject(IInjectable target);

  /// 自动初始化

  autoInitialize(String type);
}
