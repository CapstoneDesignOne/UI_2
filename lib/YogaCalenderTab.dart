import 'package:cabston/pose_detection/pose_detector_view.dart';
import 'package:flutter/material.dart';

class YogaCalenderTab extends StatefulWidget {
  const YogaCalenderTab({super.key});

  @override
  State<YogaCalenderTab> createState() => _YogaCalenderTabState();
}

class _YogaCalenderTabState extends State<YogaCalenderTab> {
  int practice = 0;

  void changeView(int num) {
    setState(() {
      practice = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(practice) {
      case 1 :
        return posetab(changeView);
      case 2:
        return DownDog(changeView);
      case 3:
        return posetab(changeView);

      default : return ChoicePlayMode(changeView);
    }
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
                    image: AssetImage('assets/pose/p_button_1.png'),
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


//탭내 페이지 변환 class
class posetab extends StatelessWidget {
  final changeView;
  const posetab(this.changeView,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(iconSize:45,onPressed: (){changeView(0);}, icon: Icon(Icons.backspace_outlined)),
          ],
        ),
        Expanded(
          child: Container(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 50,
              crossAxisSpacing: 5,
              childAspectRatio: 4/2,
              children: [
                IconButton(onPressed: (){changeView(2);}, icon: Icon(Icons.back_hand))
              ],
              //itemCount: 15,
              //padding: EdgeInsets.all(),
              /*
              * itemBuilder: (BuildContext context, int index) {
                String imageAsset = 'assets/p_button/p_button${index + 1}.png';
                return ElevatedButton( // ElevatedButton 사용
                  onPressed: () {

                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFFC8FCC3)), // 버튼 배경색
                    elevation: MaterialStateProperty.all(0), // 그림자 없음fixedSize: MaterialStateProperty.all(Size(150, 150))
                  ),
                  child: Ink.image(
                    image: AssetImage(imageAsset), // 사용자 정의 이미지 경로
                    //width: 100,// 이미지 높이 조절
                    //height:100,
                  ),
                );
              },
              * */
            ),
          ),
        )
      ],
    );
  }
}
// 초급자, 중급자 ,고급자 버튼이 뜨는 탭 이미지
class ChoicePlayMode extends StatelessWidget {
  final changeView;
  const ChoicePlayMode(this.changeView,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFC8FCC3),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            //width: 10, // 가로 간격 조절
            height: 10, // 세로 간격 조절
          ),
          Expanded(
            flex: 1, // 초심자 버튼
            child: InkWell(
              onTap: (){
                changeView(1);
              },
              child: Image.asset(
                'assets/yogacalender/beginner_button.png',
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
            flex: 1, // 중급자 버튼
            child: InkWell(
              onTap: () {
                // 두 번째 이미지 버튼을 눌렀을 때 수행할 동작 추가
              },
              child: Image.asset(
                'assets/yogacalender/senior_button.png',
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
            flex: 1, // 고급자 버튼
            child: InkWell(
              onTap: () {
                // 세번째 이미지 버튼을 눌렀을 때 수행할 동작 추가
              },
              child: Image.asset(
                'assets/yogacalender/master_button.png',
                //width: 100, // 이미지의 가로 크기
                //height: 100, // 이미지의 세로 크기
              ),
            ),
          ),
        ],
      ),
    );
  }
}