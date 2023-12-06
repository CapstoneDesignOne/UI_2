import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final url = 'http://34.64.61.219:3000';//서버의 http 주소

  Future<bool> signUptoServer (String username, String password) async{
    final response = await http.post(
      Uri.parse('http://34.64.61.219:3000/login/sign_up'),
      headers: {//보낼 데이터 형식(json)
        'Content-Type': 'application/json',
      },
      body: jsonEncode({//json 형식으로 보낼 데이터 입력
        'user_name' : username,
        'pass_word' : password
      }),
    );
    if (response.statusCode == 200) {//200 = 정상적으로 연결 되었다.
      return json.decode(response.body)['sing_up']==1 ? true:false;
    } else {
      return false;
    }

  }

  void _submitForm() async{
    String username = _usernameController.text;
    String password = _passwordController.text;

    bool isSignUp = await signUptoServer(username, password);

    if(isSignUp) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("회원가입 완료"),
            content: Text("아이디: $username\n패스워드: $password"),
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
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("회원가입 실패"),
            content: Text("중복된 아이디를 사용하셨습니다."),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDEFFEF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Text(
                  '회원가입',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
                ),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: '아이디'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: '패스워드'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFB7F667)),
                ),
                child: Text(
                  "가입하기",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}