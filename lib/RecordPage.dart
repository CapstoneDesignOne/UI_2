import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'pose_detection/camera_view.dart';

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

  void addScore (List<int> current) {
    // 포즈
    stored_scores = current;
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
      //  stored_scores[i] = (stored_scores[i]+current[i])>>1;
      //stored_scores[i] = current[i];
    }



    if(counter%50==0) {
      if(isSetting) {
        tts.setLanguage('ko');
        tts.setSpeechRate(0.5);
        tts.setPitch(1);
        isSetting = false;
      }

      if(aaa && minv < 80)
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
  //int score = 100;



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

  final url = 'http://34.64.61.219:3000';
//서버의 http 주소
  TextEditingController name = TextEditingController();
//textfield로 데이터 입력 받음.
  TextEditingController age = TextEditingController();
//textfield로 데이터 입력 받음.
  TextEditingController married = TextEditingController();
//textfield로 데이터 입력 받음.
  String _statusMessage = '';
//서버에 데이터를 보내고 상태를 저장할 변수

  Future<String> fetchData() async {
    final response = await http.post(Uri.parse(url+'/data'));//서버에서 데이터를 받아온다.
    if (response.statusCode == 200) {//200 = 정상적으로 연결 되었다.
      //정상적으로 데이터를 전달받았다면 데이터를 json(dictionary 형)형식의 데이터를 받아온다.
      var jsonData = json.decode(response.body);
      //받아온 데이터 중 message에 해당하는 데이터를 반환한다.
      return jsonData['message'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  //서버에서 데이터 베이스의 데이터를 받는다.
  Future<String> userData() async {
    final response = await http.post(Uri.parse(url+'/test'));//서버에서 데이터를 받아온다.
    if (response.statusCode == 200) {//200 = 정상적으로 연결 되었다.
      //정상적으로 데이터를 전달받았다면 데이터를 json(dictionary 형)형식의 데이터를 받아온다.
      var saveJson = json.decode(response.body);
      //받아온 데이터 중 message에 해당하는 데이터를 반환한다.
      return saveJson['test'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  //서버로 데이터를 보낸다.
  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse(url+'/pose_point/send_yoga_point'),
      headers: {//보낼 데이터 형식(json)
        'Content-Type': 'application/json',
      },
      body: jsonEncode({//json 형식으로 보낼 데이터 입력
        'user_num' : '1',
        'pose_score': '${ttmp.stored_scores}',
        'time_score' : '${ttmp.time_score}',
      }),
    );
    if (response.statusCode == 200) {//정상적으로 서버로 보냈다.
      setState(() {
        _statusMessage = 'Data sent successfully';
      });
    } else {//보내는데 문제가 생겼다.
      setState(() {
        _statusMessage = 'Failed to send data: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String PoseScore = (widget.isStart) ? '${ttmp.score}' : 'X';
    String TimeScore = (widget.isStart) ? '${ttmp.time_score}' : 'X';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('당신의 점수를 확인하세요!')),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Text('당신의 점수는....',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('포즈점수 : ${PoseScore}',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('시간점수 : ${TimeScore}',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: sendData,//함수 수행
                  child: Text('점수를 서버에 저장하세요!',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },//함수 수행
                  child: Text('돌아가기',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

}