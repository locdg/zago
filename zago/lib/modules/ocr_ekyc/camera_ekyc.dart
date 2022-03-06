import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:zago/common/abstract/my_loc.dart';
import 'package:zago/common/routes/animate_routes.dart';
import 'package:zago/common/routes/routes.dart';
import 'package:zago/modules/ocr_ekyc/camera_ekyc_bloc.dart';
import 'package:zago/modules/ocr_ekyc/ekyc_show_image_capture.dart';
import 'package:zago/utils/file_utils.dart';
import 'package:zago/utils/size_utils.dart';

class CameraEkyc extends StatefulWidget {
  const CameraEkyc({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<CameraEkyc> createState() => CameraEkycState();
}

class CameraEkycState extends State<CameraEkyc> with WidgetsBindingObserver {
  late CameraController controller;
  late Future<void> initiallizeControllerFuture;
  CameraEkycBloc bloc = CameraEkycBloc();
  bool isCapturePicture = false;
  TypeImageIDCard currentType = TypeImageIDCard.front;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.high);
    initiallizeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    controller.dispose();
    bloc.dispose();

    if (bloc.pathSaveIdCard.isNotEmpty) {
      for (var path in bloc.pathSaveIdCard) {
        FileUtils.deleteFile(path);
      }
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      dlog('State: ${state.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: const Text('Take a picture'),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: FutureBuilder<void>(
          future: initiallizeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final cameraPreview = CameraPreview(controller);
              return Stack(
                children: <Widget>[
                  CustomPaint(
                    foregroundPainter: Paint(),
                    child: cameraPreview,
                  ),
                  ClipPath(clipper: Clip(), child: cameraPreview),
                  buildBottomCamera()
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  // Build view bottom
  Align buildBottomCamera() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 150,
          color: Colors.black,
          child: Stack(
            children: [
              buildStreamBuilderImageCapture(),
              buildButtonCapture(),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () {
                      // Routes.push(context, ShowImageCapture());
                      Navigator.pushReplacement(context,
                          SlideRightRoute(page: const ShowImageCapture()));
                    },
                    child: const Text('Tiếp tục')),
              ),
            ],
          ),
        ));
  }

  // Build button chup anh
  AnimatedAlign buildButtonCapture() {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 400),
      alignment: Alignment.center,
      child: IconButton(
          color: Colors.white,
          iconSize: 70,
          onPressed: () {
            if (isCapturePicture || bloc.pathSaveIdCard.length == 2) {
              return;
            }
            isCapturePicture = true;
            captureImage();
          },
          icon: const Icon(Icons.camera_alt_rounded)),
    );
  }

  // Stream Builder 2 anh hien thi sau khi chup
  StreamBuilder<List<String>> buildStreamBuilderImageCapture() {
    return StreamBuilder<List<String>>(
        stream: bloc.streamShowImage,
        builder: (context, snapshot) {
          final list = snapshot.data ?? [];
          bool checkAnimatedPositioned2 = (list.isEmpty || list.length < 2);
          return Stack(children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: list.isEmpty ? 10 : 40,
                left: list.isEmpty ? -10 : 20,
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: list.isEmpty
                        ? const SizedBox()
                        : Image.file(File(list[0])))),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: checkAnimatedPositioned2 ? -10 : 20,
                left: checkAnimatedPositioned2 ? 10 : 40,
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: checkAnimatedPositioned2
                        ? const SizedBox()
                        : Image.file(File(list[1])))),
          ]);
        });
  }

  // Chup anh
  Future<void> captureImage() async {
    await initiallizeControllerFuture;
    controller.setFlashMode(FlashMode.off);
    final imageXfile = await controller.takePicture();
    bloc.saveImageIDCard(currentType, imageXfile.path);
    isCapturePicture = false;
    currentType = TypeImageIDCard.back;
  }
}

class Paint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey.withOpacity(0.8), BlendMode.dstOut);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Clip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(10, size.height / 2 - 150, size.width - 20, 300),
          const Radius.circular(26)));
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return true;
  }
}
