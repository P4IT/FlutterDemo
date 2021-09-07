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

  @override
  void initState() {
    super.initState();
  }

  void handleLicenseEvent(Map event) async {
    if(event["body"]["FunctionName"].compareTo('onActivationResult') == 0) {
      String value = await FlutterCidscan.decoderVersion();
      print(value);
    }
  }

  void handleInit(Map event) async {
    if(event["body"]["FunctionName"].compareTo('initCaptureID') == 0) {
      FlutterCidscan.activateEDKLicense(
          'HetpZ4Bk0ivwF6dhHIHmbQH5ALUMOb/cQB5+I3fdD2LV5Yrm1sxkbrVL1X8vL4S55O7hmCQhGPCemfH/mUTz5yy3ip3TQDJU2pCeU3Zjbb3kyVdPYGdn59dPGFdv+aXdrIIRQHizRtbsC8NamuxWaRAGTfTGCM/IhEKvxkQO0ONSneBYSrY8OHpcEK7EVKCDSl3JQNJwHVWbpJDcIoR/WRVMSlJ/e9/qFOM3mPhwVJ1FCDF+e94mKpHQzOlRffJ/Zm2Mv1+UKJwriC/VpWK7+N1KJ9EZChf8U0MSdrMxSTGCxVZzZbTbt+pflWv2jUD9yFxHGbuyHVvpqnk0PUpFxF5VLIZy9kIesTg3ZSiho6kGTOY1bdGfqW3NppYmh1H0eCxQquhn5RitL74LwuLmKw==',
          'P4I082220190001').listen((event) => { handleLicenseEvent(event) });
    }
  }

  void handleDecode(Map event) {
    print(event);
    if(event["body"]["FunctionName"].compareTo('receivedDecodedData') == 0) {

    }
  }

  void startDecode(){
    FlutterCidscan.startDecoding().listen((event) => { handleDecode(event) });
  }

  Future<void> init() async {
    FlutterCidscan.initCaptureID('Wir benötigen die Kamera Berechtigung zum Scannen der Barcodes', false, true).listen((event) => { handleInit(event) });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: const Text('Plugin example app'),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              children: [
                Column(),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                      onPressed: () => {init()},
                      child: Text('Init')
                    ),
                  ]
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: CIDScanView(
                  ),
                ),
                TextButton(onPressed: () => {startDecode()}, child: Text('Decode')),
                Column(),
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}
