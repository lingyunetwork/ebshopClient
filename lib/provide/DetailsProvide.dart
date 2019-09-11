import 'package:flutter/material.dart';
import 'dart:convert';

class DetailsProvide with ChangeNotifier {
  DetailsVO goodsVO = null;
  bool isLeft = true;
  bool isRight = false;

  // 从后台获取数据
  getGoodsVO(String id) {
    // var formData = {
    //   'goodId':id
    // };
    // await request('https://resources.ninghao.net/demo/posts.json').then((res){
    var res = """
        {"code":"0","message":"success","data":{"goodInfo":{"image5":"","amount":10000,"image3":"","image4":"","goodsId":"ed675dda49e0445fa769f3d8020ab5e9","isOnline":"yes","image1":"http://images.baixingliangfan.cn/shopGoodsImg/20190116/20190116162618_2924.jpg","image2":"","goodsSerialNumber":"6928804011173","oriPrice":3.00,"presentPrice":2.70,"comPic":"http://images.baixingliangfan.cn/compressedPic/20190116162618_2924.jpg","state":1,"shopId":"402880e860166f3c0160167897d60002","goodsName":"可口可乐500ml/瓶","goodsDetail":["http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_5060.jpg","http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_1063.jpg","http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8029.jpg","http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_1074.jpg","http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8439.jpg","http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_6800.jpg"]},"goodComments":[{"SCORE":5,"comments":"果断卸载，2.5个小时才送到","userName":"157******27","discussTime":1539491266336}],"advertesPicture":{"PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg","TO_PLACE":"1"}}}
      """;
    var responseData = json.decode(res.toString());
    print(responseData);
    goodsVO = DetailsVO.fromJson(responseData);
    notifyListeners();
    // });
  }

  // tabbar 切换
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}

class DetailsVO {
  static fromJson(responseData) {}
}
