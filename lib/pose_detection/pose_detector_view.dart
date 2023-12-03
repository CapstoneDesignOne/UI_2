import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'detector_view.dart';
import '../pose_detection//pose_painter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PoseDetectorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
  PoseDetector(options: PoseDetectorOptions());

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;


  List<dynamic> excellent_upper = [];
  List<dynamic> excellent_lower = [];

  List<dynamic> good_upper = [];
  List<dynamic> good_lower = [];

  List<dynamic> nomal_upper = [];
  List<dynamic> nomal_lower = [];

  bool pose_detect = true;

  void initPose() {
    excellent_upper = [0];
    excellent_lower = [0];

    good_upper = [0];
    good_lower = [0];

    nomal_upper = [0];
    nomal_lower = [0];

    pose_detect = false;
  }

  Future<bool> userData(String name) async {
    final url = 'http://34.64.61.219:3000';
    final response = await http.post(
      Uri.parse(url+'/pose_detect/send_pose_name'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'pose_name': name,
      }),
    );
    if (response.statusCode == 200) {
      var saveJson = json.decode(response.body);

      excellent_upper = saveJson['excellent_upper'];
      excellent_lower = saveJson['excellent_lower'];
      good_upper = saveJson['good_upper'];
      good_lower = saveJson['good_lower'];
      nomal_upper = saveJson['nomal_upper'];
      nomal_lower = saveJson['nomal_lower'];

      pose_detect = true;
      return true;
    } else {
      throw Exception('Failed to load data');
    }
    return false;

  }

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //userData();
    return DetectorView(
      userData: userData,
      initPose : initPose,
      title: 'Pose Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(
        excellent_lower,
        excellent_upper,
        good_lower,
        good_upper,
        nomal_lower,
        nomal_upper,

        poses,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
