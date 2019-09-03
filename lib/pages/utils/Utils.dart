part of app;


class Util{
  static Widget getMore(String value){
    return Row(
        children:<Widget>[
        TextU.getDef(value,Colors.grey),
        Icon(Icons.keyboard_arrow_right)]
    );
  }

  static Widget getTileBar(String value,[Color color=Colors.grey,IconData icon=Icons.dashboard]){
    return Row(
        children:<Widget>[
        Icon(icon),
        SizedBox(width: 4,),
        TextU.getDef(value,color),
        ]
    );
  }
}

class TextU{

  static Text getH1(String value,[Color color=Colors.black]){
     return Text(
      value,
      style: TextStyle(
          fontSize: 30, color: color, fontWeight: FontWeight.bold),
    );
  }


  static Text getH2(String value,[Color color=Colors.black]){
     return Text(
      value,
      style: TextStyle(
          fontSize: 20, color: color, fontWeight: FontWeight.w600),
      textAlign: TextAlign.left,
    );
  }


  static Text getH3(String value,[Color color=Colors.black]){
     return Text(
      value,
      style: TextStyle(
          fontSize: 16, color: color, fontWeight: FontWeight.w500),
      textAlign: TextAlign.left,
    );
  }


  static Text getDef(String value,[Color color=Colors.black]){
     return Text(
      value,
      style: TextStyle(
          fontSize: 14, color: color, fontWeight: FontWeight.normal),
      textAlign: TextAlign.left,
    );
  }

}