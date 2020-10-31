import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talants/MainStyle.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../OpenedNewsData.dart';

class OpenedNewsScreen extends StatefulWidget {
  OpenedNewsScreen({Key key}) : super(key: key);
  static const routeName = '/openNews';

  @override
  State<StatefulWidget> createState() => new _OpenedNewsScreenState();
}

class _OpenedNewsScreenState extends State<OpenedNewsScreen> {
  _OpenedNewsScreenState() {}

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
    OpenedNewsData url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(url.title),
          backgroundColor: MainStyle.primaryColor,
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: url.url,
        ));
  }
}
