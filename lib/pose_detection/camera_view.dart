import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cabston/RecordTab.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:cabston/RecordPage.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:rhino_flutter/rhino_manager.dart';
import 'package:rhino_flutter/rhino_error.dart';
import 'dart:math';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:porcupine_flutter/porcupine.dart';
import 'package:flutter_tts/flutter_tts.dart';
import  'package:provider/provider.dart'; // provider관련
import 'package:cabston/selected_num.dart'; //provider 상태 관리 파일 자세 전송
bool aaa = false;
var start = DateTime.now();
var end = DateTime.now();

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
        required this.userData,
        required this.initPose,
        required this.customPaint,
        required this.onImage,
        this.onCameraFeedReady,
        this.onDetectorViewModeChanged,
        this.onCameraLensDirectionChanged,
        this.initialCameraLensDirection = CameraLensDirection.back})
      : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(String name) userData;
  final Function() initPose;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;
  bool isStart = false;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;
  FlutterTts tts = FlutterTts();
  //bool asdf = widget.isStart;

  RhinoManager? _rhinoManager;
  PorcupineManager? _porcupineManager;
  List<String> pose_name = [];
  /*자세 선택된거 넘어오는 부분*/
  void poseNamefunction(BuildContext context) {
    pose_name = context.read<selected_pose_num>().selectedPoseNameSever;

  }
  //////////////Rhino 관련 함수///////////////

  int cnt = 0;
  //음성을 인식하면 호출되는 함수
  void inferenceCallback(RhinoInference inference) {

    if(inference.isUnderstood!){
      String intent = inference.intent!;
      Map<String, String> slots = inference.slots!;

      setState(() {
        if(intent=='start') {
          widget.isStart = true;
          aaa = true;
          tts.speak("시작합니다");
          start = DateTime.now();
          widget.userData.call(pose_name[cnt]);
        }
        else if(intent=='stop') {
          widget.isStart = false;
          aaa = false;
          tts.speak("종료합니다.");
          end = DateTime.now();
          widget.initPose;
        }
        else if(intent=='time') {
          if(aaa){
            var NOW = DateTime.now();
            int min = NOW.minute-start.minute;
            int sec = NOW.second-start.second;
            tts.speak("$min분 $sec초");
          }
        }
        else if(intent=='next'){
          if(aaa && cnt<pose_name.length){
            tts.speak("${pose_name[++cnt]} 시작합니다.");
            widget.userData.call(pose_name[cnt]);
          }
        }
      });
    }
  }

  //Rhino 초기 세팅
  Future<void> startIntent() async{
    try {
      _rhinoManager = await RhinoManager.create(
          "Z1fKua1jlJ9VmcdqbrQXCmYrUGoLyslZsapGBHIcy34XxkT41fhrQQ==",
          "assets/voice/Yovis_ko_android_v3_0_0.rhn",
          inferenceCallback,
          modelPath : "assets/voice/rhino_params_ko.pv");
    } on RhinoException catch (err) {
      // h
    }
  }

  Future<void> rhinoStart() async {
    if (_rhinoManager == null) {
      await startIntent();
      //wakeword 객체 없으면 생성하고 실행
    }
    try {
      await _rhinoManager!.process();
    } on RhinoException catch (e) {
      print("start rhino error : $e");
    }
  }
  ///////////////////////////////

  //////////////wake word 관련 함수////////////////
  Future<void> startWakeWord() async {
    if (_porcupineManager != null) {
      await _porcupineManager?.delete();
      _porcupineManager = null;
    }
    try {
      _porcupineManager = await PorcupineManager.fromKeywordPaths(
          "Z1fKua1jlJ9VmcdqbrQXCmYrUGoLyslZsapGBHIcy34XxkT41fhrQQ==",
          ["assets/voice/데이지_ko_android_v2_2_0.ppn", "assets/voice/요비스_ko_android_v2_2_0.ppn"],
          wakeWordCallback // wake word 가 호출 되면 해당 함수로 이동
          ,modelPath: "assets/voice/porcupine_params_ko.pv");
    } catch(e) {
      print("wakeWord manage error : $e");
    }
  }

  void wakeWordCallback(int keywordIndex) {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.5);
    tts.setPitch(1);
    if (keywordIndex >= 0) {
      tts.speak("네");
      rhinoStart();
    }
  }
  ////////////////////////////////

  Future<void> _startProcessing() async {
    if (_porcupineManager == null) {
      await startWakeWord();
      //wakeword 객체 없으면 생성하고 실행
    }
    try {
      await _porcupineManager!.start();
    } on PorcupineException catch (e) {
      print("start wake word error : $e");
    }
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    poseNamefunction(context);
    return Scaffold(body: _liveFeedBody());
  }

  Widget _liveFeedBody() {
    //_startProcessing();
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: _changingCameraLens
                ? Center(
              child: const Text('Changing camera lens'),
            )
                : CameraPreview(
              _controller!,
              child: widget.customPaint,
            ),
          ),
          _backButton(),
          _switchLiveCameraToggle(),
          //_detectionViewModeToggle(),
          _zoomControl(),
          _exposureControl(),
          _ScoreBox(),
        ],
      ),
    );
  }

  Widget _ScoreBox() => Positioned(
      bottom: 8,
      left: 8,
      child: Transform.rotate(
        angle: pi/2,
        child: Container(
            height:75.0,
            width: 75.0,
            color: Colors.amber,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children : [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${ttmp.stored_scores[0]}'),
                        Text('${ttmp.stored_scores[1]}'),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${ttmp.stored_scores[2]}'),
                        Text('${ttmp.stored_scores[3]}'),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${ttmp.stored_scores[4]}'),
                        Text('${ttmp.stored_scores[5]}'),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${ttmp.stored_scores[6]}'),
                        Text('${ttmp.stored_scores[7]}'),
                      ]
                  ),
                ]
            )
        ),
      )
  );

  Widget _backButton() => Positioned(
    top: 40,
    left: 8,
    child: SizedBox(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        heroTag: Object(),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>resultPage(aaa),),
          );

        },
        backgroundColor: Colors.black54,
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: 20,
        ),
      ),
    ),
  );

  Widget _detectionViewModeToggle() => Positioned(
    bottom: 8,
    left: 8,
    child: SizedBox(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        heroTag: Object(),
        onPressed: widget.onDetectorViewModeChanged,
        backgroundColor: Colors.black54,
        child: Icon(
          Icons.photo_library_outlined,
          size: 25,
        ),
      ),
    ),
  );

  Widget _switchLiveCameraToggle() => Positioned(
    bottom: 8,
    right: 8,
    child: SizedBox(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        heroTag: Object(),
        onPressed: _switchLiveCamera,
        backgroundColor: Colors.black54,
        child: Icon(
          Platform.isIOS
              ? Icons.flip_camera_ios_outlined
              : Icons.flip_camera_android_outlined,
          size: 25,
        ),
      ),
    ),
  );

  Widget _zoomControl() => Positioned(
    bottom: 16,
    left: 0,
    right: 0,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Slider(
                value: _currentZoomLevel,
                min: _minAvailableZoom,
                max: _maxAvailableZoom,
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                onChanged: (value) async {
                  setState(() {
                    _currentZoomLevel = value;
                  });
                  await _controller?.setZoomLevel(value);
                },
              ),
            ),
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${_currentZoomLevel.toStringAsFixed(1)}x',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _exposureControl() => Positioned(
    top: 40,
    right: 8,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 250,
      ),
      child: Column(children: [
        Container(
          width: 55,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${_currentExposureOffset.toStringAsFixed(1)}x',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: RotatedBox(
            quarterTurns: 3,
            child: SizedBox(
              height: 30,
              child: Slider(
                value: _currentExposureOffset,
                min: _minAvailableExposureOffset,
                max: _maxAvailableExposureOffset,
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                onChanged: (value) async {
                  setState(() {
                    _currentExposureOffset = value;
                  });
                  await _controller?.setExposureOffset(value);
                },
              ),
            ),
          ),
        )
      ]),
    ),
  );

  Future _startLiveFeed() async {
    _startProcessing();
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
