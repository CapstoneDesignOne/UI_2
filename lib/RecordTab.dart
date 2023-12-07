import 'package:flutter/material.dart';
import 'package:cabston/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'dart:async';

class RecordTab extends StatelessWidget {
  const RecordTab({super.key});

  Future<dynamic> rankData(int user_num) async{
    final response = await http.post(
      Uri.parse('http://34.64.61.219:3000/rank'),
      headers: {//보낼 데이터 형식(json)
        'Content-Type': 'application/json',
      },
      body: jsonEncode({//json 형식으로 보낼 데이터 입력
        'user_num' : user_num,
      }),);
    if (response.statusCode == 200) {//200 = 정상적으로 연결 되었다.
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder <dynamic>(
        future: rankData(context.watch<user_info>().user_num),//비동기 함수(서버 연결)
        builder: (context, snapshot) {
          if (snapshot.hasData) {// 서버 연결 완료
            print(snapshot.data);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //margin: EdgeInsets.fromLTRB(0, 0, 220, 0),
                                decoration: BoxDecoration(
                                  color: Color(0xff00BA89),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  child: Text(
                                    snapshot.data['user_rank']!=null?'${snapshot.data['user_rank']}등':'${snapshot.data['user_cnt']}등',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xff00BA89),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child : Container(
                                  width: 300,
                                  height: 100,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '상위 ${snapshot.data['user_rank']!=null?
                                      ((snapshot.data['user_rank']/snapshot.data['user_cnt'])*100).toStringAsFixed(2):'100'}%',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //margin: EdgeInsets.fromLTRB(0, 0, 220, 0),
                                decoration: BoxDecoration(
                                  color: Color(0xff00BA89),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  child: Text(
                                    '통계',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xff00BA89),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child : Container(
                                  width: 300,
                                  height: 200,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '평균 점수: ${(snapshot.data['user_rank']!=null?snapshot.data['total_score']/snapshot.data['yoga_num']:0).toStringAsFixed(2)}점 \n '
                                          '수행한 요가 수: ${snapshot.data['user_rank']!=null?snapshot.data['yoga_num']:0}개'
                                          '\n 총 점수: ${snapshot.data['user_rank']!=null? snapshot.data['total_score']:0}점',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            );}
          else if (snapshot.hasError) { // 연결 중 오류 발생
            return Text('${snapshot.error}');//오류 메세지
          }
          return CircularProgressIndicator();}
    );
  }
}