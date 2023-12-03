import 'package:cabston/selected_num.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class poseChoice_challengers extends StatefulWidget {
  final changeView; // practice = num
  const poseChoice_challengers(this.changeView, {Key? key}) : super(key: key);

  @override
  _poseChoice_challengersState createState() =>
      _poseChoice_challengersState();
}

class _poseChoice_challengersState extends State<poseChoice_challengers> {
   List<String> selectedPoses = []; // 서버 전송용

  @override
  Widget build(BuildContext context) {
    print(context.read<selected_pose_num>().selectedImages);
    return Consumer<selected_pose_num>(
      builder: (context, selectedPoseNumProvider, child){
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 25,
                        onPressed: () {
                          widget.changeView(1); // 챌린져스 ->추천루틴,커스텀
                        },
                        icon: Icon(Icons.backspace_outlined),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/chellen/ch_title.png',
                  ),
                  SizedBox(height: 50,),
                  Column(
                    children: [
                      Text(
                        '선택된 자세',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '최대 3가지 자세를 선택하세요!',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.only(top:30),
                        width: 350,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: selectedPoseNumProvider.selectedImages.isNotEmpty
                              ? List.generate(selectedPoses.length, (int i) { // 선택된 이미지가 있을때
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(selectedPoseNumProvider.selectedImages[i]),
                                          Text(
                                            selectedPoseNumProvider.selectedPoseName[int.parse(selectedPoses[i])],

                                            textAlign: TextAlign.center,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                // ChangeNotifierProvider로 제공된 인스턴스의 메서드 호출
                                                // 선택한 자세 제거
                                                selectedPoseNumProvider.removeSelectedPose(i);
                                                selectedPoses.removeAt(i);
                                                // selectedImages.removeAt(i);
                                                // selectedPoses_int.removeAt(i);
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.teal),
                                              elevation: MaterialStateProperty.all(0),
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              //color: Colors.tealAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          })
                              : [ // 선택된 이미지가 없을때
                            Container(
                                padding : EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "자세를 선택해주세요!",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      if (selectedPoseNumProvider.selectedImages.isNotEmpty) // 자세 선택해야 start 버튼 생겨남
                        ElevatedButton(
                          onPressed: () {
                            widget.changeView(8);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent), // 버튼 배경투명
                            elevation: MaterialStateProperty.all(0), // 그림자 없애기
                            //fixedSize: MaterialStateProperty.all(Size(150, 50)), // 버튼 크기 지정
                          ),
                          child: Image.asset(
                            'assets/chellen/Start.png',
                          ),
                        ),
                    ],
                  ),
                  Container( // 자세 버튼 고르는 부분
                    color: Color(0xFFC8FCC3),
                    child: GridView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 100,
                        crossAxisSpacing: 30,
                        childAspectRatio: 2 / 1,
                      ),
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        String imageAsset = 'assets/p_button/p_button${index + 1}.png';
                        String imageAsset2 = 'assets/pose/p_button_${index + 1}.png';
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // 최대 3개까지만 선택하도록 함
                              //index -> posenum용, imageAset->poseImage 용
                              if (selectedPoses.length < 3) {
                                selectedPoseNumProvider.addSelectedPose(index, imageAsset,imageAsset2);
                                selectedPoses.add('${index + 1}'); //서버용
                              }
                              // if (selectedPoses.length < 3) {
                              //   selectedPoses.add('${index + 1}');
                              //   selectedPoses_int.add(index+1);
                              //   selectedImages.add(imageAsset);
                              // }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Color(0xFFC8FCC3)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Ink.image(
                            image: AssetImage(imageAsset),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}


