part of clayui;
abstract class EStage<T extends StatefulWidget> extends State<T>{

  invalidate(){
    this.setState(_empty);
  }

  //不做任何事
  _empty(){

  }
}