import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Screens/LoginScreen.dart';
import 'package:talants/Screens/NewsListScreen.dart';
import 'package:talants/Screens/ProfileScreen.dart';
import 'package:talants/Screens/TestListScreen.dart';
import 'package:talants/Screens/settings_screen.dart';
import 'package:talants/icons_master_icons.dart';
import 'package:talants/Screens/select_dialog_screen.dart';
import 'package:talants/Screens/TestSlideScreen.dart';
import 'package:talants/Screens/TestScreen.dart';
import 'package:talants/styles.dart';

//import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:talants/NavigationBarCustom/curved_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  int ScreenNumb = 0;
  BottomNavigation({this.ScreenNumb = 0});
 // BottomNavigation({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  _BottomNavigationState() {}

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MainStyle.primaryColor, // status bar color
    ));
    setState(() {
      inerIndex = widget.ScreenNumb;
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


  buildPage() =>
      Stack(
        children: [],
      );

  chooseList(int index)
  {

    switch(index){
      case 0:
        return NewsListScreen();
        break;
      case 1:
        return TestListScreen();
        break;
      case 2:
        return SelectDialogScreen();
        break;
      case 3:
        return SettingsScreen(LoginScreen.cubeUser);
        break;
      default:
        Container();
    }
  }

  int inerIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconsMaster.newspaper, size: 30),
              title: Text('Personal')
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsMaster.test, size: 30),
              title: Text('Personal')
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsMaster.chat, size: 30),
              title: Text('Personal')
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsMaster.user_1, size: 30),
              title: Text('Personal')
          ),
        ],
        currentIndex: inerIndex,
        selectedItemColor: MainStyle.primaryColor,
        onTap: (index){
          setState(() {
            inerIndex=index;
          });
        },
      ),
      body: chooseList(inerIndex),
    );
  }
}
