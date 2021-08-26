import 'package:flutter/services.dart';
import 'package:hellobird/home_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);//隐藏状态栏，底部按钮栏
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelloBird',
      // showPerformanceOverlay: true, // 开启FPS监控
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Index(),
    );
  }
}

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
