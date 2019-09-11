import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebshop/main.dart';
import 'package:flutter/material.dart';

class GoodsCard extends StatefulWidget {
  final GoodsVO goodsVO;

  GoodsCard({Key key, this.goodsVO}) : super(key: key);

  _GoodsCardState createState() => _GoodsCardState();
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _GoodsCardState extends State<GoodsCard> {
  @override
  Widget build(BuildContext context) {
    var vo = widget.goodsVO;
    var name = "Reloaded 2 of 691 libraries";

    return Container(
      margin: new EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 2.0,
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: new BorderRadius.all(Radius.circular(5)),
        //gradient: new LinearGradient(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CachedNetworkImage(
                  //placeholder: (context, url) =>
                  //    Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  imageUrl: vo.url,
                  fit: BoxFit.fitWidth),
              Positioned(
                bottom: -15,
                left: 3,
                child: Transform(
                  transform: new Matrix4.identity()..scale(0.7),
                  child: Chip(
                      key: ValueKey<String>(name),
                      backgroundColor: Colors.red[300],
                      label: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      onDeleted: null),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${vo.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'desc: ${vo.desc}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage("assets/guide/3.jpg"),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                    Text(
                      ' 123456W',
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black54),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
