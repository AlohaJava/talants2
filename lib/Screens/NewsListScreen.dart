import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/OpenedNewsData.dart';
import 'package:talants/Screens/OpenedNewsScreen.dart';

class News {
  String title;
  String imageUrl;
  String newsUrl;
  String newsData;

  News(this.title, this.imageUrl, this.newsUrl, this.newsData);
}

class NewsListScreen extends StatefulWidget {
  NewsListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _NewsListScreen();
}

class _NewsListScreen extends State<NewsListScreen> {
  _NewsListScreen() {}

  final TextStyle _titleStyle = TextStyle(
    fontSize: 26,
    color: Colors.black87,
    fontWeight: FontWeight.w300
  );

  final TextStyle _dataStyle = TextStyle(
    fontFamily: 'Regular',
    fontSize: 16,
    color: Colors.grey,
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

  buildNewsCard(News item) {
    print(item.imageUrl);
    return GestureDetector(
      onTap: (){
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
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container( width:50, height: 50,child: CircularProgressIndicator()),
                  imageUrl: item.imageUrl,
                ),
              ),
              SizedBox(height: 5,),
              Align(alignment: Alignment.topLeft,

                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.title,
                        style: _titleStyle,

                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          item.newsData,
                          style: _dataStyle,
                        ),
                      )
                    ],
                  )


              )
            ],
          ),
        ),
    );
  }

  getNews() async{
    print("Getting news!");
    setState(() {
      newsList = [
        News("Тестовая статья", "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "29.10.20"),
        News("Тестовая статья", "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "29.10.20"),
        News("Тестовая статья", "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "30.10.20"),
        News("Тестовая статья", "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "30.10.20"),
        News("Тестовая статья", "https://buddy.works/blog/thumbnails/flutter/flutter-cover.png", "https://ya.ru", "31.10.20")];
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
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return buildNewsCard(newsList[index]);
        },
      );
    }
  }

  buildContent() {
    var size = MediaQuery.of(context).size;
    return Container(
     // padding: EdgeInsets.only(left: 20,right: 20, bottom: 0),
      child:Expanded(
        child:buildNewsList(),),

    );
  }

  buildPage() => Stack(
        children: [buildContent()],
      );

  @override
  Widget build(BuildContext context) {
    getNews();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Новости"),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: buildPage());
  }
}
