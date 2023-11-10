import 'package:flutter/material.dart';
import 'package:cabston/PlayTab.dart';
import 'package:cabston/pose_detection/pose_detector_view.dart';

class exp_yoga_ch extends StatelessWidget{
  final changeViews;
  const exp_yoga_ch(this.changeViews,{super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(iconSize: 45, onPressed: () {
              changeViews(2);
            }, icon: Icon(Icons.backspace_outlined)),
          ],
        ),
        Expanded(
            child: Column(
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/pose/p_button_4.png'),
                  ),

                ),
                IconButton(iconSize: 50, onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PoseDetectorView()),);
                }, icon: Icon(Icons.camera)),
                Container(
                  width: 250,
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text("설명설명설명설명설명설명"
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