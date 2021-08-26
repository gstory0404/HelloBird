import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/24 12:26 下午
/// @Description: dart类作用描述 

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  ScoreWidgetState createState() => ScoreWidgetState();
}

class ScoreWidgetState extends State<ScoreWidget> {

  int _score = 0;

  void setScore(int score){
    setState(() {
      _score = score;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            "assets/images/medals_1.png",
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
          _scoreWidget(),
        ],
      ),
    );
  }

  Widget _scoreWidget(){
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: _numWidget(_score ~/ 100),
          ),
          Container(
            margin: EdgeInsets.only(left: 2),
            child: _numWidget(_score % 100 ~/ 10),
          ),
          Container(
            margin: EdgeInsets.only(left: 2),
            child: _numWidget(_score % 10),
          ),
        ],
      ),
    );
  }

  Widget _numWidget(int num){
    switch(num){
      case 1:
        return Image.asset(
          "assets/images/font_1.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 2:
        return Image.asset(
          "assets/images/font_2.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 3:
        return Image.asset(
          "assets/images/font_3.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 4:
        return Image.asset(
          "assets/images/font_4.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 5:
        return Image.asset(
          "assets/images/font_5.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 6:
        return Image.asset(
          "assets/images/font_6.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 7:
        return Image.asset(
          "assets/images/font_7.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 8:
        return Image.asset(
          "assets/images/font_8.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      case 9:
        return Image.asset(
          "assets/images/font_9.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
      default:
        return Image.asset(
          "assets/images/font_0.png",
          width: 16,
          height: 20,
          fit: BoxFit.fill,
        );
    }
  }


}
