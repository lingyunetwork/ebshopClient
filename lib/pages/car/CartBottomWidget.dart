import 'package:ebshop/provide/CartProvide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';

class CartBottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[100],
              offset: Offset(0, -2),
              spreadRadius: 0,
              blurRadius: 10)
        ]),
        child: Provide<CartProvide>(
          builder: (context, child, data) {
            double allPrice = data.allPrice;
            int allGoodsCount = data.allGoodsCount;
            return Row(
              children: <Widget>[
                _selectAllBtn(context,data),
                _allPriceArea(context, allPrice),
                _cartBtn(context, allGoodsCount),
              ],
            );
          },
        ));
  }

  Widget _selectAllBtn(BuildContext context,CartProvide data) {
    bool isAllCheck = data.isAllCheck;
    return Container(
      width: 100,
      height: 30,
      color: Colors.red,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool value) {
              data.changeAllChange(value);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget _allPriceArea(BuildContext context, double allPrice) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('合计：'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '￥$allPrice',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
            Container(
              height: 30,
              alignment: Alignment.centerRight,
              child: Text(
                '满10元免外送费,预约免配送费',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cartBtn(BuildContext context, int allGoodsCount) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: InkWell(
        onTap: () {},
        child: Text(
          '结算($allGoodsCount)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
