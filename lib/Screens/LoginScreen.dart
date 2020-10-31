import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Navigation/BottomNavigation.dart';
import 'package:talants/Screens/CreateRequestForRegScreen.dart';
import 'package:talants/Screens/Favorites.dart';
import 'package:talants/Screens/HelpScreen.dart';
import 'package:talants/utils/api_utils.dart';

import 'select_dialog_screen.dart';

class LoginScreen extends StatefulWidget {
  static CubeUser cubeUser;

  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  _LoginPageState() {}

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _emailFilter.text = "adm";
    _passwordFilter.text = "12345678";
  }

  void dispose() {
    _emailFilter.dispose();
    _passwordFilter.dispose();
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

  onLoginPressed(){
    _loginToCC(context, CubeUser(login: _emailFilter.text, password: _passwordFilter.text));
    //Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BottomNavigation()));
  }

  void _processLoginError(exception) {
    showDialogError("Неправильный логин или пароль", context);
  }

  _loginToCC(BuildContext context, CubeUser user, {bool saveUser = false}) {
    /*
    if (_isLoginContinues) return;
    setState(() {
      _isLoginContinues = true;
    });
    */

    createSession(user).then((cubeSession) async {
      var tempUser = user;
      user = cubeSession.user..password = tempUser.password;
      _loginToCubeChat(context, user);
    }).catchError(_processLoginError);
  }

  _loginToCubeChat(BuildContext context, CubeUser user) {
    print("_loginToCubeChat user $user");
    CubeChatConnection.instance.login(user).then((cubeUser) {
      print("LOGINED!");
      LoginScreen.cubeUser=cubeUser;
      print(cubeUser.email+"USEER");
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: FavoritesScreen()));
      //Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: BottomNavigation()));
      /*
       Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: "/SelectDialogScreen"),
          builder: (context) => SelectDialogScreen(),
        ),
      );
      */

    }).catchError(_processLoginError);
  }
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  buildContent() {
    var size = MediaQuery.of(context).size;
   // print("building");
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: size.width * 0.1,
          ),
          Image.asset(
            "assets/images/logo.png",
            width: size.width * 0.65,
            fit: BoxFit.contain,
          ),
          Container(
            height: size.width * 0.05,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/round1.png", width: size.width*0.47,),
                          Image.asset("assets/images/round2.png", width: size.width*0.08,),
                        ],
                      ),
                      SizedBox(height: size.width*0.28,),
                      Align(
                        alignment: Alignment.bottomLeft,
                          child: Image.asset("assets/images/round3.png", width: size.width*0.10,)
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                      top: size.height * 0.1,
                      bottom: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Вход",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white))),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          autofocus: false,
                          controller: _emailFilter,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left:20),
                            filled: true,
                            fillColor: MainStyle.inputBackgroundColor,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          autofocus: false,
                          controller: _passwordFilter,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left:20),
                            filled: true,
                            fillColor: MainStyle.inputBackgroundColor,
                            hintText: 'Пароль',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width:size.width * 0.45,
                              child: RoundedLoadingButton(
                                color: MainStyle.primaryColor,
                                child: Text('Войти', style: TextStyle(color: Colors.white, fontSize: 18)),
                                controller: _btnController,
                                onPressed: () {onLoginPressed();},
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                primaryFocus.unfocus();
                                Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: HelpScreen()));
                                },
                              child: Container(
                                  width: size.width * 0.28,
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 15, bottom: 15),
                                  child: AutoSizeText("Нужна помощь?", maxLines: 1,
                                      style: TextStyle(color: Colors.black, fontSize: 16))),
                            ),
                          ],
                        ),
                      ]),
                      GestureDetector(
                        onTap: () {
                          primaryFocus.unfocus();
                          Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: CreateRequestForRegScreen()));
                          },
                        child: Container(
                            width: size.width * 0.9,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Center(
                                child: Text("Отправить заявку на\nрегистрацию",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: MainStyle.primaryColor,
                                      fontSize: 16,
                                    )))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildPage() => Stack(
        children: [buildBackGround(), buildContent()],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: buildPage());
  }
}
