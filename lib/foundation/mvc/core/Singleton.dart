part of foundation;
class Singleton {
  /// 单例辅助
  static Dictionary<String, Class> $uniqueClassMap =
      new Dictionary<String, Class>();
  static Dictionary<String, dynamic> $uniqueInstanceMap =
      new Dictionary<String, dynamic>();

  ///类名或都别名找到类
  static Dictionary<String, Class> $classMap = new Dictionary<String, Class>();
  ///别名关系表
  static Dictionary<String, String> $aliasMap =
      new Dictionary<String, String>();

  static String GetAliasName(ClassT c) {
    return "";
  }

  static void RegisterClass(ClassT c, aliasName) {

  }

  static Class GetClass(String proxyName) {

    return null;
  }
}
