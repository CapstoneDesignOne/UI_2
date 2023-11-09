import 'package:flutter/material.dart';
import 'package:cabston/pose_detection/pose_detector_view.dart';

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
        return posetab(changeView);
      case 2: //  추천루틴을 누르면 추천루틴 선택 페이지로간다.
        return rutinChoice(changeView);

      default : return ChoicePlayMode(changeView);
    }
  }
}

//탭내 페이지 변환
class posetab extends StatelessWidget {
  final changeView; // practice = num
  const posetab(this.changeView,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFC8FCC3),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  iconSize:20, //practice = 0으로 바뀐다.
                  onPressed: (){changeView(0);},  // 버튼 눌면 첫 탭화면으로 간다.
                  icon: Icon(Icons.backspace_outlined))
            ],
          ),
          Expanded(
            flex: 1, // 첫 번째 Expanded 위젯
            child: InkWell(
              onTap: (){
                changeView(2); // downdag 페이지로 이동한다.
              },
              child: Image.asset(
                'assets/chellen/recomand_button.png',
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
                // 두 번째 이미지 버튼을 눌렀을 때 수행할 동작 추가
              },
              child: Image.asset(
                'assets/chellen/custom_button.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
                // 두 번째 이미지 버튼을 눌렀을 때 수행할 동작 추가
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

class rutinChoice extends StatelessWidget {
  final changeViews;
  const rutinChoice(this.changeViews,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFC8FCC3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(iconSize:45,onPressed: (){changeViews(1);}, icon: Icon(Icons.backspace_outlined)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/chellen/ch_title.png',
                    fit: BoxFit.fill, // 이미지를 확장하여 채우도록 설정
                    height: 200, // 원하는 높이로 조절
                  ),
                ),
                InkWell(
                  onTap: () {
                    // 첫 번째 버튼 클릭 시 실행할 동작
                  },
                  child: Image.asset('assets/chellen/level1.png'),
                ),
                InkWell(
                  onTap: () {
                    // 두 번째 버튼 클릭 시 실행할 동작
                  },
                  child: Image.asset('assets/chellen/level2.png'),
                ),
                InkWell(
                  onTap: () {
                    // 세 번째 버튼 클릭 시 실행할 동작
                  },
                  child: Image.asset('assets/chellen/level3.png'),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

