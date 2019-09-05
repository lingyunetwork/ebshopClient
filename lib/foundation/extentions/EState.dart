part of foundation;
abstract class EStage<T extends StatefulWidget> extends State<T>{

  invalidate(){
    this.setState(_empty);
  }

  //不做任何事
  _empty(){

  }


  navigate(BuildContext context,MenuVO value) async{
    if(value.url!=null){
      launch(value.url);
    }
  }
}