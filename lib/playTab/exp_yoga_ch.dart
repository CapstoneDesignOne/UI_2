import 'package:flutter/material.dart';
import 'package:cabston/playTab/PlayTab.dart';
import 'package:cabston/pose_detection/pose_detector_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//요가 자세 설명문 페이지
class exp_yoga_ch extends StatelessWidget{
  final changeViews;
  exp_yoga_ch(this.changeViews,{super.key});

  final url = 'http://34.64.61.219:3000';//서버의 http 주소
  TextEditingController name = TextEditingController();//textfield로 데이터 입력 받음.
  TextEditingController age = TextEditingController();//textfield로 데이터 입력 받음.
  TextEditingController married = TextEditingController();//textfield로 데이터 입력 받음.
  String _statusMessage = '';//서버에 데이터를 보내고 상태를 저장할 변수

  //서버에서 데이터를 받아온다.
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(iconSize: 45, onPressed: () {
              changeViews(2);
            }, icon: Icon(Icons.backspace_outlined)),
          ],
        ),
        Expanded(
            child: Column(
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/pose/p_button_4.png'),
                  ),

                ),
                FutureBuilder<String>(
                  //비동기 처리(서버에서 데이터를 불러올 때까지 대기하며 보여줄 화면을 설정할 수 있다.)
                  future: fetchData(),//비동기 함수(서버 연결)
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {// 서버 연결 완료
                      return Text(snapshot.data!); // 서버에서 받은 데이터 보여준다
                    } else if (snapshot.hasError) { // 연결 중 오류 발생
                      return Text('${snapshot.error}');//오류 메세지
                    }
                    return CircularProgressIndicator();//서버 연결 전까지 보여줄 대기 화면
                  },
                ),
                IconButton(iconSize: 50, onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PoseDetectorView()),);
                }, icon: Icon(Icons.camera)),
                Container(
                  width: 250,
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text("설명설명설명설명설명설명"
                        "설명설명설명설명설명dd설명"
                        "설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명""설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명""설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명""설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"
                        "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명"


                    ),

                  ),
                )
              ],
            )
        )
      ],
    );
  }
}