import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:cabston/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'pose_detection/camera_view.dart';
import 'package:provider/provider.dart';

var ttmp = Score();
bool isSetting = true;

class Score extends StatefulWidget {
  Score({super.key});


  int counter = 0;
  int counter2 = 0;

  int score = 100;
  int time_score = 100;
  FlutterTts tts = FlutterTts();

  List<String> ment  = [
    '오른쪽 팔 문제',
    '왼쪽 팔 문제',
    '오른쪽 팔 문제',
    '왼쪽 팔 문제',
    '오른쪽 다리 문제',
    '왼쪽 다리 문제',
    '오른쪽 무릎 문제',
    '왼쪽 무릎 문제'];


  late TextEditingController tts_text = TextEditingController();

  int ddd = 0;
  int minv = 0;
  int minidx = 0;
  int idx = 0;
  List<int> stored_scores=[100,100,100,100,100,100,100,100,];

  void init_scores(){
    stored_scores=[100,100,100,100,100,100,100,100,];
  }

  void addScore (List<int> current) {
    // 포즈
    //stored_scores = current;
    //ddd1 = current;
    ddd = 0;
    minv = 200;
    minidx = 0;
    idx = 0;

    current.forEach((i) {
      ddd += i;
      minv = (i<minv) ? i:minv;
      minidx = (i==minv) ? idx : minidx;
      idx++;
    });



    for(int i=0; i<8; ++i) {
      stored_scores[i] = (stored_scores[i]+current[i])>>1;
      //stored_scores[i] = current[i];
    }



    if(counter%80==0) {
      if(isSetting) {
        tts.setLanguage('ko');
        tts.setSpeechRate(0.5);
        tts.setPitch(1);
        isSetting = false;
      }

      if(aaa && minv < 20)
        tts.speak(ment[minidx]);
      counter=1;
    }
    else
      counter++;
    //isSpeak = false;
  }

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {

  @override
  Widget build(BuildContext context) {
    return Text('Your Score : ${widget.score}');
  }
}

class resultPage extends StatefulWidget {
  resultPage(
      this.isStart,
      {super.key}
      );

  final bool isStart;

  @override
  resultPageState createState() => resultPageState();

}

class resultPageState extends State<resultPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<user_info>(builder: (context, user_info, child){
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFFDEFFEF),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  ClipOval(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Text(
                        '당신의 점수를 확인하세요!',
                      style: TextStyle(
                        fontFamily: 'Da',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 400,
                    height: 230,
                    color: Colors.white,
                    child:ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: user_info.poseNames.length,
                        itemBuilder:(BuildContext context, int index){
                          return ListTile(
                              title : Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      '${user_info.poseNames[index]} : ${user_info.posePoints[index]} 점',
                                      style: TextStyle(fontFamily: 'Da',fontSize: 25, fontWeight: FontWeight.bold)
                                  )
                              )
                          );
                        }),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      user_info.poseNames.clear();
                      user_info.posePoints.clear();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent), // 버튼 배경투명
                      elevation: MaterialStateProperty.all(0), // 그림자 없애기
                      //fixedSize: MaterialStateProperty.all(Size(150, 50)), // 버튼 크기 지정
                    ),
                    child: Image.asset(
                      'assets/BackButton.png',
                    ),
                  ),
                ]),
          ),
        ),
      );
    });
  }

}