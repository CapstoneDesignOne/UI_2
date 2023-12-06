import 'package:flutter/material.dart';

class user_info with ChangeNotifier {
  int user_num = 0;

  List<String> poseNames = [];
  List<double> posePoints = [];

  void login_user(int user_num) {
    this.user_num=user_num;
    notifyListeners();
  }

  void user_point(String pose_name, double pose_point){
    poseNames.add(pose_name);
    posePoints.add(pose_point);
    notifyListeners();
  }
}