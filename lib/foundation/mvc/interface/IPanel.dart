part of foundation;
abstract class IPanel with IAsync, IEventDispatcher {
  bool isShow;
  IMediator $refMediator;
  show([Widget container]);
  hide();
  bringTop();
}
