import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/Screens/TestEndScreen.dart';
import 'package:talants/Screens/TestListScreen.dart';
import 'package:talants/styles.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talants/utils.dart';

class EventScreen extends StatefulWidget {
  Event ActualEvent;

  EventScreen({
    this.ActualEvent,
  });

  @override
  State<StatefulWidget> createState() => new _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
 {
  _EventScreenState() {}

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
   // getTests();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: backArrow(context, 1),
          title: Text(widget.ActualEvent.title), //AutoSizeText
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: buildContent());
  }



  buildContent() {
    var size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,

        padding: EdgeInsets.only(left: 20, right: 20),
        child:_buildMainBlock()
    );
  }

  Widget _buildMainBlock()
  {
    var size = MediaQuery.of(context).size;
    return
      Column(
        children: [
          Container(height: size.height*0.03,),
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
            //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),),
              child: Align(
                alignment: Alignment.center,
                widthFactor: 1,
                heightFactor: 0.5,
                child: Image.asset(widget.ActualEvent.image),
              ),
            ),
          ),
          Container(height: size.height*0.03,),
          _buildTitle(),
          Container(height: size.height*0.03,),
          _buildText(),
        ],

      );
  }



  Widget _buildTitle() {
    return Text(
      "   " + widget.ActualEvent.title,
      textAlign: TextAlign.center,
      style: new TextStyle(fontFamily: 'Montserrat', fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildText() {
    return Text(
      "     " + widget.ActualEvent.text,
      textAlign: TextAlign.justify,
      style: new TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
    );
  }


}
