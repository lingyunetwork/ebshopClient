part of foundation;

abstract class IFromJSON<T> {
  T newFromJSON(Map<String, dynamic> json);
}

class Factory {
  static List<T> fromJson<T>(Map value,String key,IFromJSON<T> creater) {
    List<T> list=List();
    var datas=value[key];
    for (var item in datas) {
      list.add(creater.newFromJSON(item));
    }
    return list;
  }
}