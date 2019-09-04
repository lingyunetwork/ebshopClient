part of foundation;

class DataProvider {
  Dictionary<String, List> map = Dictionary();

  bool add(String key, List value) {
    if (map.containsKey(key)) {
      return false;
    }

    map.add(key, value);
    return true;
  }

  get<T>(String key) {
    var value = map.get(key);
    return value;
  }
}
