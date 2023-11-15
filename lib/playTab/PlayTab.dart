import 'dart:math';
import 'package:cabston/playTab/exp_yoga_ch.dart';
import 'package:flutter/material.dart';
import 'package:cabston/pose_detection/pose_detector_view.dart';
import 'package:cabston/playTab/recomandCustombutton_posepractice.dart';
import 'package:cabston/playTab/recomandCustombutton_challengers.dart';
import 'package:cabston/playTab/rutinChoice_challengers.dart';
import 'package:cabston/playTab/rutinChoice_posepractice.dart';

class PlayYogaTab extends StatefulWidget {
  const PlayYogaTab({super.key});

  @override
  State<PlayYogaTab> createState() => _PlayYogaTabState();
}

class _PlayYogaTabState extends State<PlayYogaTab> {
  int practice = 0;
  void changeView(int num) {
    setState(() {
      practice = num;
    });
  }
// 추천루틴누르면 루틴 뜨는 화면 만들기
  @override
  Widget build(BuildContext context) {
    switch(practice) {
      case 1 :// 챌린져스 버튼을 누르면 화면이 바뀌면서 추천루틴,커스텀이 뜬다.
        return posetab_challengers(changeView);
      case 2: //  챌린져스 ->추천루틴 -> level1,level2,leve3 페이지로 이동
        return rutinChoice_challengers(changeView);
      case 3: // 챌린져스 ->추천루틴 -> level 1선택시 요가 자세 설명문으로 이동한다.
        return exp_yoga_ch(changeView); //이름 바꾸기
      case 4: // 자세연습 버튼을 누르면 화면이 바뀌면서 추천루틴, 커스텀이 뜬다.
        return posetab_posePractice(changeView);
      case 5: // 자세연습 ->추천루틴 -> level1,level2,level3 페이지로 이동
        return rutinChoice_posePractice(changeView);
      default : return ChoicePlayMode(changeView);
    }
  }
}

// 챌린져스, 자세연습 버튼이 나타나는 페이지
class ChoicePlayMode extends StatelessWidget {
  final changeView;
  const ChoicePlayMode(this.changeView,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFC8FCC3),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            //width: 10, // 가로 간격 조절
            height: 10, // 세로 간격 조절
          ),
          Expanded(
            flex: 1, // 첫 번째 Expanded 위젯
            child: InkWell(
              onTap: (){
                changeView(1); // posetab으로 이동
              },
              child: Image.asset(
                'assets/chellen/chellen_button.png',
                //width: 100, // 이미지의 가로 크기
                //height: 100, // 이미지의 세로 크기
              ),
            ),
          ),
          SizedBox(
            //width: 10, // 가로 간격 조절
            height: 50, // 세로 간격 조절
          ),
          Expanded(
            flex: 1, // 두 번째 Expanded 위젯
            child: InkWell(
              onTap: () {
                changeView(4); // 추천루틴, 자세연습 버튼이 생겨난다.
              },
              child: Image.asset(
                'assets/chellen/posepra_button.png',
                //width: 100, // 이미지의 가로 크기
                //height: 100, // 이미지의 세로 크기
              ),
            ),
          ),
          SizedBox(
            //width: 10, // 가로 간격 조절
            height: 50, // 세로 간격 조절
          ),
        ],
      ),
    );
  }
}
