import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:hellobird/bean/pipeline_bean.dart';
import 'package:hellobird/config.dart';
import 'package:hellobird/game_status.dart';
import 'package:hellobird/widget/bg_widget.dart';
import 'package:hellobird/widget/bird_widget.dart';
import 'package:hellobird/widget/ground_widget.dart';
import 'package:flutter/material.dart';
import 'package:hellobird/widget/menu_widget.dart';
import 'package:hellobird/widget/pipeline_widget.dart';
import 'package:hellobird/widget/score_widget.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/21 4:01 下午
/// @Description: dart类作用描述

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  //管道
  final _pipeKey = GlobalKey<PipelineWidgetState>();

  //菜单 局部刷新
  final _menuKey = GlobalKey<MenuWidgetState>();

  //分数
  final _scoreKey = GlobalKey<ScoreWidgetState>();

  //小鸟位置
  double birdHigh = 0;

  //是否点击
  int _gameStatus = GameStatus.START;

  bool _isClick = false;

  //分数
  int score = 0;

  //定时器
  Timer? _timer;

  //音乐
  AudioCache audioBgm =
      AudioCache(fixedPlayer: new AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  AudioCache audioClick = AudioCache();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animationController.addListener(
      () {
        if (_gameStatus == GameStatus.DOING) {
          if (_isClick) {
            birdHigh = birdHigh - Config.birdSpeed;
          } else {
            birdHigh = birdHigh + Config.birdSpeed;
          }
          if (birdHigh < 0 ||
              birdHigh >
                  MediaQuery.of(context).size.height * 9 / 10 -
                      Config.birdWidth) {
            _stopGame();
          }
        }
      },
    );
    //开始动画
    _animationController.repeat();
  }

  ///检查小鸟是否通过管道
  ///[height] 管道顶部高度
  ///[top] 管道间距
  void checkPass(double height, double top) {
    if (birdHigh < height || birdHigh + Config.birdWidth > height + top) {
      print("撞鸟了");
      _stopGame();
    }
  }

  ///开始游戏
  void _startGame() {
    _gameStatus = GameStatus.DOING;
    print("object");
    _menuKey.currentState?.show(_gameStatus);
    _pipeKey.currentState?.start(_gameStatus);
    birdHigh = MediaQuery.of(context).size.height / 2;
    //循环播放背景音乐
    audioBgm.loop("audio/bgm.mp3");
    //开始动画
    _animationController.repeat();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      ++score;
      _scoreKey.currentState?.setScore(score);
      audioClick.play("audio/gold.wav");
    });
  }

  ///游戏结束
  void _stopGame() {
    _gameStatus = GameStatus.END;
    _menuKey.currentState?.show(_gameStatus);
    _isClick = false;
    audioClick.play("audio/die.wav");
    audioBgm.fixedPlayer?.release();
    _timer?.cancel();
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    birdHigh = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            if (_gameStatus == GameStatus.START) {
              _startGame();
            } else if (_gameStatus == GameStatus.END) {
              _gameStatus = GameStatus.START;
              _menuKey.currentState?.show(_gameStatus);
              score = 0;
              _scoreKey.currentState?.setScore(score);
            }
          },
          onTapDown: (details) {
            if (_gameStatus == GameStatus.DOING) {
              _isClick = true;
              audioClick.play("audio/click.wav", mode: PlayerMode.LOW_LATENCY);
            }
          },
          onTapUp: (details) {
            if (_gameStatus == GameStatus.DOING) {
              _isClick = false;
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                //背景
                BgWidget(),
                // 管道
                Positioned(
                  child: PipelineWidget(
                    key: _pipeKey,
                    animationController: _animationController,
                    callback: checkPass,
                    // list: _list,
                  ),
                ),
                // //地面
                Positioned(
                  bottom: 0,
                  child: GroundWidget(
                    animationController: _animationController,
                  ),
                ),
                //小鸟
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, _) {
                    return Visibility(
                      visible: _gameStatus != GameStatus.START,
                      child: Positioned(
                        top: birdHigh,
                        child: BirdWidget(
                          animationController: _animationController,
                        ),
                      ),
                    );
                  },
                ),
                //菜单
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 160,
                  child: MenuWidget(
                    key: _menuKey,
                  ),
                ),
                //分数
                Positioned(
                  top: 20,
                  right: 20,
                  child: ScoreWidget(
                    key: _scoreKey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopGame();
    _animationController.dispose();
    audioBgm.clearAll();
    super.dispose();
  }
}
