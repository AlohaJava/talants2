

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/OpenedNewsData.dart';
import 'package:talants/Screens/EventScreen.dart';
import 'package:talants/Screens/OpenedNewsScreen.dart';
import 'package:talants/Screens/TestEndScreen.dart';
import 'package:talants/styles.dart';

class News {
  String title;
  String text;
  String imageUrl;
  String newsUrl;
  String newsData;

  News(this.title, this.text, this.imageUrl, this.newsUrl, this.newsData);
}

class NewsListScreen extends StatefulWidget {
  NewsListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _NewsListScreen();
}

class _NewsListScreen extends State<NewsListScreen>
    with SingleTickerProviderStateMixin {
  _NewsListScreen() {}

  final TextStyle _titleStyle = TextStyle(
    fontSize: 26,
    color: Colors.black,
    fontWeight: FontWeight.w300
  );

  final TextStyle _dataStyle = TextStyle(
    fontFamily: 'Regular',
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: Colors.black87.withAlpha(180),
  );

  List<News> newsList = [];

  void initState() {
    super.initState();
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


  buildNewsCard(News item, int index) {
    var size = MediaQuery.of(context).size;
    if (index == newsList.length)
      return Container(height: 20,);
    print(item.imageUrl);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          OpenedNewsScreen.routeName,
          arguments: OpenedNewsData(
            item.newsUrl,
            item.title
          ),
        );
      },
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20, top: 15),
          padding: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)), //here
            color:Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2,2), blurRadius: 5 )],
            //  border: Border.all(color: Colors.black54, width: 1, )
          ),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Container(
                    width: size.width*0.9,
                    height: size.height*0.18,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(75.0)), ) ,
                  //    boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2,2), blurRadius: 5 )],),

                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          width: size.width*0.9,
                          height: size.height*0.25,
                          //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),),
                          child: CachedNetworkImage(
                           // placeholder: (context, url) => Container( width:50, height: 50,child: CircularProgressIndicator()),
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Align(alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        item.title,
                        style: _titleStyle,
                        maxLines: 1,
                      ),

                      Center(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            item.newsData,
                            style: _dataStyle,
                          ),
                        ),
                      )
                    ],
                  ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 45,
                    width: size.width,
                    child: AutoSizeText(
                     (item.text.length<75?item.text:item.text.substring(0,75)) + "...",
                      style: TextStyle(
                        // fontFamily: 'Regular',
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.black87.withAlpha(180),
                      ),
                      maxLines:2,
                    ),
                  )),
            ],
          ),
        ),
    );
  }

  getNews() async{
    print("Getting news!");
    setState(() {
      newsList = [
        News("Тестовая статья", "Разработчики из польской студии CD Projekt RED в Твиттере вновь сообщили неприятную новость — релиз Cyberpunk 2077 отложен на 21 день.",
            "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "29.10"),
        News("Тестовая статья", "Разработчики из польской студии CD Projekt RED в Твиттере вновь сообщили неприятную новость — релиз Cyberpunk 2077 отложен на 21 день.",
            "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "29.10"),
        News("Тестовая статья", "Разработчики из польской студии CD Projekt RED в Твиттере вновь сообщили неприятную новость — релиз Cyberpunk 2077 отложен на 21 день.",
            "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "30.10"),
        News("Тестовая статья", "Разработчики из польской студии CD Projekt RED в Твиттере вновь сообщили неприятную новость — релиз Cyberpunk 2077 отложен на 21 день.",
            "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "30.10"),
        News("Тестовая статья", "Разработчики из польской студии CD Projekt RED в Твиттере вновь сообщили неприятную новость — релиз Cyberpunk 2077 отложен на 21 день.",
            "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "31.10")];
    });
  }

  buildNewsList() {
    if (newsList.length == 0) {
      return Center(
        child: Text("Новостей пока нет.", style: TextStyle(fontSize: 18)),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: newsList.length + 1,
        itemBuilder: (context, index) {
          if (index == newsList.length)
            return Container(height: 20,);
          else
            return buildNewsCard(newsList[index], index);
        },
      );
    }
  }

  _buildBlockAnimated()
  {
    var size = MediaQuery.of(context).size;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
      //width: size.width * (choosenPodSqreenOff),
      bottom: 0,
      right: 0,//-size.width * (choosenPodSqreenOff),
      child: Expanded(child:buildNewsList(),),
    );
  }

  buildContent() {
   /* return
      // padding: EdgeInsets.only(left: 20,right: 20, bottom: 0),
      Column(
          children: [
            _buildTopChoosePanelAnimated(),
            _buildBlockAnimated(),
          ]);*/

    if (choosenPodScreen == 0)
      return
        // padding: EdgeInsets.only(left: 20,right: 20, bottom: 0),
        Column(
          children: [
            _buildTopChoosePanelAnimated(),
            Expanded(child:buildNewsList(),)
            //  (choosenPodScreen == 0? :TestEndScreen(withTab:false))

          ],

      );
    else
      return Column(
        children: [
          _buildTopChoosePanelAnimated(),
          TestEndScreen(withTab:false),
        ],
      );
  }

  buildPage() {
    return buildContent();
  }

  double choosenPodAnimSize = 0.5;
  double choosenPodSqreenOff = 0;
  setChoosen(int i)
  {
    setState(() {
      choosenPodScreen=i;
      choosenPodAnim = 0;
      choosenPodAnimSize = 1;
      i == 1 ? choosenPodSqreenOff = 1 : choosenPodSqreenOff = 0;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        choosenPodAnimSize = 0.5;
        if (i == 0)
        {
          choosenPodAnim = 0;
        }
        else
        {
          choosenPodAnim = 0.5;
        }
      });
    });
  }

  int choosenPodScreen = 0;
  double choosenPodAnim = 0;
  _buildTopChoosePanel()
  {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 40,
      color: StyleColor.materialColor,
      child:Row(
        children: [
         GestureDetector(
           onTap: () => setChoosen(0),
           child: Container(
             width: size.width*0.5,
             height: 40,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(25)), //here
               color: choosenPodScreen == 0?StyleColor.importantColor:StyleColor.materialColor,
             ),
         //    color: choosenPodScreen == 0?StyleColor.importantColor:StyleColor.materialColor,
             child: Center(
               child: AutoSizeText(
                 "Новости",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   // fontFamily: 'Regular',
                   fontWeight: FontWeight.w600,
                   fontSize: 18,
                   color: choosenPodScreen == 0?Colors.white:Colors.black,
                 ),
               ),
             ),
           ),
         ),
          GestureDetector(
            onTap: () => setChoosen(1) ,
            child: Container(
              width: size.width*0.5,
              height: 40,
              color: choosenPodScreen == 1?StyleColor.importantColor:StyleColor.materialColor,
              child: Center(
                child: AutoSizeText(
                  "Рекомендации",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontFamily: 'Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: choosenPodScreen == 1 ? Colors.white:Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  _buildTopChoosePanelAnimated()
  {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 40,
      color: Colors.transparent,
      child:Stack(
        children: [
          Container(
              width: size.width,
              height: 40,
              color: StyleColor.materialColor),
          Container(
           //   duration: const Duration(milliseconds: 500),
          //    curve: Curves.linear,
              //    onEnd: () =>onEnd (indexinn),
          //    bottom: 0,
           //   right: size.width * choosenPodAnim*0.5,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad,
                  width: size.width * (choosenPodAnimSize),
                  margin: EdgeInsets.only(left: size.width * (choosenPodAnim)),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)), //here
                    color: StyleColor.importantColor,
                  ))),
          Row(
            children: [
              GestureDetector(
                onTap: () => setChoosen(0),
                child: Container(
                    width: size.width*0.5,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)), //here
                      color: Colors.transparent,//choosenPodScreen == 0?StyleColor.importantColor:StyleColor.materialColor,
                    ),
                    //    color: choosenPodScreen == 0?StyleColor.importantColor:StyleColor.materialColor,
                    child: Center(
                      child: AutoSizeText(
                        "Новости",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: 'Regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: choosenPodScreen == 0?Colors.white:Colors.black,
                        ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setChoosen(1) ,
                child: Container(
                  width: size.width*0.5,
                  height: 40,
                  color:  Colors.transparent,// choosenPodScreen == 1?StyleColor.importantColor:StyleColor.materialColor,
                  child: Center(
                    child: AutoSizeText(
                      "Рекомендации",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // fontFamily: 'Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color:choosenPodScreen == 1 ? Colors.white:Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getNews();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(choosenPodScreen == 0?"Новости":"Рекомендации"),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: buildPage());
      //  body: (choosenPodScreen == 0? buildPage():TestEndScreen(withTab:false)));
  }
}
