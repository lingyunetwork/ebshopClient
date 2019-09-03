part of foundation;

abstract class IMediator extends IMVCHost {
  setView(IPanel value);
  IPanel getView();

  setProxy(IProxy value);
  IProxy getProxy();

  toggleSelf([num type=-1]);
}
