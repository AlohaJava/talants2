import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/Screens/OpenedNewsScreen.dart';
import 'package:talants/utils/configs.dart' as config;
import 'Screens/LoginScreen.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';

class CustomBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Routes {
  final routes = <String, WidgetBuilder> {
    '/Auth': (BuildContext context) => new LoginScreen(),
    OpenedNewsScreen.routeName:(context) => OpenedNewsScreen()
  };

  Routes () {
    init(
      config.APP_ID,
      config.AUTH_KEY,
      config.AUTH_SECRET,
    );
    CubeSettings.instance.isDebugEnabled = false;
    runApp(new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orange,
        cursorColor: Colors.orange,
        appBarTheme: AppBarTheme(
          elevation: 0, // This removes the shadow from all App Bars.
        ),
        textTheme: TextTheme(
          display2: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.orange,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
          subhead: TextStyle(fontFamily: 'NotoSans'),
          body1: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomBehavior(),
          child: child,
        );
      },
      title: 'Flutter Demo',
      routes: routes,
      home: LoginScreen(),
    ));
  }
}