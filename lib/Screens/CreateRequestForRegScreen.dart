import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Screens/imageField/widget.dart';

class ImageListItem{
  File _image;
  bool isMain;
  ImageListItem(this._image,[this.isMain=false]);

  @override
  String toString() {
    return 'ImageListItem{_image: $_image, isMain: $isMain}';
  }
}

class CreateRequestForRegScreen extends StatefulWidget {
  CreateRequestForRegScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreateRequestForRegScreenState();
}

class _CreateRequestForRegScreenState extends State<CreateRequestForRegScreen> with TickerProviderStateMixin {
  _CreateRequestForRegScreenState() {}

  List<ImageListItem> imageList = List<ImageListItem>();

  var controller = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  List<File> info;
  Function(List<File> info) valueCallBack;
  String description;

  onFieldChange(List<File> infoNew) {
    int pos;
    this.info = infoNew;
 //   form.forEach((element) {
  //    if (element.id == info.id) pos = form.indexOf(element);
 ////   });
  //  form[pos].value = info.value;
  }

  void initState() {
    super.initState();

    valueCallBack = onFieldChange;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /*
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MainStyle.primaryColor, // status bar color
    ));

     */
  }

  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  buildBackGround() {
    return Container();
  }

  addPhoto(){
    print("clicked");
    imageList.add(ImageListItem(null));
    setState(() {

    });
  }

  buildAddImage(){
    return GestureDetector(
      onTap: (){addPhoto();},
      child: Container(
        height: 80,
        width: 80,
        color: Colors.red,
      ),
    );
  }

  buildPhotoImage(int index){
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
      color: Colors.yellow,
        ),
         Positioned(
           top: 0,
           right: 0,
           child: GestureDetector(
              onTap: (){
                setState((){
                  imageList.removeAt(index);
                });
              },
              child: Icon(
              Icons.delete,
            ),
        ),
         ),
      ],
    );
  }

  buildImageList(){
    if(imageList.length==5){
      return Container(
        height: 80,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return buildPhotoImage(index);
          },
        ),
      );
    }
    else{
      var tempList = []..addAll(imageList);
      tempList.add(ImageListItem(null,true));
      print(tempList);
      return Container(
        height: 80,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tempList.length,
          itemBuilder: (context, index) {
              if(tempList[index].isMain){
                return buildAddImage();
              } else return buildPhotoImage(index);
          },
        ),
      );
    }
  }

  buildContent() {
    var size = MediaQuery.of(context).size;
    print("building");
    return Container(
      color: MainStyle.primaryColor,
      child: Container(
          margin: EdgeInsets.only(top:5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            color: Colors.white,
            boxShadow: [
            BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          )
      ]),
          child: Container(
            margin: EdgeInsets.only(top:15,left: 14,right: 14),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Text("Создайте заявку на участие в программе талантов города Тюмень.", style:TextStyle(fontSize: 16)),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left:20),
                      hintText: 'ФИО',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    inputFormatters: [controller],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left:20),
                      hintText: 'Номер телефона',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    maxLines: 22,
                    minLines: 8,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left:20, top:25),
                      hintText: 'Расскажите о своих достижениях',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text("Добавьте фотографии ваших достижений",textAlign: TextAlign.left, style:TextStyle(fontSize: 16)),
                  SizedBox(height: 15),
                  ImageChoiceField(
                      info:info,
                      valueCallBack: valueCallBack,
                      description: "Загрузите фото",
                  ),
                //  buildImageList(),
                  SizedBox(height: 15),
                  FlatButton(
                    height: 50,
                    // Высота кнопки вход
                    minWidth: size.width * 0.4,
                    child: Text('Отправить',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {},
                    splashColor: Colors.white,
                    color: MainStyle.primaryColor,
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          )
      ),
    );
  }

  buildPage() => Stack(
    children: [buildBackGround(), buildContent()],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: MainStyle.primaryColor,
          elevation: 0.0,
          bottomOpacity: 0.0,
            brightness: Brightness.light,
            title: Text("Заявка на регистрацию"),
          centerTitle: true,
        ),
        body: buildPage()
    );
  }
}
