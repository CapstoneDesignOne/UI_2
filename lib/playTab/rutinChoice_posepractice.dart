import 'package:flutter/material.dart';
class rutinChoice_posePractice extends StatelessWidget {
  final changeViews;
  const rutinChoice_posePractice(this.changeViews,{super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFC8FCC3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 25,
                  onPressed: () {
                    changeViews(4);
                  },
                  icon: Icon(Icons.backspace_outlined),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/chellen/pose_title.png',
                  ),
                  InkWell(
                    onTap: () {
                      changeViews(3);
                    },
                    child: Image.asset('assets/chellen/level1.png'),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      // Your onTap logic
                    },
                    child: Image.asset('assets/chellen/level2.png'),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      // Your onTap logic
                    },
                    child: Image.asset('assets/chellen/level3.png'),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
