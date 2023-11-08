import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cabston/PlayTab.dart';
import 'package:cabston/RecordTab.dart';
import 'package:cabston/YogaCalenderTab.dart';


class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin  {

  late TabController _tabController;
  String appBarTitle = ''; // 날짜 문자열을 저장할 변수
  TextStyle appBarTitleStyle = TextStyle(
    fontSize: 24, // 원하는 크기로 설정
    fontWeight: FontWeight.bold, // 글씨체를 굵게 설정
    color: Color(0xFF050000),
  );

  @override /* APPbar 상단 문구 정리*/


  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _updateAppBarTitle(); // 초기 App Bar 문구 설정
    _tabController.addListener(_handleTabSelection); // 탭 변경 시 호출할 콜백 함수 등록
    super.initState();
  }

  void _updateAppBarTitle() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(now);
    setState(() {
      appBarTitle = formattedDate;
    });
  }

  void _handleTabSelection() {
    if (_tabController.index == 0) {
      setState(() {
        appBarTitle = '요가를 차근차근 배워봐요!';
      });

    } else if (_tabController.index == 1) {
      setState(() {
        appBarTitle = '랭킹을 확인해보세요!';
      });
    } else if(_tabController.index ==2){
      setState(() {
        appBarTitle = '모드를 선택하세요!';
      });
    }
  }
  int currentTabIndex = 0;
  bool showWowButton = true;
  @override

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeTabContent(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
  void toggleWowButton() {
    setState(() {
      showWowButton = !showWowButton;
      changeTabContent(0); // 세 번째 이미지 버튼을 누르면 첫 번째 탭으로 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: appBarTitleStyle,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFDEFFEF),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/profile_picture.png'),
        ),
        actions: [
          Container(
              color: Color(0xFFDEFFEF),
              width: 50,
              height: 10,
              child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.keyboard_backspace,color: Colors.black,))
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          /*챌린져스, 자세연습 탭 상단 부분 상단 탑bar 선언*/
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.transparent),
              color: Color(0xFFDEFFEF),
            ),
            child: TabBar( // 상단 탭바 선언
              tabs: [ // 탭 종류
                customTab('Yoga Calender'),
                customTab('Record'),
                customTab('Play')
              ],
              indicator: BoxDecoration( // 모양 깍음
                color: Color(0xFFC8FCC3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  YogaCalenderTab(), //커리큐렴
                  RecordTab(),// 랭킹
                  PlayYogaTab(),//모드선택
                ]
            ),
          ),
        ],
      ),
    );
  }
}
// 상단 탭 부분 디자인 들 , yogaCalender, recod, yoga
class customTab extends StatelessWidget {

  const customTab(this.tabName,{super.key});
  final String tabName;
  
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Text(
          tabName,
          style: TextStyle(
            fontSize: 24, // 원하는 크기로 설정
            fontWeight: FontWeight.bold, // 글씨체를 굵게 설정
          ),
        )
    );
  }
}








