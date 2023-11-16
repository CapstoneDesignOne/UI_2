import 'package:flutter/material.dart';
//추천루틴 커스텀 버튼이 뜨는 페이지
class posetab_challengers extends StatelessWidget {
  final changeView; // practice = num
  const posetab_challengers(this.changeView,{super.key});

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
                  iconSize:25, //practice = 0으로 바뀐다.
                  onPressed: (){changeView(0);},  // 버튼 눌면 첫 탭화면으로 간다.
                  icon: Icon(Icons.backspace_outlined))
            ],
          ),
          Image.asset(
            'assets/chellen/ch_title.png',
          ),
          Expanded(
            flex: 1, // 첫 번째 Expanded 위젯
            child: InkWell(
              onTap: (){
                changeView(2); // leve1,level2,level3가 있는 페이지로 이동한다.
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
                changeView(7); // 챌린져스->자세연습->자세선택
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