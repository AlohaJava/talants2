
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:talants/utils.dart';
import 'package:talants/styles.dart';

class ImageChoiceField extends StatefulWidget{

  ImageChoiceField({
    this.info,
    this.valueCallBack,
    this.description,
  });

  final List<File> info;
  final Function(List<File> info) valueCallBack;
  final String description;


  @override
  createState() => ImageChoiceStepField();

}

class ImageChoiceStepField extends State<ImageChoiceField> {

  final picker = ImagePicker();

  String _path;
  List<File> _images = [];

  final TextStyle _titleStyle = TextStyle(
    fontFamily: 'Regular',
    fontSize: 15,
    color: Colors.grey,
  );
  final TextStyle _errorStyle = TextStyle(
    fontFamily: 'Regular',
    fontSize: 16,
    color: Colors.red,
  );
  final TextStyle _titleReqStyle = TextStyle(
    fontFamily: 'Regular',
    fontSize: 15,
    color: Colors.red,
  );

  @override
  void initState() {
    super.initState();
  }

  _notify() {
    widget.valueCallBack(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.description != null && false ? Container(
          margin: EdgeInsets.only(left: 10, bottom: widget.description is String ? 5:0),
          child: Row(
            children: [
              Text(widget.description, style: _titleStyle,),
           //   Text(widget.isRequired ? '*' : '', style: _titleReqStyle,)
            ],
          ),
        ) : Container(),
        Container(
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: _images.map((e) => _getImageItem(e)).toList()..add(
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            strokeWidth: 2,
                            dashPattern: [3, 3, 3, 3],
                            color: Colors.black38,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: EdgeInsets.all(22),
                                child: SvgPicture.asset(AppIcons.PLUS, color: Colors.black38),
                              ),
                            ),
                          ),
                        ),
                        onTap: _uploadImage,
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _getImageItem (File uuid) => Padding(
    padding: EdgeInsets.all(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
        child: Image.file(
          uuid,
          height: 80.0,
          width: 80.0,
        ),
        onTap: () async {
       /*   Navigator.of(context)
              .pushNamed(ImageScreen.route, arguments: ImageScreenArguments(uuid: uuid))
              .then((value) {
            if (value is String) {
              setState(() {
                _images.remove(value);
                _notify();
              });
            }
          });*/
        },
      ),
    ),
  );

  _uploadImage() async {
    showDialog(
      context: context,
      child: getSingleSelectDialog(['Камера', 'Галерея'], onTap: (index) async {
        Navigator.of(context).pop();
        var quality = 70;
        var size = 1000.0;
       // print("index " + index.toString() + "1/////////////////////////////////////////////");
        final PickedFile pickedFile = await picker.getImage(
           // source: ImageSource.camera,
            source: index == 0 ? ImageSource.camera : ImageSource.gallery,
            imageQuality: quality,
            maxWidth: size,
            maxHeight: size
        );
     //   print("index " + index.toString() + "1/////////////////////////////////////////////");
        if (pickedFile != null) {
          File file = File(pickedFile.path);
        //  value.putImage(file)
      //    String uuid = await Api.getInstance().then((value) => value.putImage(file)).then((value) => value);
      //    File smallFile = await _compress(file);
       //   String uuidSmall = await Api.getInstance().then((value) => value.putImage(smallFile, isPreview: true, uuid: uuid)).then((value) => value);
          if (file != null) {
            setState(() {
              _images.add(file);
              _notify();
            });
          }
        }
      }),
    );
  }

  Future<File> _compress(File file) async {
    var path = file.absolute.path;
    var newPath = '${path.substring(0, path.length-6)}small${path.substring(path.length-6, path.length)}';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      newPath,
      quality: 90,
      minHeight: 100,
      minWidth: 100,
    );
    return result;
  }

}