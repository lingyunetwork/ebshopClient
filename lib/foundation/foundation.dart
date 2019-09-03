library foundation;

import 'dart:core';
import 'package:flutter/material.dart';

//core
part 'core/EventDispatcher.dart';
part 'core/EventX.dart';
part 'core/MiEventX.dart';
part 'core/Interface.dart';
part 'structure/ActionNode.dart';
part 'structure/Dictionary.dart';
part 'structure/QueueAction.dart';
part 'structure/QueueHandle.dart';
part 'structure/Signal.dart';
part 'structure/SignalNode.dart';
part 'structure/SimpleListPool.dart';
part 'utils/DebugX.dart';
part 'SocketX.dart';


//mvc
part 'mvc/core/View.dart';
part 'mvc/core/MVCInject.dart';
part 'mvc/core/Singleton.dart';
part 'mvc/core/AbstractMVHost.dart';
part 'mvc/interface/IPanel.dart';
part 'mvc/interface/IProxy.dart';
part 'mvc/interface/IFacade.dart';
part 'mvc/interface/IMediator.dart';
part 'mvc/interface/Interface.dart';
part "mvc/Facade.dart";
part 'mvc/Mediator.dart';
part 'mvc/Proxy.dart';
part "mvc/MacroCommand.dart";