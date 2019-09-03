part of foundation;
abstract class Mediator extends AbstractMVHost with IMediator {
  IPanel _view;
  IProxy _model;

  bool _hasProgress = false;
  bool _isAwake = false;

  setView(IPanel value) {
    if (this._view != null) {
      if (this._hasProgress) {
        this
            ._view
            .removeEventListener(EventX.PROGRESS, this.viewProgressHandle);
      }
      this._view.$refMediator = null;
      this._view.removeEventListener(EventX.READY, this.preViewReadyHandler);
      this.bindSetViewEvent(this._view, false);
    }

    this._view = value;

    if (this._view != null) {
      this._view.$refMediator = this;
      var asyncView = this._view;
      if (asyncView.isReady == false) {
        if (this._hasProgress) {
          this._view.addEventListener(EventX.PROGRESS, this.viewProgressHandle);
        }
        this._view.addEventListener(EventX.READY, this.preViewReadyHandler);
        return;
      }
      this.preViewReadyHandler(null);
    }
  }

  bindSetViewEvent(IPanel view, bool isBind) {
    if (isBind) {
      view.addEventListener(EventX.PANEL_SHOW, this.stageHandle);
      view.addEventListener(EventX.PANEL_HIDE, this.stageHandle);
    } else {
      view.removeEventListener(EventX.PANEL_SHOW, this.stageHandle);
      view.removeEventListener(EventX.PANEL_HIDE, this.stageHandle);
    }
  }

  stageHandle(EventX e) {
    switch (e.type) {
      case EventX.PANEL_SHOW:
        this.facade.registerEventInterester(this, InjectEventType.Show, true);
        this
            .facade
            .registerEventInterester(this._model, InjectEventType.Show, true);

        if (this.isCanAwaken() && this.isReady && this._isAwake == false) {
          this._isAwake = true;
          if (this._model != null) {
            this.facade.registerEventInterester(
                this, InjectEventType.Proxy, true, this._model);
          }
          this.onPreAwaken();
        }
        break;
      case EventX.PANEL_HIDE:
        this.facade.registerEventInterester(this, InjectEventType.Show, false);
        this
            .facade
            .registerEventInterester(this._model, InjectEventType.Show, false);

        if (this.isReady && this._isAwake) {
          this._isAwake = false;
          if (this._model != null) {
            this.facade.registerEventInterester(
                this, InjectEventType.Proxy, false, this._model);
          }
          this.onPreSleep();
        }
        break;
    }
  }

  /// <summary>
  /// 现在状态是否可让它唤醒
  /// </summary>
  bool isCanAwaken() {
    return true;
  }

  IPanel getView() {
    return this._view;
  }

  load() {
    if (this._view.isReady == false) {
      this._view.startSync();
    }
  }

  setProxy(IProxy value) {
    if (this._model == value) {
      return;
    }
    if (this._model != null) {
      if (this._hasProgress) {
        this._model.removeEventListener(
            EventX.PROGRESS, this.modelProgressHandle);
      }
      this
          ._model
          .removeEventListener(EventX.READY, this.onPreModelReadyHandle);
      this.facade.registerEventInterester(
          this, InjectEventType.Proxy, false, this._model);
    }

    this._model = value;
    if (this._model != null && this.isReady && this._isAwake) {
      this.facade.registerEventInterester(
          this, InjectEventType.Proxy, true, this._model);
    }
  }

  IProxy getProxy() {
    return this._model;
  }

  @override
  toggleSelf([num type = -1]) {
    this.facade.toggleMediatorByName(this.name, type);
  }

  viewProgressHandle(EventX e) {}
  modelProgressHandle(EventX e) {}

  preViewReadyHandler(EventX e) {
    if (e != null) {
      var panel = e.target as IPanel;
      panel.removeEventListener(EventX.READY, this.preViewReadyHandler);
      if (this._hasProgress) {
        panel.removeEventListener(
            EventX.PROGRESS, this.viewProgressHandle);
      }
    }
    this.onViewReadyHandle();
    if (this._model == null) {
      this.onPreMediatorReadyHandle();
      return;
    }

    IAsync asyncModel = this._model;
    if (asyncModel.isReady == false) {
      if (this._hasProgress) {
        this
            ._model
            .addEventListener(EventX.PROGRESS, this.modelProgressHandle);
      }
      this
          ._model
          .addEventListener(EventX.READY, this.onPreModelReadyHandle);
      asyncModel.startSync();
      return;
    }
    this.onPreMediatorReadyHandle();
  }

  onPreModelReadyHandle(EventX e) {
    var proxy = e.target;
    if (this._hasProgress) {
      proxy.removeEventListener(EventX.PROGRESS, this.modelProgressHandle);
    }
    proxy.removeEventListener(EventX.READY, this.onPreModelReadyHandle);
    this.onModelReadyHandle();
    this.onPreMediatorReadyHandle();
  }

  onViewReadyHandle() {}

  onModelReadyHandle() {}

  onPreMediatorReadyHandle() {
    this.onMediatorReadyHandle();
    //DebugX.Log("mediator:{0} ready!",this.name);
    this.$isReady = true;

    this.dispatchReayHandle();
    this.facade.simpleDispatch(EventX.MEDIATOR_READY, this.name);

    this.bindSetViewEvent(this._view, true);
    if (this._view.isShow) {
      this.stageHandle(new EventX(EventX.PANEL_SHOW));
    }
  }

  onMediatorReadyHandle() {}

  bool _isCached = false;
  onPreAwaken() {
    if (this._isCached == false) {
      this._isCached = true;
      this.onCache();
    }
    this.onAwaken();
    this.onUpdateView();

    this.facade.simpleDispatch(EventX.MEDIATOR_SHOW, name);
  }

  onAwaken() {}

  onPreSleep() {
    this.onSleep();
    this.facade.simpleDispatch(EventX.MEDIATOR_HIDE, name);
  }

  onSleep() {}

  onUpdateView() {}
  onCache() {}
}
