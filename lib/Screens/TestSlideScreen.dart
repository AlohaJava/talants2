import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/Screens/TestListScreen.dart';
import 'package:talants/Screens/TestEndScreen.dart';
import 'package:talants/Screens/TestScreen.dart';
import 'package:talants/styles.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

class TestSlideScreen extends StatefulWidget {
  Test ActualTest = Test("Тест граматику", 4, [
    QuestionText("Как правильно писать слово?"),
    QuestionSingleChoose("Сколько слогов в слове дерево? \n Выберети вариант:", ["-1","0","1","3"]),
    QuestionMultyChoose("Выберети несколько вариантов:", ["-1","0","1","3","3"]),
    QuestionText("Как правильно писать слово?"),
  ]);
  TestSlideScreen({Key key}) : super(key: key);

 // TestSlideScreen({this.ActualTest,});

  @override
  State<StatefulWidget> createState() => new _TestSlideScreenState();
}

class _TestSlideScreenState extends State<TestSlideScreen>
    with SingleTickerProviderStateMixin {
  _TestSlideScreenState() {}

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
  List<double> multiSize;
  List<bool> multiEndAnim;
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

     multiSize = new List<double>();
     multiEndAnim = new List<bool>();
      for (var v in widget.ActualTest.questionsList) {
        multiSize.add(0);
        multiEndAnim.add(false);
      }

      setState(() {
        multiSize[0] = 1;
        multiEndAnim[0] = true;
      });
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
    return Scaffold(
        body: _buildMainList());
  }

  Widget _buildMainList()
  {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < widget.ActualTest.questionsList.length; i++) {
      list.add(_buildQuestScreenOne(context, i));
    }
    var size = MediaQuery.of(context).size;
    return //_buildQuestScreenOne(context, 0);
    Stack(
      children: list,
    );
  }

  int actualQuest = 0;
  double newListSize = 0;
  AplyCallBack(int index)
  {
   // currentFocus.unfocus();
    if (actualQuest == widget.ActualTest.questionsList.length - 1)
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: TestEndScreen()) );
    else
      setState(() {
        actualQuest = index + 1;
        //  multiSize[actualQuest - 1] = 0;
        multiSize[actualQuest] = 1;
        //   multiSize[index] = multiSize[index]>0.9?0:1;
      });
  }

  onEnd(int index)
  {
    setState(() {
      multiEndAnim[index] = true;
    });
  }
  Widget _buildQuestScreenOne(BuildContext context, int indexinn)
  {
   /* if (indexinn != actualQuest)
      return Container();
    return TestScreen(
      ActualTest: widget.ActualTest,
      IndexQuestion: indexinn,
      ApplyCallback: (int index) => AplyCallBack(index),
    );*/
   if (multiEndAnim[indexinn])
     return TestScreen(
       ActualTest: widget.ActualTest,
       IndexQuestion: indexinn,
       ApplyCallback: (int index) => AplyCallBack(index),
     );
    var size = MediaQuery.of(context).size;
      if (multiSize[indexinn] > 0.9)
        return AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            onEnd: () =>onEnd (indexinn),
            bottom: 0,
            right: -size.width * (1-multiSize[indexinn]),
            child: Container(
              width: size.width,
              height: size.height - 55*0,
              child: TestScreen(
                ActualTest: widget.ActualTest,
                IndexQuestion: indexinn,
                ApplyCallback: (int index) => AplyCallBack(index),
              ),
            )
      );
      else
        return AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            onEnd: () =>onEnd (indexinn),
            bottom: 0,
            right: -size.width * (1-multiSize[indexinn]),
            child: Container(
              child: TestScreen(
                ActualTest: widget.ActualTest,
                IndexQuestion: indexinn,
                ApplyCallback: (int index) => AplyCallBack(index),
              ),
            )
        );
  }
}
