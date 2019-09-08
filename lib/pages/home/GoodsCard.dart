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
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
              //placeholder: (context, url) =>
              //    Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              imageUrl: vo.url,
              fit: BoxFit.fitWidth),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
