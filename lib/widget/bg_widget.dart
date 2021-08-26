import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/21 6:30 下午
/// @Description: 背景

class BgWidget extends StatefulWidget {
  const BgWidget({Key? key}) : super(key: key);

  @override
  _BgWidgetState createState() => _BgWidgetState();
}

class _BgWidgetState extends State<BgWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/images/bg_day.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
    );
  }
}

