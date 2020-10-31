import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Screens/TestListScreen.dart';
import 'package:talants/styles.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talants/utils.dart';

class TestScreen extends StatefulWidget {
  Test ActualTest;
  int IndexQuestion;
  Function(int index) ApplyCallback;

  TestScreen({
    this.ActualTest,
    this.IndexQuestion,
    this.ApplyCallback,
  });

  @override
  State<StatefulWidget> createState() => new _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  _TestScreenState() {}

  final TextStyle _titleStyle = TextStyle(
   // fontFamily: 'Regular',
    fontWeight: FontWeight.w300,
    fontSize: 22,
    color: Colors.black87,
  );

  final TextStyle _hintStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    color: Colors.black38,
  );

  final TextStyle _inputStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    color: Colors.black87,
  );

  final TextStyle _choosenStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    color: Colors.white,
  );

  void showKeyboard() {
    focusNode.requestFocus();
  }

  void dismissKeyboard() {
    focusNode.unfocus();
  }
  FocusNode focusNode;

  List<Test> testList = [];

  dynamic _question;

  List<bool> choosenMulti;
  List<double> choosenMultiSize;

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    focusNode = FocusNode();
    setState(() {
      widget.ActualTest = Test("Тест граматику", 4, [
        QuestionText("Как правильно писать слово?"),
        QuestionSingleChoose("Сколько слогов в слове дерево? Выберети вариант:", ["-1","Очень длинный тестовый вариант ......... ......","Просто текст","3"]),
        QuestionMultyChoose("Выберети несколько вариантов:", ["-1","0","1","3"]),
        QuestionText("Как правильно писать слово?"),
      ]);
      _question =  widget.ActualTest.questionsList[widget.IndexQuestion];

    });

    if (_question.runtimeType == QuestionSingleChoose) {
      choosenMulti = new List<bool>();
      choosenMultiSize = new List<double>();
      for (var v in (_question as QuestionSingleChoose).questionVariants) {
        choosenMulti.add(false);
        choosenMultiSize.add(0);
      }

    }

    if (_question.runtimeType == QuestionMultyChoose)
    {
      choosenMulti = new List<bool>();
      choosenMultiSize = new List<double>();
      for (var v in (_question as QuestionMultyChoose).questionVariants) {
        choosenMulti.add(false);
        choosenMultiSize.add(0);
      }
    }
  }

  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // getTests();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: backArrow(context, 1),
          title: Text((widget.IndexQuestion + 1).toString() + "/" + widget.ActualTest.questionsList.length.toString()),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: buildContent());
  }

  buildContent() {
    var size = MediaQuery.of(context).size;
    return Container(
          decoration: BoxDecoration(
        //    borderRadius: BorderRadius.all(Radius.circular(15)), //here
            color: Colors.white,
               boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15, offset: Offset(-3,3))]
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
          child:_buildMainBlock()
    );
  }

  Widget _buildMainBlock()
  {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(height: size.height*0.03,),
            _buildQuestion(),
            Container(height: size.height*0.03,),
            getQuestionTypeBox(),
          ],
        ),
        _buildButtonApply(),
      ],
    );
  }


  Widget getQuestionTypeBox()
  {
    switch(_question.runtimeType)
    {
      case QuestionText:
        return TextRequestInput();
      case QuestionSingleChoose:
        return _buildVariants();//(_question as QuestionSingleChoose).questionText;
      case QuestionMultyChoose:
        return _buildVariantsMulti();//(_question as QuestionMultyChoose).questionText;
    }
    return Container();
  }


  String getQuestionText()
  {
    switch(_question.runtimeType)
    {
      case QuestionText:
        return (_question as QuestionText).questionText;
      case QuestionSingleChoose:
        return (_question as QuestionSingleChoose).questionText;
      case QuestionMultyChoose:
        return (_question as QuestionMultyChoose).questionText;
    }
    return "";
  }

  Widget _buildQuestion() {
    return AutoSizeText(
      getQuestionText(),
      maxLines: 7,
      textAlign: TextAlign.center,
      style: new TextStyle(fontFamily: 'Montserrat', fontSize: 22, color: Colors.black, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildButtonApply()
  {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(30),
      child: FlatButton(
        height: 50,
        minWidth: 190,
        child: Text('Дальше', style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
          fontSize: 22,
          color: Colors.white,
        )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
        onPressed: () { dismissKeyboard(); widget.ApplyCallback(widget.IndexQuestion); },
        splashColor: Colors.white,
        color: StyleColor.importantColor,//Colors.green,
      ),
    );
  }

 /* Widget _buildButtonApply2()
  {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(30),
      child: FlatButton(
        height: 90,
        minWidth: 90,
        child: Container(
          height: 60,
          width: 60,
          child: SvgPicture.asset(AppIcons.ArrForvard, color: Colors.white,),
        ),
        /*Text('Дальше', style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
          fontSize: 26,
          color: Colors.white,
        )),*/
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
        onPressed: (){},//widget.ApplyCallback(widget.IndexQuestion),
        splashColor: Colors.white,
        color: Colors.green,
      ),
    );
  }*/

  String RequestText;
  TextEditingController RequestTextController = TextEditingController(text: "");

  Widget TextRequestInput() {
    var size = MediaQuery.of(context).size;
    return  Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        width: size.width*0.9,
        height: size.height * 0.3,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)), //here
          //    color: Colors.white,
          //   boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(3,3), blurRadius: 15, spreadRadius: -15.0,)],
          //  border: Border.all(color: Colors.black54, width: 1, )
        ),
        child: AutoSizeTextField(
            focusNode: focusNode,
            textAlign: TextAlign.left,
            controller: RequestTextController,
            // inputFormatters: [maskFormatterDateEnd],
            cursorColor: StyleColor.materialColor,
            textInputAction: TextInputAction.next,
            maxLines: 15,
            textAlignVertical: TextAlignVertical.bottom,
            //    onChanged: (String s) => timeController(s, index),
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            style: _inputStyle,
            decoration: InputDecoration(
                hintText: "Введите ответ...",
                filled: true,
                //     contentPadding: EdgeInsets.only(bottom: size.height * 0.065 / 2*0.5,  // HERE THE IMPORTANT PART),
                fillColor: Colors.white,
                hintStyle: _hintStyle,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)), //here
                    borderSide: BorderSide(
                      color: Colors.black12,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)), //here
                    borderSide: BorderSide(
                      color: Colors.black12,
                    )))));
  }

  int choosenVar = -1;
  double animatedFloat = 0;
  onChooseSingle(int indexinn)
  {
    setState(() {
      choosenVar = indexinn;
    //  choosenMulti[indexinn] = !choosenMulti[indexinn];
      choosenMultiSize[indexinn] = choosenMultiSize[indexinn] > 0.9?0:1;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        choosenMultiSize[indexinn] = choosenMultiSize[indexinn] > 0.9?0:1;
      });
    });
  }

  Widget _buildVariants() {
    var _questionSV = _question as QuestionSingleChoose;
    List<Widget> list = List<Widget>();
    for (int i = 0; i < _questionSV.questionVariants.length; i++) {
      list.add(_buildVariant(context, _questionSV, i));
    }
    return Column(
      children: list,
    );
  }

  Widget _buildVariant(BuildContext context, QuestionSingleChoose quest, int indexinn) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onChooseSingle(indexinn),
      child: AnimatedContainer(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.all(10 + 8 * choosenMultiSize[indexinn]),// (choosenMulti[indexinn] ? choosenMultiSize[indexinn]:0.0)),
          width: size.width*0.85 + 8 * choosenMultiSize[indexinn],//
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          //height: size.height * 0.3,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)), //here
            color: (indexinn == choosenVar) ? StyleColor.importantColor : Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3,3), blurRadius: 5)],
            //  border: Border.all(color: Colors.black54, width: 1)
          ),
          child: AutoSizeText(
              quest.questionVariants[indexinn],
              textAlign: TextAlign.left,
              maxLines: 4,
              style: (indexinn != choosenVar) ? _inputStyle : _choosenStyle
          )),
    );
  }

  onChooseMulti(int indexinn)
  {
    setState(() {
      choosenMulti[indexinn] = !choosenMulti[indexinn];
      choosenMultiSize[indexinn] = choosenMultiSize[indexinn] > 0.9?0:1;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        choosenMultiSize[indexinn] = choosenMultiSize[indexinn] > 0.9?0:1;
      });
    });
  }


  Widget _buildVariantsMulti() {
    var _questionSV = _question as QuestionMultyChoose;
    List<Widget> list = List<Widget>();
    for (int i = 0; i < _questionSV.questionVariants.length; i++) {
      list.add(_buildVariantMulti(context, _questionSV, i));
    }
    return Column(
      children: list,
    );
  }

  Widget _buildVariantMulti(BuildContext context, QuestionMultyChoose quest, int indexinn) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onChooseMulti(indexinn),
      child: AnimatedContainer(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.all(10 + 8 * choosenMultiSize[indexinn]),// (choosenMulti[indexinn] ? choosenMultiSize[indexinn]:0.0)),
          width: size.width*0.85 + 8 * choosenMultiSize[indexinn],//
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          //height: size.height * 0.3,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)), //here
            color:  choosenMulti[indexinn] ? StyleColor.importantColor : Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3,3), blurRadius: 5)],
            //  border: Border.all(color: Colors.black54, width: 1)
          ),
          child: AutoSizeText(
              quest.questionVariants[indexinn],
              textAlign: TextAlign.left,
              maxLines: 4,
              style: !choosenMulti[indexinn] ? _inputStyle : _choosenStyle
          )),
    );
  }
}
