import 'package:cabston/pose_detection/pose_detector_view.dart';
import 'package:flutter/material.dart';

class YogaCalenderTab extends StatefulWidget {
  const YogaCalenderTab({super.key});
  @override
  State<YogaCalenderTab> createState() => _YogaCalenderTabState();
}

class _YogaCalenderTabState extends State<YogaCalenderTab> {
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            '요일을 정하세요!',
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
                            topLeft: Radius.circular(10),
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
                              '상위 0.1%',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            '알림을 설정하세요',
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
                            topLeft: Radius.circular(10),
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
                              '자세점수: 20점 \n 시간점수: 40점 \n 획득한 메달 수: 2개 \n 총 점수: 100점',
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
    );
  }
}
