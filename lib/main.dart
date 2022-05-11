import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/pages/Tabs.dart';
import 'package:flutter_jd/utils/extensions.dart';

import 'router/index.dart';

main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: "#f7f7f7".toColor);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0),
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor:Color("##282c34".toColor)
      // systemNavigationBarColor: Colors.red
    );
    return MaterialApp(
      title: 'Flutter Demo',
      home: Tabs(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(systemOverlayStyle: systemUiOverlayStyle)),
    );
  }
}
