import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'detector_view.dart';
import '../pose_detection//pose_painter.dart';

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


  List<double> excellent_upper =
  [-0.9715523877837864,
    -0.9732056944509492,
    -0.9990625312864302,
    -0.9913565094710266,
    0.012942461301415666,
    -0.16740541531293346,
    -0.9874135230322347,
    -0.9923113585215404,
    -0.5405120019459174,
    0.8350727471354472];

  List<double> excellent_lower =
  [-0.5990051237285912,
    -0.6528501462448175,
    -0.6663544946488676,
    -0.9109236800372232,
    0.38735185027341,
    0.19690837659278299,
    -0.9019657933064935,
    -0.9393770357279951,
    0.0647959323194808,
    0.9193261058664682];

  List<double> good_upper =
  [-0.9979165085901288,
    -0.998348522914842,
    -1.0,
    -1.0,
    -0.16088779715605248,
    -0.33605982999615036,
    -1.0,
    -1.0,
    -0.6783969260373617,
    0.7268553881473157];

  List<double> good_lower =
  [-0.4508569466584612,
    -0.511395633361825,
    -0.526752897999164,
    -0.8254418227486314,
    0.54155891057141,
    0.36416537122742276,
    -0.8132803226023989,
    -0.8655642648793073,
    0.23709479869810957,
    0.973689430180445];

  List<double> nomal_upper =
  [-1.0,
    -1.0,
    -1.0,
    -1.0,
    -0.48874962114552684,
    -0.6379214129832382,
    -1.0,
    -1.0,
    -0.8887652765346882,
    0.44812444597195206];

  List<double> nomal_lower =
  [-0.11838105838459789,
    -0.18664126815221066,
    -0.20426237528450375,
    -0.5825955971924103,
    0.7964225239552729,
    0.6607386036005226,
    -0.5652215457620302,
    -0.6420813943523253,
    0.5550641912010196,
    1.0];

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
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
