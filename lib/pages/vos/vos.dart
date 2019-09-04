part of app;

class MenuVO implements IFromJSON<MenuVO> {
  String name = "";
  String icon = "";
  int type = 0;
  String url = "";

  MenuVO newFromJSON(Map<String, dynamic> json) {
    var vo = MenuVO();
    vo.name = json["name"];
    vo.icon = json["icon"];

    var type = json["type"] ?? 0;
    if (type is int) {
      vo.type = type;
    } else {
      vo.type = int.tryParse(type);
    }
    vo.url = json["url"];
    return vo;
  }
}
