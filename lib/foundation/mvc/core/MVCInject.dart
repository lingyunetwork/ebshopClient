part of foundation;
///注入管理类
class MVCInject implements IInject {
  static const INJECTABLE = "__injectable";

  static Dictionary<String, String> InjectShortNameMapping =
      new Dictionary<String, String>();

  MVCInject(Facade facade) {}

  IInjectable inject(IInjectable target) {
    return target;
  }
}
