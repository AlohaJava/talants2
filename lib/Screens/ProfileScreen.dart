import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talants/MainStyle.dart';
import 'package:talants/Screens/LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState() {}

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

  getData() async {}
  var achivments = ["Совершил майданопереворот!", "Выучил все песни глада валакаса", "Подписан на А4"];

  buildAchivments(){
    List<Widget> achiv = [];
    achivments.forEach((element) {
      achiv.add(Text(element));
      achiv.add(Divider());
    });
    return achiv;
  }

  buildContent() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: size.width * 0.35,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8000.0),
                      child: Image.network(
                          "https://sun9-58.userapi.com/c850216/v850216049/2ebe8/crPuK0uCceE.jpg")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text("Илья Крутько", style: TextStyle(fontSize: 20))
              ),
              SizedBox(height: 20,),
              Center(
                  child: Text("Личные достижения:", style: TextStyle(fontSize: 18))
              ),
              SizedBox(height: 25,),
              Container(
                height: 300,
                child: ListView(
                  children: buildAchivments(),
                ),
              )
            ],
          )),
    );
  }

  buildPage() => Stack(
        children: [buildContent()],
      );

  getActions() {
    return [
      GestureDetector(
        onTap: (){ Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (r) => false);},
          child: Container(
            margin: EdgeInsets.only(right: 4),
              child: Icon(Icons.logout)
          )
      ),
    ]; // Settings Screen
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: getActions(),
          title: Text("Профиль"),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: buildPage());
  }
}
