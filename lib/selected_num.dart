import 'package:flutter/material.dart';

class selected_pose_num with ChangeNotifier {
  List<String> _selectedPoseName = ["","다운독","측면널빤지자세","활자세","하이런지자세",
    "연꽃자세","코브라자세","보트자세","어깨서기자세","쟁기자세","전사자세3",
    "반달자세","선 전굴자세","전사자세2","나무자세","교각자세"
  ];//자세 이름
  List<String> _selectedPoseExp = [
    "다운독 자세\n"
    "손 과 발을 바닥에 대고 몸을 삼각형 모양으로 만듭니다.\n "
        "꼬리뼈를 천장으로 높게 들어올리며, 손목부터 꼬리뼈까지 몸을 길게 늘리며 곧게 뻗습니다.\n"
  "팔과 다리, 모두 균등하게 힘을 싣습니다.\n"
        " 흉곽은 무겁게 가라앉지 않도록 두 팔의 힘을 사용해 바닥을 밀어내고, 손가락은 오리발처럼 넓게 펼칩니다.\n"
  "두 팔은 살짝 외회전하여 어깨와 귀 사이의 충분한 공간을 확보하고, 목은 길게 늘리며 긴장하지 않도록합니다.\n"
  "척추가 펴졌다면, 가능한만큼 발 뒷꿈치를 바닥으로 내려, 다리 뒷면인 햄스트링, 종아리, 아킬레스건을 지나 발 뒷꿈치까지, 하체 전체를 길게 늘립니다."
        "시선은 발 또는 정강이를 바라봅니다.\n",
    "측면널빤지자세\n"
  "하이플랭크자세에서 몸을 측면으로 틀어주세요.\n"
  "손가락을 넓게 편 상태에서, 반대쪽 팔을 하늘로 뻗습니다.\n"
  "발목은 당긴 상태에서, 한 발을 다른 발 위에 얹습니다.\n"
  "머리끝에서 발끝까지 척추를 길게 늘이고, 상체와 하체에 체중을 고르게 분산시킵니다.\n"
  "옆구리와 골반을 최대한 윗쪽으로 높게 들어 올립니다.\n"
  "어깨 관절에 힘이 너무 많이 실리지 않도록, 바닥과 닿은 손바닥을 힘 있게 밀어내 복부 근육을 사용합니다.\n"
  "근력뿐 아니라 균형감각이 함께 요구되는 자세입니다.\n"
      "시선은 들어 올린 손끝을 바라보아도 좋고, 목이 불편하다면 바닥을 바라보아도 좋습니다.\n",
    "활자세\n"
  "배를 바닥에 대고 엎드린 자세에서 시작합니다.\n"
  "두 다리는 골반간격을 유지하고, 무릎을 접어 발을 바닥에서 들어올립니다.\n"
  "두 손을 뒤로보내 발목 바깥쪽을 잡습니다.발끝은 맞닿아 있습니다.\n"
      "다리를 위로 들어올리며 뒷쪽으로 밀어내 어깨와 가슴을 더 활짝 열어줍니다.\n"
      "시선은 앞쪽을 바라봅니다.\n",
    "하이런지 자세\n"
  "선자세에서 뒷 발을 멀리 뻗어, 두 발이 같은 방향을 바라보도록 합니다.\n"
  "뒷다리를 쭉 펴고, 발 뒤꿈치는 들어 올립니다.\n"
  "앞다리 무릎이 발목 바로 위에 오도록 합니다.\n"
  "흉곽을 들어 올리며 배꼽을 척추 쪽으로 끌어당깁니다.\n"
  "다리가 무겁게 가라앉지 않도록, 발 뒤꿈치로 바닥을 꾹 밀어내고, 골반기저근을 살짝 위로 끌어올립니다.\n"
  "두 팔을 머리 위로 들어 올려 손가락 끝까지 힘 있게 뻗고, 날개뼈는 아래로 끌어내립니다.\n"
  "두 팔은 평행을 유지하며 손바닥끼리 마주 보도록 해도 좋고, 더 가능하다면 손바닥을 맞대도 좋습니다.\n"
        "시선은 앞쪽을 바라보거나, 위를 바라보아도 좋습니다.\n",
    "연꽃자세\n"
  "앉은 자세에서, 한쪽 발등을 반대쪽 허벅지 안족에 얹고,\n"
  "반대쪽도 동일하게 진행합니다.척추를 곧게 세우고, 양손은 가볍게 무릎 위에 얹습니다.\n"
  "가슴을 활짝 열고, 어깨를 편안하게 합니다.\n"
  "시선은 앞쪽을 향하거나, 눈을 감고 내면을 향합니다.\n",
    "코브라자세\n"
        "바닥에 엎드린 자세에에서, 다리를 골반간격으로 벌리고 발등을 바닥에 댑니다.\n"
  "손가락을 넓게 벌리고 두 손은 가슴 옆 매트를 짚습니다.\n"
  "손바닥으로 바닥을 밀어내며 가슴을 들어 올립니다.\n"
  "어깨가 말리지 않도록 주의하며 날개뼈를 뒤로, 아래로 끌어내려 어깨와 귀가 멀어지도록 합니다.\n"
  "허벅지와 발등으로 바닥을 꾹 누릅니다.\n"
  "팔꿈치는 접어도 되고, 가능하다면 쭉 펴도 좋습니다.\n"
  "단, 팔에 무게중심이 너무 많이 실리지 않도록 주의하며, 등허리의 힘을 충분히 느낍니다.\n"
        "시선은 앞을 바라보거나 위를 바라봅니다.\n",
    "보트자세\n"
        "엉덩이를 대고 매트에 앉은 자세에서, 다리를 모아 바닥에서 45도 정도로 들어 올립니다.\n"
    "어깨가 말리지 않도록 가슴을 넓게 열고, 척추를 길게 늘입니다.\n"
    "배꼽은 척추 쪽으로 끌어당겨 복부를 단단하게 유지하고, 척추는최대한 길게 늘입니다.\n"
        "두 팔은 다리 너머 앞쪽으로, 지면과 평행하게 뻗습니다.시선은 앞쪽을 향합니다.\n",
    "어깨서기자세\n"
    "누운자세에서 시작합니다.쟁기자세에서, 두 손을 등에 대고 보조합니다.\n"
  "팔꿈치는 어깨 간격을 유지하고, 팔이 벌어지지 않도록 주의합니다.\n"
  "두 다리를 모아 하늘을 향해 들어올립니다.\n"
  "허벅지가 벌어지지 않도록 안쪽을 조이는 힘도 사용합니다.\n"
  "목에만 너무 무게가 실리지 않도록, 어깨와 팔뚝으로 바닥을 힘있게 밀어내며, 복부를 조이고 다리를 윗쪽으로 끌어올립니다.\n"
  "시선은 내면을 향합니다.\n",
    "쟁기자세\n"
        "누운자세에서 시작하되,목을 좌우로 움직이지 않도록 주의합니다.\n"
  "손바닥으로 바닥을 짚어도 좋고, 손으로 등을 보조해도 좋습니다.\n"
  "복부의 힘으로 두 다리를 들어올리고, 그대로 머리위로 넘겨 발끝이 바닥에 닿도록합니다.\n"
  "복부 힘 뿐 아니라, 척추의 유연성이 필요한 동작입니다.\n"
  "유지하는 것이 어렵다면, 두 손으로 등을 받치고 수련하는 것도 좋습니다.\n"
  "자세가 안정적이라면, 두 손바닥을 바닥에 대거나 깍지를 낍니다.\n"
        "시선은 내면을 향합니다.\n",
    "전사자세3\n"
        "일어선 자세에서 몸을 알파벳 T자 모양을 만든다고 생각하며, 한 다리를 뒤로 곧게 뻗습니다.\n"
  "동시에 상체를 앞으로 숙이며 두 팔을 머리 너머로 멀리 뻗습니다.\n"
  "골반은 중립상태를 유지하고 아랫배를 끌어 당깁니다.\n"
  "두 다리와 팔이 바닥과 평행이 되도록 합니다.\n",
    "반달자세\n"
        "하체는 그대로 고정하고, 왼 무릎과 발목이 일직선이 되도록 유지합니다.\n"
  "상체를 기울이며 왼 손을 왼 발의 뒤쪽, 또는 앞쪽에 놓습니다.\n"
  "반대쪽 오른팔은 오른쪽 귀 옆으로 가져옵니다.\n"
  "어깨가 말리지 않도록 주의하며, 가슴을 활짝 열고 겨드랑이가 하늘을 향하게 합니다.\n"
  "오른 발끝부터 손끝까지 길게 늘입니다.\n"
  "이 자세가 어렵다면 왼 팔을 접어 팔뚝을 왼 허벅지 위에 얹고 진행해도 좋습니다.\n"
  "손을 한보 앞으로 뻗고 뒷 다리를 들어올립니다.\n"
  "천천히 바닥을 지탱하는 다리의 무릎을 폅니다.\n"
  "발목을 당겨 허벅지근육을 활성화 시킵니다.\n"
  "이때 골반은 열려있고, 가슴은 측면을 향해있습니다.\n"
  "몸이 아래로 무겁게 가라앉지 않도록 주의하며 손바닥 또는 손가락을 사용해 상체를 살짝 더 들어올립니다.\n"
  "무게 중심은 대부분 서있는 다리에 있고, 바닥을 짚은 손은 보조하는 정도로 사용합니다.\n"
  "반대편 팔은 하늘을 향해 뻗어, 왼팔과 오른팔이 일직선이 되도록합니다.\n"
        "시선은 들어올린 손끝을 바라보되, 중심을 잡는 것이 어렵다면 바닥을 바라보아도 좋습니다.\n",
    "선 전굴자세\n"
        "어선 자세에서 시작합니다.\n"
  "힙에서부터 상체를 깊숙이 접고, 꼬리뼈는 하늘로 높게 들어 올립니다.\n"
  "정수리가 바닥을 향하게 하며, 목에는 힘이 들어가지 않도록 합니다.\n"
  "복부를 허벅지 가깝게 가져오며, 손은 발 옆 바닥에 놓습니다.\n"
        "엉덩이가 뒤로 빠지지 않도록 주의하며, 골반에서부터 발 뒤꿈치까지 일직선이 되도록 합니다\n",
    "전사자세2\n"
        "선자세에서, 앞 다리와 뒷 다리를 넓게 벌립니다.\n"
  "앞으로 뻗은 다리는 90도 접어, 무릎이 발목 바로 위에 오도록 섭니다.\n"
  "뒤로 뻗은 다리는 매트의 좁은면과 평행이 되도록 60도 또는 90도를 틀어 바닥을 누릅니다.\n"
  "흉곽이 무겁게 가라앉지않도록 복부의 힘을 느끼며 살짝 들어올리고, 두 팔은 양 옆으로 뻗습니다.\n"
        "어깨는 편안하게하고, 시선은 앞으로 뻗은 손 끝 너머를 바라봅니다.\n",
    "나무자세"
        "산 자세에서 시작합니다.\n"
  "한 발로 바닥을 지탱하고 선 상태에서, 반대쪽 발을 들어 올립니다.\n"
  "들어 올린 다리를 접어, 서있는 다리의 허벅지 안쪽에 발바닥을 댑니다.\n"
  "골반을 열어 무릎이 옆면을 향하도록 합니다.\n"
  "가슴을 활짝 열고, 두 손바닥을 가슴 앞에서 모읍니다.\n"
        "시선은 앞쪽을 바라봅니다.\n",
    "교각자세\n"
        "등을 바닥에 대고 누운 상태에서,다리를 골반너비로 벌립니다.\n"
  "허벅지는 골반의 간격을 유지한 상태로 안쪽의 힘을 느낍니다.\n"
  "엉덩이를 바닥에서 들어 올리고, 흉곽 또한 하늘을 향해 들어 올립니다.\n"
  "두 팔은 옆구리 옆에 두거나, 두 손을 모아 깍지를 껴도 좋습니다.\n"
  "시선은 무릎 너머 또는 위쪽을 바라봅니다.\n"];
  List<int> _selectedPoseNum = []; // 포즈 선택된 index파악
  List<String> _selectedImages = []; // pose 버튼 주소
  List<String> _selectedImages_pose = []; // pose 사진 주소
  List<String> _selectedPoseName_sever=[];

  // 외부에서 접근 할 수 있도록 getter 생성
  List<String> get selectedPoseName => _selectedPoseName;
  List<String> get selectedPoseName_sever =>_selectedPoseName_sever;
  List<int> get selectedPoseNum => _selectedPoseNum;
  List<String> get selectedImages => _selectedImages;
  List<String> get selectedPoseExp => _selectedPoseExp;
  List<String>  get selectedImagesPose => _selectedImages_pose;

  void addSelectedPose(int index, String imageAsset, String imageAset2) {
    if (_selectedPoseNum.length < 3) {
      _selectedPoseNum.add(index + 1);
      _selectedImages.add(imageAsset);
      _selectedImages_pose.add(imageAset2);
      _selectedPoseName_sever.add(_selectedPoseName[index+1]);
      print('Selected Poses: $_selectedPoseNum');
      print('Selected Images: $_selectedImages');
      print('Selected Images1: $_selectedImages_pose');
      print('selected name: $_selectedPoseName_sever');
      notifyListeners();
    }

  }

  void removeSelectedPose(int i) {
    _selectedPoseNum.removeAt(i);
    _selectedImages.removeAt(i);
    _selectedImages_pose.removeAt(i);
    _selectedPoseName_sever.removeAt(i);
    notifyListeners();
  }

}