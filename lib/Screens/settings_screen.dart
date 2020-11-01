import 'dart:io';

import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/utils/api_utils.dart';
import 'package:talants/utils/consts.dart';
import 'package:talants/widgets/common.dart';

class SettingsScreen extends StatelessWidget {
  final CubeUser currentUser;

  SettingsScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainStyle.primaryColor,
          title: Text(
            'Личный кабинет',
           //style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BodyLayout(currentUser),
        resizeToAvoidBottomInset: false);
  }
}

class BodyLayout extends StatefulWidget {
  final CubeUser currentUser;

  BodyLayout(this.currentUser);

  @override
  State<StatefulWidget> createState() {
    return _BodyLayoutState(currentUser);
  }
}

class _BodyLayoutState extends State<BodyLayout> {
  static const String TAG = "_BodyLayoutState";

  final CubeUser currentUser;
  var _isUsersContinues = false;
  String _avatarUrl = "";
  final picker = ImagePicker();
  final TextEditingController _loginFilter = new TextEditingController();
  final TextEditingController _nameFilter = new TextEditingController();
  String _login = "";
  String _name = "";

  _BodyLayoutState(this.currentUser) {
    _loginFilter.addListener(_loginListen);
    _nameFilter.addListener(_nameListen);
    _nameFilter.text = currentUser.fullName;
    _loginFilter.text = currentUser.login;
  }

  _searchUser(value) {
    log("searchUser _user= $value");
    if (value != null)
      setState(() {
        _isUsersContinues = true;
      });
  }

  void _loginListen() {
    if (_loginFilter.text.isEmpty) {
      _login = "";
    } else {
      _login = _loginFilter.text.trim();
    }
  }

  void _nameListen() {
    if (_nameFilter.text.isEmpty) {
      _name = "";
    } else {
      _name = _nameFilter.text.trim();
    }
  }

  buildCard(String text, String subText, String imgUrl) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0), bottom: Radius.circular(25.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 2.0), //(x,y)
              blurRadius: 5,
            )
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 9, right: 9, top: 12, bottom: 12),
        child: Row(
          children: [
            Stack(children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(41.0),
                        bottom: Radius.circular(41.0)),
                    color: MainStyle.primaryColor,
                  )),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      imgUrl,
                      width: 24,
                      height: 24,
                    )
                ),
              ),
            ]),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                Text(subText, style: TextStyle(fontSize: 16))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                color: MainStyle.primaryColor,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentUser.fullName,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    Container(
                        width: 50, height: 50, child: _buildAvatarFields()),
                  ],
                ),
              ),
              Container(
                color: MainStyle.primaryColor,
                width: double.infinity,
                height: 600,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 10),
                    child: DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: TabBar(
                          indicatorColor: MainStyle.primaryColor,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: "Профиль",
                            ),
                            Tab(
                              text: "Настройки",
                            ),
                            Tab(
                              text: "Инфо",
                            ),
                          ],
                        ),
                        body: TabBarView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildCard(
                                      "Рекоммендуемая профессия",
                                      "Программист",
                                      "assets/images/informatics.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Загрузить достижения",
                                      "Здесь вы можете загрузить свои\nсертификаты",
                                      "assets/images/diploma.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Бонусы и акции",
                                      "Информация о текущих акциях",
                                      "assets/images/bonus.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Куда поступить",
                                      "Список учебных заведений",
                                      "assets/images/ucheba.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Правила приема",
                                      "Узнать за что дают баллы",
                                      "assets/images/priem.png"),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildCard(
                                      "Уведомления",
                                      "Управление пуш-уведомлениями",
                                      "assets/images/ring.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Аккаунт",
                                      "Сменить логин и пароль",
                                      "assets/images/settings.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Выйти",
                                      "Выйти из аккаунта",
                                      "assets/images/logout.png"),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildCard(
                                      "Помощь",
                                      "Ответы на часто задаваемые\nвопросы",
                                      "assets/images/bubbles.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "Обратная связь",
                                      "Связь с разработчиками",
                                      "assets/images/feedback.png"),
                                  SizedBox(height: 14,),
                                  buildCard(
                                      "О приложении",
                                      "Версия 0.1 beta 2",
                                      "assets/images/ask.png"),
                                  SizedBox(height: 14,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarFields() {
    Widget avatarCircle = CircleAvatar(
      backgroundImage:
          currentUser.avatar != null && currentUser.avatar.isNotEmpty
              ? NetworkImage(currentUser.avatar)
              : null,
      backgroundColor: greyColor2,
      radius: 50,
      child: getAvatarTextWidget(
        currentUser.avatar != null && currentUser.avatar.isNotEmpty,
        currentUser.fullName.substring(0, 2).toUpperCase(),
      ),
    );

    return new Stack(
      children: <Widget>[
        InkWell(
          splashColor: greyColor2,
          borderRadius: BorderRadius.circular(45),
          onTap: () => _chooseUserImage(),
          child: avatarCircle,
        ),
        new Positioned(
          child: RawMaterialButton(
            onPressed: () {
              _chooseUserImage();
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              Icons.mode_edit,
              size: 20.0,
            ),
            padding: EdgeInsets.all(5.0),
            shape: CircleBorder(),
          ),
          top: 55.0,
          right: 35.0,
        ),
      ],
    );
  }

  _chooseUserImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    var image = File(pickedFile.path);
    uploadFile(image, true).then((cubeFile) {
      _avatarUrl = cubeFile.getPublicUrl();
      setState(() {
        currentUser.avatar = _avatarUrl;
      });
    }).catchError(_processUpdateUserError);
  }

  Widget _buildTextFields() {
    return Container();
  }

  Widget _buildButtons() {
    return new Container();
  }

  void _updateUser() {
    print('_updateUser user with $_login and $_name');
    if (_login.isEmpty && _name.isEmpty && _avatarUrl.isEmpty) {
      Fluttertoast.showToast(msg: 'Nothing to save');
      return;
    }
    var userToUpdate = CubeUser()..id = currentUser.id;

    if (_name.isNotEmpty) userToUpdate.fullName = _name;
    if (_login.isNotEmpty) userToUpdate.login = _login;
    if (_avatarUrl.isNotEmpty) userToUpdate.avatar = _avatarUrl;
    setState(() {
      _isUsersContinues = true;
    });
    updateUser(userToUpdate).then((user) {
      Fluttertoast.showToast(msg: 'Success');
      setState(() {
        _isUsersContinues = false;
      });
    }).catchError(_processUpdateUserError);
  }

  void _logout() {
    print('_logout $_login and $_name');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want logout current user"),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                signOut().then(
                  (voidValue) {
                    CubeChatConnection.instance.destroy();
                    Navigator.pop(context); // cancel current Dialog
                    Navigator.pop(context); // cancel current screen
                    _navigateToLoginScreen(context);
                  },
                ).catchError(
                  (onError) {
                    Navigator.pop(context); // cancel current Dialog
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  _navigateToLoginScreen(BuildContext context) {
    Navigator.pop(context, true);
  }

  void _processUpdateUserError(exception) {
    log("_processUpdateUserError error $exception", TAG);
    setState(() {
      _isUsersContinues = false;
    });
    showDialogError(exception, context);
  }
}
