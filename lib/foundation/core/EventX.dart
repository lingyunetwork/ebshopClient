part of foundation;

class EventX extends MiEventX {
  static List<EventX> _sEventPool = List<EventX>();
  static final readyEventX = new EventX(EventX.READY);

  EventX(String type, [data, bool bubbles = false]) : super(type, data) {
    this.$mBubbles = bubbles;
  }

  static const START = "start";
  static const LOCK = "lock";
  static const UNLOCK = "unLock";
  static const String READY = "ready";

  static const OPEN = "open";
  static const CLOSE = "close";
  static const PAUSE = "pause";
  static const STOP = "stop";
  static const PLAY = "play";
  static const EXIT = "exit";
  static const ENTER = "enter";
  static const UPDATE = "update";
  static const ENTER_FRAME = "enterFrame";
  static const ADDED = "added";
  static const ADDED_TO_STAGE = "addedToStage";
  static const REMOVED = "removed";
  static const REMOVED_FROM_STAGE = "removedFromStage";
  static const TRIGGERED = "triggered";
  static const FLATTEN = "flatten";
  static const RESIZE = "resize";
  static const REPAINT = "Repaint";
  static const PROGRESS = "progress";
  static const CHANGE = "change";
  static const COMPLETE = "complete";
  static const CANCEL = "cancel";
  static const SUCCESS = "success";
  static const FAILED = "failed";
  static const SCROLL = "scroll";
  static const SELECT = "select";
  static const DESTOTY = "destory";
  static const DISPOSE = "dispose";
  static const DATA = "data";
  static const ERROR = "error";
  static const TIMEOUT = "timeout";
  static const CONNECTION = "connection";
  static const ITEM_CLICK = "itemClick";
  static const CLICK = "click";
  static const FOCUS_IN = "focus_in";
  static const FOCUS_OUT = "focus_out";
  static const TOUCH_BEGAN = "touchBegan";
  static const TOUCH_END = "touchEnd";
  static const TOUCH_MOVE = "touchMove";
  static const FIRE = "fire";
  static const RELOAD = "reload";
  static const RESTART = "restart";
  static const RENDER = "render";
  static const PING = "ping";
  static const RENDERABLE_CHANGE = "renderable_change";
  static const PANEL_SHOW = "panelShow";
  static const PANEL_HIDE = "panelHide";
  static const MEDIATOR_SHOW = "mediatorShow";
  static const MEDIATOR_HIDE = "mediatorHide";
  static const MEDIATOR_READY = "mediatorReady";
  static const PROXY_READY = "proxyReady";
  static const ROOT_CREATED = "rootCreated";
  static const SET_SKIN = "setSkin";
  static const STATE_CHANGE = "stateChange";
  static const CLEAR_CACHE = "clearCache";
  static const DEPEND_READY = "dependReady";
  static const CLEAR = "clear";

  IEventDispatcher $mTarget;
  IEventDispatcher $mCurrentTarget;
  bool $mBubbles=false;
  bool $mStopsPropagation = false;
  bool $mStopsImmediatePropagation = false;

   $setCurrentTarget(IEventDispatcher value) {
        $mCurrentTarget = value;
    }

  stopPropagation() {
    this.$mStopsPropagation = true;
  }

  stopImmediatePropagation() {
    this.$mStopsPropagation = this.$mStopsImmediatePropagation = true;
  }

  bool get bubbles {
    return this.$mBubbles;
  }

  IEventDispatcher get currentTarget => $mCurrentTarget;

  get stopsPropagation => $mStopsPropagation;
  get stopsImmediatePropagation => $mStopsImmediatePropagation;

  static EventX fromPool(String type, [data,bool bubbles=false]) {
    EventX e;
    if (EventX._sEventPool.length > 0) {
      e = EventX._sEventPool.removeAt(0);
      e.$reset(type, data);
      return e;
    } else
      return new EventX(type, data);
  }

  static void toPool(EventX e) {
    if (EventX._sEventPool.length < 100) {
      e.$mData = null;
      e.$mTarget = e.$mCurrentTarget = null;
      EventX._sEventPool.add(e);
    }
  }

  EventX $reset(String type, [data]) {
    this.$mType = type;
    this.$mData = data;
    this.$mTarget = this.$mCurrentTarget = null;
    this.$mStopsPropagation = this.$mStopsImmediatePropagation = false;
    return this;
  }

  EventX clone() {
    return new EventX(this.type, this.data, this.$mBubbles);
  }
}
