import 'package:flutter/material.dart';
//추천루틴 커스텀 버튼이 뜨는 페이지
class posetab_posePractice extends StatelessWidget {
  final changeView; // practice = num
  const posetab_posePractice(this.changeView,{super.key});

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
                changeView(5); // 자세연습->추천루틴
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