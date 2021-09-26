import 'package:flutter/material.dart';
import 'package:flutter_cidscan/cidscanview.dart';
import 'package:flutter_cidscan/flutter_cidscan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var activeTL = false;
  var _visible = false;

  @override
  void initState() {
    super.initState();
  }

  void handleLicenseEvent(Map event) async {
    if (event["body"]["FunctionName"].compareTo('onActivationResult') == 0) {
      String value = await FlutterCidscan.decoderVersion();
      print(value);
    }
  }

  void handleInit(Map event) async {
    if (event["body"]["FunctionName"].compareTo('initCaptureID') == 0) {
      FlutterCidscan.activateEDKLicense(
              'HetpZ4Bk0ivwF6dhHIHmbQH5ALUMOb/cQB5+I3fdD2LV5Yrm1sxkbrVL1X8vL4S55O7hmCQhGPCemfH/mUTz5yy3ip3TQDJU2pCeU3Zjbb3kyVdPYGdn59dPGFdv+aXdrIIRQHizRtbsC8NamuxWaRAGTfTGCM/IhEKvxkQO0ONSneBYSrY8OHpcEK7EVKCDSl3JQNJwHVWbpJDcIoR/WRVMSlJ/e9/qFOM3mPhwVJ1FCDF+e94mKpHQzOlRffJ/Zm2Mv1+UKJwriC/VpWK7+N1KJ9EZChf8U0MSdrMxSTGCxVZzZbTbt+pflWv2jUD9yFxHGbuyHVvpqnk0PUpFxF5VLIZy9kIesTg3ZSiho6kGTOY1bdGfqW3NppYmh1H0eCxQquhn5RitL74LwuLmKw==',
              'P4I082220190001')
          .listen((event) => {handleLicenseEvent(event)});
    }
  }

  void torchlight() {
    if (!activeTL) {
      activeTL = true;
      FlutterCidscan.setTorch(true);
    } else {
      activeTL = false;
      FlutterCidscan.setTorch(false);
    }
  }

  void handleDecode(Map event) {
    print(event);
    if (event["body"]["FunctionName"].compareTo('receivedDecodedData') == 0) {}
  }

  void _toggle() {
    if(_visible){
      FlutterCidscan.closeCamera();
    }
    setState(() {
      _visible = !_visible;
    });
  }

  void startDecode() {
    FlutterCidscan.startDecoding().listen((event) => {handleDecode(event)});
  }

  Future<void> init() async {
    FlutterCidscan.initCaptureID(
            'Wir benötigen die Kamera Berechtigung zum Scannen der Barcodes',
            false,
            true)
        .listen((event) => {handleInit(event)});
  }

  clicker() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          color: Color(0xff619ff9),
        ),
        Visibility(
          visible: _visible,
          child: Container(
            height: 400.0,
            width: 400.0,
            child: new Directionality(
              textDirection: TextDirection.ltr,
              child: CIDScanView(
                onCIDScanViewCreated: null,
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 30,
          child: Container(
            alignment: Alignment.topCenter,
            height: 50,
            width: 50,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: TextButton(
                    onPressed: _toggle,
                    child: Image(
                      alignment: Alignment.center,
                      matchTextDirection: true,
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
          top: 70,
          right: 30,
          child: Container(
            alignment: Alignment.topCenter,
            height: 50,
            width: 50,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: TextButton(
                    onPressed: torchlight,
                    child: Image(
                      alignment: Alignment.center,
                      matchTextDirection: true,
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 50,
            width: 150,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: TextButton(
                  onPressed: _toggle,
                  child: Text(
                    'Starten',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
