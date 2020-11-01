import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/styles.dart';

import 'imageField/widget.dart';

class Fav {
  String what;
  bool isActive;
  String img;

  Fav(this.what, this.img, this.isActive);
}

class FavoritesScreen extends StatefulWidget {
  static CubeUser cubeUser;

  FavoritesScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  _FavoritesScreenState() {}

  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MainStyle.primaryColor, // status bar color
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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

  List<Fav> favoritesGroup = [
    Fav("Футбол", "assets/images/footbool.png", false),
    Fav("Математика", "assets/images/math.png", false),
    Fav("Информатика", "assets/images/informatics.png", false)
  ];

  buildFav(Fav f) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3),
          child: Image.asset(
            f.img,
            width: 34,
            height: 34,
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(f.what, style:TextStyle(fontSize: 20)),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          f.isActive=!f.isActive;
                        });
                      },
                        child: !f.isActive?Icon(Icons.add, color: StyleColor.importantColor,):Icon(Icons.check, color: Colors.green)
                    ),
                  ),
                ],
              ),
              Container(height: 1, color:Colors.grey, margin: EdgeInsets.only(top:8),)
            ],
          ),
        )
      ],
    );
  }

  buildFavs() {
    List<Widget> widgets = [];
    widgets.add(SizedBox(height: 10,));
    widgets.add(
        Align(
            alignment: Alignment.topLeft,
            child: Text("Ваши интересы?", style:TextStyle(fontSize: 22, fontWeight: FontWeight.bold  ),)
        )
    );
    widgets.add(SizedBox(height: 18,));
    favoritesGroup.forEach((element) {
      widgets.add(buildFav(element));
      widgets.add(SizedBox(height: 10,));
    });
    widgets.add(SizedBox(height: 18,));
    widgets.add(
        Align(
            alignment: Alignment.topLeft,
            child: Text("Ваши достижения?", style:TextStyle(fontSize: 22, fontWeight: FontWeight.bold  ),)
        )
    );
    widgets.add(SizedBox(height: 18,));
    widgets.add(ImageChoiceField(
      description: "Загрузите фото",
    ));
    return widgets;
  }

  buildContent() {
    var size = MediaQuery.of(context).size;
    print("building");
    return Container(
        color: MainStyle.primaryColor,
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(top: 5),
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
              margin: EdgeInsets.only(top: 10, left: 14, right: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: buildFavs()),
                  Container(
                    margin: EdgeInsets.only(bottom: 14),
                    child: FlatButton(
                      height: 50,
                      // Высота кнопки вход
                      minWidth: size.width * 0.4,
                      child: Text('Продолжить',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      onPressed: () async {
                        await Future.delayed(const Duration(seconds: 2), (){});
                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BottomNavigation()));
                      },
                      splashColor: Colors.white,
                      color: MainStyle.primaryColor,
                    ),
                  ),
                ],
              ),
            )));
  }

  buildPage() => Stack(
        children: [buildBackGround(), buildContent()],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Расскажите о себе"),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: buildPage());
  }
}
