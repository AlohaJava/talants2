import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:talants/MainStyle.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  _HelpScreenState() {}

  var transl = {'#': new RegExp(r'\d')};

  var phoneFormater = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  var phoneController = new TextEditingController(text: "+7 (999) 999-99-99");

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

  buildBackGround() {
    return Container();
  }

  buildContent() {
    var size = MediaQuery.of(context).size;
    print("building");
    return Container(
        color: MainStyle.primaryColor,
        child: Container(
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
                children: [
                  Text(
                      "Задайте вопрос и наши специалисты ответят на него по указанному номеру.",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    inputFormatters: [phoneFormater],
                    controller: phoneController,
                    maxLengthEnforced: true,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Номер телефона',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    maxLines: 8,
                    minLines: 8,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20, top: 25),
                      hintText: 'Сообщение',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
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
          title: Text("Помощь"),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: buildPage());
  }
}
