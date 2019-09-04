part of foundation;

abstract class IFromJSON<T> {
  T newFromJSON(Map<String, dynamic> json);
}

class Factory {
  static List<T> fromJson<T>(List<dynamic> value,IFromJSON<T> creater) {
    List<T> list=List();
    for (var item in value) {
      list.add(creater.newFromJSON(item));
    }
    return list;
  }
}