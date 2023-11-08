import 'package:flutter/material.dart';
import 'package:cabston/MainPage.dart';

void main() {
  runApp(const MyApp());
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
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEFFEF),
      body: SingleChildScrollView(
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
              ElevatedButton(
                onPressed: () {
                  // 로그인 버튼을 눌렀을 때 Tab 페이지로 이동
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFB7F667)),
                ),
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
