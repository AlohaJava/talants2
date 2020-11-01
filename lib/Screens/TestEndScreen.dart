import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/Screens/EventScreen.dart';
import 'package:talants/Screens/TestSlideScreen.dart';

import '../utils.dart';



class Event {
  String title;
  String text;
  String image;
  String type = "Simple";

  Event(
      this.title,
      this.text,
      this.image,
      this.type
      );
}

class TestEndScreen extends StatefulWidget {
  bool withTab = true;
  TestEndScreen({
    this.withTab = true,
  });
  //TestEndScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _TestEndScreenState();
}

class _TestEndScreenState extends State<TestEndScreen> {
  _TestEndScreenState() {}

  final TextStyle _titleStyle = TextStyle(
   // fontFamily: 'Regular',
    fontWeight: FontWeight.w300,
    fontSize: 22,
    color: Colors.black87,
  );

  final TextStyle _dataStyle = TextStyle(
    fontFamily: 'Regular',
    fontSize: 18,
    color: Colors.black54,
  );

  List<Event> testList = [];

  List<FileImage> _imageList = [];

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    testList.forEach((element) { _imageList.add(FileImage(File(element.image))); });
    getTests();

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


  @override
  Widget build(BuildContext context) {
   // getTests();
    if (widget.withTab)
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: backArrow(context, 1),
            title: Text("Рекомендации"),
            backgroundColor: MainStyle.primaryColor,
            centerTitle: true,
          ),
          body: buildPage());
    else
      return buildContent();

  }

  buildPage() => Stack(
    children: [buildContent()],
  );

  buildContent() {
    var size = MediaQuery.of(context).size;
    return Expanded(

          child: Column(
            children: [
              Container(height: 20,),
              Center(child: Text("Наставники для вас:", style: TextStyle(fontFamily: "Montserrat", fontSize: 26))),
              Container(height: 10,),
              Container(child: SizedBox(height: 90, width: size.width, child: _buildChatsList(),)),

              Container(height: 20,),
              Center(child: Text("События для вас:", style: TextStyle(fontFamily: "Montserrat", fontSize: 26))),
              Container(height: 10,),
              Expanded(child: _buildMainList()),
            ],
          )
    );
  }

  getTests() {
    setState(() {
      testList = [
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Simple"),
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Simple"),
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Big"),
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Simple"),
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Big"),
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Simple"),
        Event("Олимпиада по информатике", "2020.12.30 будет проведенна олимпиада по информатики. Для участия в олимпиаде вам необходимо подать заявку на сайте www.olip.com", "assets/images/books.png", "Simple"),
      ];
    });
  }

  Widget _buildMainList()
  {
    if (testList.length == 0) {
      return Center(
        child: Text("Нет рекомендаций.", style: TextStyle(fontSize: 18)),
      );
    }
    List<Widget> list = List<Widget>();
    for (int i = 0; i < testList.length; i++) {
      list.add(_buildEvent(context, i));
    }
    list.add(Container(height: 20,));
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  Widget _buildEvent(BuildContext context, int index) {
    if (testList[index].type == "Simple")
      return _buildEventSmall(context, index);
    if (testList[index].type == "Big")
      return _buildEventBig(context, index);

    return Container();
  }

  Widget _buildEventSmall(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => {
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: EventScreen(ActualEvent : testList[index])) )
      },
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        width: size.width,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)), //here
          color: Colors.white ,
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2,2), blurRadius: 5 )],
          //  border: Border.all(color: Colors.black54, width: 1, )
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(5),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),),
                      child: Image.asset(
                          testList[index].image,
                          fit: BoxFit.cover ,
                      ),
                  ),
                ),
              ),
            ),
            Container(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 5),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30,
                      width: size.width*0.68,
                      child: AutoSizeText(
                        testList[index].title,
                        style: TextStyle(
                          // fontFamily: 'Regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: Colors.black87.withAlpha(255),
                        ),
                        maxLines: 1,
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30,
                      width: size.width*0.68,
                      child: AutoSizeText(
                        testList[index].text.length<30?testList[index].text:testList[index].text.substring(0,30) + "...",
                        style: TextStyle(
                          // fontFamily: 'Regular',
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Colors.black87.withAlpha(180),
                        ),
                        maxLines: 1,
                      ),
                    )),
                Container(height: 0),
              ],
            )
          ],
        )
      ),
    );
  }


  Widget _buildEventBig(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => { Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: EventScreen(ActualEvent : testList[index])))},
      child: Container(
          width: size.width,
          height: 120,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)), //here
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(4,4), blurRadius: 8 )],
            //  border: Border.all(color: Colors.black54, width: 1, )
          ),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),),
                      child: Image.asset(
                        testList[index].image,
                        fit: BoxFit.cover ,
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 5),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 50,
                        width: size.width*0.55,
                        child: AutoSizeText(
                          testList[index].title,
                          style: TextStyle(
                            // fontFamily: 'Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                            color: Colors.black87.withAlpha(255),
                          ),
                          maxLines: 2,
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 60,
                        width: size.width*0.55,
                        child: AutoSizeText(
                          testList[index].text.length<70?testList[index].text:testList[index].text.substring(0,70) + "...",
                          style: TextStyle(
                            // fontFamily: 'Regular',
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.black87.withAlpha(180),
                          ),
                          maxLines: 3,
                        ),
                      )),
                  Container(height: 0),
                ],
              )
            ],
          )
      ),
    );
  }


  Widget _buildChatsList() {
    List<Widget> list = List<Widget>();

    list.add(Container(width: 10,));
    for (int i = 0; i < testList.length; i++) {
      list.add(_buildChats(context, i));
    }
    list.add(Container(width: 10,));
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget _buildChats(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => {
      //  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: EventScreen(ActualEvent : testList[index])) )
      },
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)),),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left:10),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 75,
                height: 75,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2,2), blurRadius: 5 )],),

                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75.0),
                    child: Container(
                      width: size.width*0.9,
                      height: size.height*0.25,
                      //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),),
                      child: Image.asset(
                        "assets/images/Acula.png",
                        fit: BoxFit.cover ,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(2),
                child: Center(
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: Colors.green,
                    ),)
                ),
              ),
            ),
          ],
        ),
      ));
  }


  int choosenPodScreen = 0;

}
