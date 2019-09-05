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

class ObjectUtil{

  static bool isEmpty(dynamic value){

    if(value is String){
      return value.length==0;
    }

    if(value is List){
      return value.length==0;
    }


    if(value is num){
      return value==0;
    }

    return value==null;
  }
  
}