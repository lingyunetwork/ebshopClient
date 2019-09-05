import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_ui/image_picker_handler.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';

class PostArticlePage extends StatefulWidget {
  @override
  _PostArticlePageState createState() => new _PostArticlePageState();
}

class _PostArticlePageState extends State<PostArticlePage>
    with ImagePickerListener, TickerProviderStateMixin {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  File _image;
  String _name;

  String _password;

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

  AnimationController _controller;
  ImagePickerHandler imagePicker;
  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.build(0xFFEE6969, 0xFFFFFFFF, false);
    super.initState();
  }

  void _forSubmitted() {
    var _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      print(_name);
      print(_password);
    }
  }

  Future uploadImage(imgfile) async {
    String path = imgfile.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData =
        new FormData.from({"file": new UploadFileInfo(new File(path), name)});
    Response response;
    Dio dio = new Dio();
    response = await dio.post('后端接口', data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  }

  Future<void> loadAssets() async {
    imagePicker.showDialog(context);
  }

  Widget buildGridView() {
    if (_image == null) {
      return Text('No image selected.');
    }

    var _images = [_image];
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(_images.length, (index) {
        File asset = _images[index];
        return Image.file(
          asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Form'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _forSubmitted,
        child: new Text('提交'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: new InputDecoration(
                  labelText: '标题',
                ),
                validator: (val) {
                  return val.length < 4 ? "长度至少4位" : null;
                },
                onSaved: (val) {
                  _name = val;
                },
              ),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "副标题",
                ),
                onSaved: (val) {
                  _password = val;
                },
              ),
              IconButton(
                icon: Icon(Icons.photo),
                iconSize: 30,
                onPressed: loadAssets,
              ),
              Expanded(
                child: buildGridView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
