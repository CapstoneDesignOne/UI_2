import 'package:flutter/material.dart';
import 'package:cabston/user_info.dart';
import 'package:cabston/playTab/PlayTab.dart';
import 'package:cabston/pose_detection/pose_detector_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:cabston/selected_num.dart';
import 'package:cabston/playTab/poseChoice_challengers.dart';

class exp_yoga_ch_custom extends StatefulWidget {
  final changeView;
  const exp_yoga_ch_custom(this.changeView, {Key? key}) : super(key: key);

  @override
  _exp_yoga_ch_customState createState() => _exp_yoga_ch_customState();
}

class _exp_yoga_ch_customState extends State<exp_yoga_ch_custom> {
  final url = 'http://34.64.61.219: 3000';//서버의 http 주소
  List<String> pose_name_kr = ['오른쪽 팔꿈치', '왼쪽 팔꿈치', '오른쪽 겨드랑이', '왼쪽 겨드랑이', '오른쪽 고관절', '왼쪽 고관절', '오른쪽 무릎', '왼쪽 무릎'];
  String _currentDescription = '';
  String _poseName = '';
  String poseData ='';
  String poseDataTemp ='';
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // 페이지가 처음 빌드될 때, 첫 번째 이미지에 해당하는 설명을 설정합니다.
    final selectedPoseNumProvider = Provider.of<selected_pose_num>(context);
    if (selectedPoseNumProvider.selectedPoseNum.isNotEmpty) {
      _currentDescription = selectedPoseNumProvider.selectedPoseExp[selectedPoseNumProvider.selectedPoseNum.first-1];
      poseDataTemp = selectedPoseNumProvider.selectedPoseNameSever[0];
    }
  }

  //서버에서 데이터를 받아온다.
  Future<dynamic> fetchData(int user_num) async {
    if(poseData == "") poseData = poseDataTemp;
    final response = await http.post(
      Uri.parse(url+'/pose_point/get_yoga_point'),
      headers: {//보낼 데이터 형식(json)
        'Content-Type': 'application/json',
      },
      body: jsonEncode({//json 형식으로 보낼 데이터 입력
        'user_num' : user_num,
        'pose_name': poseData,
      }),);
    if (response.statusCode == 200) {//200 = 정상적으로 연결 되었다.
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<selected_pose_num>(
      builder: (context, selectedPoseNumProvider, child){
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      iconSize: 25,
                      onPressed: () {
                        //싹다 초기화아ㅏ아아아아아아아
                        selectedPoseNumProvider.selectedImagesPose.clear();
                        selectedPoseNumProvider.selectedImages.clear();
                        selectedPoseNumProvider.selectedPoseNum.clear();
                        selectedPoseNumProvider.selectedPoseNameSever.clear();
                        _currentDescription='';
                        widget.changeView(7);
                      },
                      icon: Icon(Icons.backspace_outlined)),
                ],
              ),
              Container(
                height: 400,
                child: PageView.builder(
                  itemCount: selectedPoseNumProvider.selectedImagesPose.length,
                  itemBuilder: (context, index) {
                    if (_currentDescription.isEmpty) {
                      _currentDescription = selectedPoseNumProvider.selectedPoseExp[selectedPoseNumProvider.selectedPoseNum[index]];
                    }
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        selectedPoseNumProvider.selectedImagesPose[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentDescription = selectedPoseNumProvider.selectedPoseExp[selectedPoseNumProvider.selectedPoseNum[index]-1];
                      poseData = selectedPoseNumProvider.selectedPoseNameSever[index];
                      print(poseData);
                    });
                  },
                ),
              ),
              FutureBuilder <dynamic>(
                //비동기 처리(서버에서 데이터를 불러올 때까지 대기하며 보여줄 화면을 설정할 수 있다.)
                future: fetchData(context.watch<user_info>().user_num),//비동기 함수(서버 연결)
                builder: (context, snapshot) {
                  if (snapshot.hasData) {// 서버 연결 완료
                    print(snapshot.data);
                    int timeScore = snapshot.data!['time_score'];
                    List<int> scores = (snapshot.data!['pose_score'] as List<dynamic>).cast<int>();
                    String score_print = "";
                    for(int i = 0; i<scores.length; i++){
                      if(i%2==0){
                        score_print += '\n';
                      }
                      score_print += '${pose_name_kr[i]} : ${scores[i]} ';
                    }
                    return Text(score_print,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 15, // 여기에 원하는 글자 크기를 설정
                      ),); // 서버에서 받은 데이터 보여준다
                  } else if (snapshot.hasError) { // 연결 중 오류 발생
                    return Text('${snapshot.error}');//오류 메세지
                  }
                  return CircularProgressIndicator();//서버 연결 전까지 보여줄 대기 화면
                },
              ),
              IconButton(
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PoseDetectorView(),
                      ),
                    );
                  },
                  icon: Icon(Icons.camera)),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(16.0), // 텍스트 주위의 여백 조절
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0), // 각 모서리가 둥근 형태의 사각형
                ),
                child: Text(
                  _currentDescription,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}