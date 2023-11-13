import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var ttmp = Score();
bool isStart = false;

class Score extends StatefulWidget {
  Score({super.key});

  int score = 100;
  int time_score = 100;


  void addScore(int current) {
    if(!isStart) {
      score = 100;
      time_score = 100;
      return ;
    }
    // 포즈
    score += (current>>3);
    score = score>>1;
    // 시간
    if((current>>3)>=80) {
      time_score+=100;
      time_score = time_score >> 1;
    }
    else if((current>>3)>=60){
      time_score+=80;
      time_score = time_score >> 1;
    }
    else {
      time_score+=60;
      time_score = time_score>>1;
    }
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
      Uri.parse(url+'/pose_detect'),
      headers: {//보낼 데이터 형식(json)
        'Content-Type': 'application/json',
      },
      body: jsonEncode({//json 형식으로 보낼 데이터 입력
        'current_score': '${ttmp.score}',
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
                Text('포즈점수 : ${ttmp.score}',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('시간점수 : ${ttmp.score}',
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
