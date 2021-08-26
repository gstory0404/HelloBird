import 'package:flutter/material.dart';
import 'package:hellobird/game_status.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/24 11:11 上午
/// @Description: dart类作用描述

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  MenuWidgetState createState() => MenuWidgetState();
}

class MenuWidgetState extends State<MenuWidget> {

  int _gameStatus = GameStatus.START;

  void show(int gameStatus){
    setState(() {
      this._gameStatus = gameStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
         // 开始
          Visibility(
            visible: _gameStatus == GameStatus.START,
            child:Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/title.png",
                    width: 220,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Image.asset(
                      "assets/images/text_ready.png",
                      width: 170,
                      height: 55,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Image.asset(
                    "assets/images/tutorial.png",
                    width: 200,
                    height: 140,
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
          ),
          //结束
          Visibility(
            visible: _gameStatus == GameStatus.END,
            child: Image.asset(
              "assets/images/text_game_over.png",
              width: 170,
              height: 55,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
