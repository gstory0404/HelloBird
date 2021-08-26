import 'package:flutter/material.dart';
import 'package:hellobird/widget/pipeline_widget.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/21 5:37 下午
/// @Description: 地面

class GroundWidget extends StatefulWidget {
  final AnimationController animationController;

  const GroundWidget({Key? key,required this.animationController}) : super(key: key);

  @override
  _GroundWidgetState createState() => _GroundWidgetState();
}

class _GroundWidgetState extends State<GroundWidget> {


  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animation =
        Tween(begin: Offset.zero, end: Offset(-0.25, 0)).animate(widget.animationController);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideTransition(
        position: _animation,
        child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/land.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/land.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
