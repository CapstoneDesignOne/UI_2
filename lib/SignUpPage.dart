import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // 여기에서 서버로 회원가입 정보를 보내는 등의 작업을 수행할 수 있습니다.
    // 실제로는 안전한 방법으로 데이터를 처리해야 합니다.

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