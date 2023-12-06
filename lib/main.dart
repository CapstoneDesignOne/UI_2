import 'package:cabston/SignUpPage.dart';
import 'package:cabston/notification.dart';
import 'package:cabston/selected_num.dart';
import 'package:cabston/user_info.dart';
import 'package:flutter/material.dart';
import 'package:cabston/MainPage.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:rhino_flutter/rhino_manager.dart';
import 'package:rhino_flutter/rhino_error.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:porcupine_flutter/porcupine.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;



void main() async {
  // final notificationService = NotificationService();
  // await notificationService.init();
  WidgetsFlutterBinding.ensureInitialized();
  // 타임존 초기화
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul')); // 예시로 서울 타임존 설정
  //print(DateTime.now());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => selected_pose_num()),
        ChangeNotifierProvider(create: (context) => user_info()),
        // 다른 프로바이더들도 필요하다면 여기에 추가
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: LoginPage()
    );
  }
}

class LoginPage extends StatelessWidget {
  //TextEditingController user_id = TextEditingController();
  //TextEditingController password = TextEditingController();

  /*Future<void> login (BuildContext context) async{
    final response = await http.post(
      Uri.parse('http://34.64.61.219:3000/login'),
      headers: {//보낼 데이터 형식(json)
        'Content-Type': 'application/json',
      },
      body: jsonEncode({//json 형식으로 보낼 데이터 입력
        'user_id' : user_id.text,
        'password' : password.text
      }),
    );
    if (response.statusCode == 200) {//200 = 정상적으로 연결 되었다.
      bool isLogin = json.decode(response.body)['login']==1 ? true:false;
      if(isLogin) {
        int user_num = json.decode(response.body)['user_num'];
        context.read<user_info>().login_user(user_num);
        Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));
      }else{
        failToLogin(context);
      }
    }
  }*/

  void failToLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("로그인 실패"),
          content: Text("아이디와 패스워드를 \n다시 확인해주세요"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

  //const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEFFEF),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/login/Lotus.png'),
              Text(
                'Yobis',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Image.asset('assets/login/Yoga (1).png'),
              SizedBox(height: 34),
              // 아이디 입력란
              Container(
                width: 300, margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ID',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ), // 레이블
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // 컨테이너의 모서리를 둥글게 만듭니다
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey, // 내부를 회색으로 설정
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10), // 내부 여백 조절
                      child: TextField(
                        //controller: user_id,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '아이디를 입력하세요',
                        ),
                        style: TextStyle(color: Colors.black), // 입력 텍스트 색상
                      ),
                    ),
                  ],
                ),
              ),
              // 비밀번호 입력란 (암호 표시)
              Container(
                width: 300,
                height:100,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PassWord',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ), // 레이블
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // 컨테이너의 모서리를 둥글게 만듭니다
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey, // 내부를 회색으로 설정
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10), // 내부 여백 조절
                      child: TextField(
                        //controller: password,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '비밀번호를 입력하세요',
                        ),
                        style: TextStyle(color: Colors.black), // 입력 텍스트 색상
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Transform.translate(
                  offset: Offset(-120.0, -20.0), // Adjust these values to move the text upward and to the left
                  child: GestureDetector(
                    onTap: () {
                      // 회원 가입 텍스트를 눌렀을 때 회원 가입 페이지로 이동
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      '회원 가입',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {/*login (context);*/Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFB7F667)),
                ),
                child: Text('로그인',style: TextStyle(color: Colors.black),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class MyApp1 extends StatefulWidget {
  @override
  WakeWord_AudioRecord createState() => WakeWord_AudioRecord();
}

class WakeWord_AudioRecord extends State<MyApp1>{


  RhinoManager? _rhinoManager;
  PorcupineManager? _porcupineManager;

  String intend = "";
  int callVoice = 0;
  //////////////Rhino 관련 함수///////////////

  //음성을 인식하면 호출되는 함수
  void inferenceCallback(RhinoInference inference) {
    if(inference.isUnderstood!){
      String intent = inference.intent!;
      Map<String, String> slots = inference.slots!;
      setState(() {
        intend = intent;
      });
      Future.delayed(const Duration(milliseconds: 5000), () {
        setState(() {
          intend = "";
          callVoice = 0;
        });
      });
    }else{//모델에 없는 음성을 인식함
      setState(() {
        callVoice = 0;
      });
    }
  }

  //Rhino 초기 세팅
  Future<void> startIntent() async{
    try {
      _rhinoManager = await RhinoManager.create(
          "Z1fKua1jlJ9VmcdqbrQXCmYrUGoLyslZsapGBHIcy34XxkT41fhrQQ==",
          "assets/voice/Yovis_ko_android_v3_0_0.rhn",
          inferenceCallback,
          modelPath : "assets/voice/rhino_params_ko.pv");
    } on RhinoException catch (err) {
      // h
    }
  }

  Future<void> rhinoStart() async {
    if (_rhinoManager == null) {
      await startIntent();
      //wakeword 객체 없으면 생성하고 실행
    }
    try {
      await _rhinoManager!.process();
    } on RhinoException catch (e) {
      print("start rhino error : $e");
    }
  }
  ///////////////////////////////

  //////////////wake word 관련 함수////////////////
  Future<void> startWakeWord() async {
    if (_porcupineManager != null) {
      await _porcupineManager?.delete();
      _porcupineManager = null;
    }
    try {

      _porcupineManager = await PorcupineManager.fromKeywordPaths(
          "Z1fKua1jlJ9VmcdqbrQXCmYrUGoLyslZsapGBHIcy34XxkT41fhrQQ==",
          ["assets/voice/데이지_ko_android_v2_2_0.ppn", "assets/voice/요비스_ko_android_v2_2_0.ppn"],
          wakeWordCallback // wake word 가 호출 되면 해당 함수로 이동
          ,modelPath: "assets/voice/porcupine_params_ko.pv");
    } catch(e) {
      print("wakeWord manage error : $e");
    }
  }

  void wakeWordCallback(int keywordIndex) {
    if (keywordIndex >= 0) {
      setState(() {
        callVoice = 1;
      });
      rhinoStart();
    }
  }
  ////////////////////////////////

  Future<void> _startProcessing() async {
    if (_porcupineManager == null) {
      await startWakeWord();
      //wakeword 객체 없으면 생성하고 실행
    }
    try {
      await _porcupineManager!.start();
    } on PorcupineException catch (e) {
      print("start wake word error : $e");
    }
  }

  Widget build(BuildContext context) {
    //웹 페이지 실행 하자 마자 wake word 실행
    _startProcessing();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('word detect2'),
        ),
        body: Column(
            children: [
              if(callVoice==1)
                Text('intend : ' + intend, style:  TextStyle(fontSize : 20),),
            ]
        ),
      ),
    );
  }
}
