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
      case 2: //  추천루틴을 누르면 downdog로간다.
        return DownDog(changeView);

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

class DownDog extends StatelessWidget {
  final changeViews;
  const DownDog(this.changeViews,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Container(
                child: Image(
                  image: AssetImage('assets/pose/downdog_example.png'),
                ),
              ),
              IconButton(iconSize:50,onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PoseDetectorView()),);}, icon: Icon(Icons.camera)),
              Container(
                width: 250,
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child : Text("설명설명설명설명설명설명"
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

