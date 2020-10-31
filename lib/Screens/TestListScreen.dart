import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/Screens/TestSlideScreen.dart';

class QuestionText {
  String questionText;
  QuestionText(this.questionText);
}

class QuestionSingleChoose {
  String questionText;
  List<String> questionVariants;
  int choosen;
  QuestionSingleChoose(this.questionText, this.questionVariants);
}

class QuestionMultyChoose {
  String questionText;
  List<String> questionVariants;
  List<bool> choosenList;

  QuestionMultyChoose(this.questionText, this.questionVariants);
}


class Test {
  String title;
  int hardness;
  int points;
  int status = 0;
  List<dynamic> questionsList;

  Test(this.title, this.hardness, this.questionsList, [this.points = -1]);
}

class TestListScreen extends StatefulWidget {
  TestListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _TestListScreenState();
}

class _TestListScreenState extends State<TestListScreen> {
  _TestListScreenState() {}

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

  List<Test> testList = [];

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

  @override
  Widget build(BuildContext context) {
    getTests();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Тесты"),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: buildPage());
  }

  buildPage() => Stack(
    children: [buildContent()],
  );

  buildContent() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child:_buildMainList()
      ),
    );
  }

  getTests() async{
    setState(() {
      testList = [
        Test("Тест граматику", 4, [
          QuestionText("Как правильно писать слово?"),
          QuestionSingleChoose("Сколько слогов в слове дерево? Выберети вариант:", ["-1","0","1","3"]),
          QuestionMultyChoose("Выберети несколько вариантов:", ["-1","0","1","3"]),
          QuestionText("Как правильно писать слово?"),
        ]),
        Test("Тест граматику", 4, [
          QuestionText("Как правильно писать слово?"),
          QuestionSingleChoose("Сколько слогов в слове дерево? Выберети вариант:", ["-1","0","1","3"]),
          QuestionMultyChoose("Выберети несколько вариантов:", ["-1","0","1","3"]),
          QuestionText("Как правильно писать слово?"),
        ]),
        Test("Тест граматику", 6, [
          QuestionText("Как правильно писать слово?"),
          QuestionSingleChoose("Сколько слогов в слове дерево? Выберети вариант:", ["-1","0","1","3"]),
          QuestionMultyChoose("Выберети несколько вариантов:", ["-1","0","1","3"]),
          QuestionText("Как правильно писать слово?"),
          QuestionText("Как правильно писать слово?")
        ], 1),
        Test("Тест граматику", 9, [
          QuestionText("Как правильно писать слово?"),
          QuestionSingleChoose("Сколько слогов в слове дерево? Выберети вариант:", ["-1","0","1","3"]),
          QuestionMultyChoose("Выберети несколько вариантов:", ["-1","0","1","3"]),
          QuestionText("Как правильно писать слово?"),
        ], 3),
        Test("Тест граматику", 9, [
          QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),
        ], 6),
        Test("Тест граматику", 9, [
          QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),QuestionText("Как?"),
        ], 4),
      ];

      testList[1].status = 1;
      testList[2].status = 2;
      testList[3].status = 2;
      testList[4].status = 2;
      testList[5].status = 2;

    });
  }

  Widget _buildMainList()
  {
    if (testList.length == 0) {
      return Center(
        child: Text("Тестов пока нет.", style: TextStyle(fontSize: 18)),
      );
    }

    List<Widget> list = List<Widget>();
    for (int i = 0; i < testList.length; i++) {
      list.add(_buildTestBoxStec(context, i));
    }
    var size = MediaQuery.of(context).size;
    return Column(
      children: list,
    );
  }

  Widget _buildTestNumberQuest(int index)
  {
    if (testList[index].status == 0)
      return AutoSizeText.rich(
        // textAlign: TextAlign.left,
        new TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w400),
          children: <TextSpan>[
            new TextSpan(text: "Число вопросов: "),
            new TextSpan(text: testList[index].questionsList.length.toString(), style: new TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
          ],
        ),
        maxLines: 1,
      );
    if (testList[index].status == 1)
      return AutoSizeText.rich(
        // textAlign: TextAlign.left,
        new TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black54.withAlpha((testList[index].status != 0)?128:255), fontWeight: FontWeight.w400),
          children: <TextSpan>[
            new TextSpan(text: "Число вопросов: "),
            new TextSpan(text: testList[index].questionsList.length.toString(), style: new TextStyle(color: Colors.black87.withAlpha((testList[index].status != 0)?128:255), fontWeight: FontWeight.w600)),
          ],
        ),
        maxLines: 1,
      );
    if (testList[index].status == 2)
      return AutoSizeText.rich(
        // textAlign: TextAlign.left,
        new TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w400),
          children: <TextSpan>[
            new TextSpan(text: "Правильных ответов: "),
            new TextSpan(text: testList[index].points.toString() + "/" +  testList[index].questionsList.length.toString()
                , style: new TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
          ],
        ),
        maxLines: 1,
      );
    return Container();
  }

  Widget _buildTestStatus(int index)
  {
    if (testList[index].status == 1)
      return AutoSizeText(
        "На проверке", style: new TextStyle(fontSize: 18, color: Colors.orangeAccent, fontWeight: FontWeight.w400),
        maxLines: 1,
      );
    if (testList[index].status == 2)
      return AutoSizeText(
        "Выполненно", style: new TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w400),
        maxLines: 1,
      );
    return Container();
  }

  Widget _buildTestBoxStec(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    Color applyColorC = ChooseColor(((testList[index].questionsList.length - testList[index].points)/testList[index].questionsList.length*10).toInt());
    applyColorC = applyColorC.withAlpha(120);
    int hardnesK = (((testList[index].points)/testList[index].questionsList.length*10).round());
    return GestureDetector(
      onTap: () => { testList[index].status == 0 ? Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: TestSlideScreen()) ) : 0},
      child: Container(
        width: size.width,
        height: 95,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)), //here
              color: testList[index].status==0 ? Colors.white : testList[index].status==1?Colors.black12.withAlpha(12): Colors.black12.withAlpha(12),
             boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2,2), blurRadius: 5 )],
          //  border: Border.all(color: Colors.black54, width: 1, )
        ),
        child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: testList[index].points>=0?size.width * testList[index].points / testList[index].questionsList.length:0,
                      height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)), //here
                          color: applyColorC,
                       //   boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3, offset: Offset(0,3))]
                      )
                  )
              ),
              Container(
                height: 95,
                width: size.width*1,
                color: testList[index].points>=0 ? Colors.transparent : Colors.transparent,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 30,
                              child: AutoSizeText(
                                testList[index].title,
                                style: TextStyle(
                                  // fontFamily: 'Regular',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  color: Colors.black87.withAlpha((testList[index].status != 0)?128:255),
                                ),
                                maxLines: 1,
                              ),
                            )),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: _buildTestStatus(index))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: _buildTestNumberQuest(index)),
                        Container(
                          height: 30,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText.rich(
                                new TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black54.withAlpha((testList[index].status != 0)?128:255), fontWeight: FontWeight.w300),
                                  children: <TextSpan>[
                                  new TextSpan(text: ""),
                               //     new TextSpan(text: "Сложность: "),
                               //     new TextSpan(text: testList[index].hardness.toString(), style: new TextStyle(
                                 //       fontSize: (18 + hardnesK).toDouble(),
                                     //   color: ChooseColor(testList[index].hardness), //Colors.black54,//
                                     //   shadows: [Shadow(blurRadius: 3, offset: Offset(1,1), color: Colors.black54)],
                              //          fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                maxLines: 1,
                              ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  Color ChooseColor(int index)
  {
    if (index > 10)
      return Colors.red;
    if (index < 1)
      return Colors.lightGreenAccent;
    switch(index)
    {
      case 1:
        return Colors.lightGreenAccent;
      case 2:
        return Colors.lightGreenAccent;
      case 3:
        return Colors.lightGreenAccent;
      case 4:
        return Colors.lime;
      case 5:
        return Colors.yellow;
      case 6:
        return Colors.yellowAccent;
      case 7:
        return Colors.orangeAccent;
      case 8:
        return Colors.orange;
      case 9:
        return Colors.deepOrange;
      case 10:
        return Colors.red;
    }

  }
}
