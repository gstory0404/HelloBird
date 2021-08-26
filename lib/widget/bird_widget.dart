import 'package:flutter/material.dart';
import 'package:hellobird/config.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/21 5:26 下午
/// @Description: 小鸟

class BirdWidget extends StatefulWidget {
  final AnimationController animationController;
  const BirdWidget({Key? key,required this.animationController})
      : super(key: key);

  @override
  _BirdWidgetState createState() => _BirdWidgetState();
}

class _BirdWidgetState extends State<BirdWidget>
    {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, _) {
        if (widget.animationController.value <= 1 / 3) {
          return Image.asset(
            "assets/images/bird2_0.png",
            height: Config.birdWidth,
            width: Config.birdWidth,
            fit: BoxFit.fill,
          );
        } else if (widget.animationController.value <= 2 / 3) {
          return Image.asset(
            "assets/images/bird2_1.png",
            height: Config.birdWidth,
            width: Config.birdWidth,
            fit: BoxFit.fill,
          );
        } else {
          return Image.asset(
            "assets/images/bird2_2.png",
            height: Config.birdWidth,
            width: Config.birdWidth,
            fit: BoxFit.fill,
          );
        }
      },
    );
  }
}
