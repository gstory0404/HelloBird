import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hellobird/bean/pipeline_bean.dart';
import 'package:hellobird/config.dart';
import 'package:hellobird/game_status.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/21 6:29 下午
/// @Description: 管道

class PipelineWidget extends StatefulWidget {
  final AnimationController animationController;
  final Function callback;

  const PipelineWidget(
      {Key? key, required this.animationController, required this.callback})
      : super(key: key);

  @override
  PipelineWidgetState createState() => PipelineWidgetState();
}

class PipelineWidgetState extends State<PipelineWidget> {
  ScrollController _controller = ScrollController(keepScrollOffset: true);

  //移动距离
  double _scrollWidth = 0;

  //是否开始
  int _gameStatus = GameStatus.START;

  @override
  void initState() {
    super.initState();
    widget.animationController.addListener(() {
      if (_gameStatus == GameStatus.DOING) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scrollWidth++;
          _controller.jumpTo(
            _scrollWidth * Config.speed,
          );
        });
      }
    });
    _controller.addListener(() {
      checkPipe();
    });
  }

  //计算管道是否正在通过管道
  void checkPipe() {
    if ((_scrollWidth * Config.speed) >
        (MediaQuery.of(context).size.width / 2)) {
      //滚动距离
      double scroll =
          (_scrollWidth * Config.speed) - MediaQuery.of(context).size.width / 2;
      //是否正在通过管道
      if ((scroll % (Config.pipelineWidth + Config.pipelineSpacingW)) >
          (Config.pipelineSpacingW - Config.birdWidth / 2)) {
        int index =
            scroll ~/ (Config.pipelineWidth + Config.pipelineSpacingW) + 1;
        widget.callback(_getHeight(index), Config.pipelineSpacingH);
      }
    }
  }

  //获取顶部管道高度
  double _getHeight(int index) {
    double height =
        MediaQuery.of(context).size.height / 2 + (index % 2 == 0 ? 30 : -30);
    return height;
  }

  //开始管道移动
  void start(int gameStatus) {
    _scrollWidth = 0;
    _controller.jumpTo(0);
    _gameStatus = gameStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      child: Row(
        children: List.generate(
          200,
          (index) {
            if (index == 0) {
              return SizedBox(width: MediaQuery.of(context).size.width);
            } else {
              return Container(
                width: Config.pipelineWidth,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: Config.pipelineSpacingW),
                child: Column(
                  children: [
                    SizedBox(
                      height: _getHeight(index),
                      child: Image.asset(
                        "assets/images/pipe_down.png",
                        width: Config.pipelineWidth,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: Config.pipelineSpacingH),
                    Expanded(
                      child: Image.asset(
                        "assets/images/pipe_up.png",
                        width: Config.pipelineWidth,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
