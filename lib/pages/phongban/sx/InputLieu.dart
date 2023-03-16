import 'dart:async';
import 'dart:convert';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:audioplayers/audioplayers.dart';

const defaultPlayerCount = 4;

class InputLieu extends StatefulWidget {
  const InputLieu({Key? key}) : super(key: key);
  @override
  _InputLieuState createState() => _InputLieuState();
}

class _InputLieuState extends State<InputLieu> {
  String _scanBarcode = 'Unknown';
  String _PLAN_ID = '3CF0005B';
  String _EMPL_NO = 'NHU1903';
  String _M_LOT_NO = '2201010001';
  String _MACHINE_NO = 'ED01';

  final TextEditingController _controller_PLAN_ID = TextEditingController();
  final TextEditingController _controller_EMPL_NO = TextEditingController();
  final TextEditingController _controller_M_LOT_NO = TextEditingController();
  final TextEditingController _controller_MACHINE_NO = TextEditingController();

  @override
  void initState() {
    super.initState();
    LocalDataAccess.getVariable('userData').then(
      (value) {
        setState(() {
          Map<String, dynamic> rawJson = jsonDecode(value);
          _EMPL_NO = rawJson['EMPL_NO'];
        });
      },
    );
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) {
      //Get.snackbar('Code', barcode);
      print(barcode);
      //FlutterBeep.beep();
      FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_CONFIRM);
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_CONFIRM);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal(String type) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      if (type == 'PLAN_ID') {
        _PLAN_ID = barcodeScanRes;
        _controller_PLAN_ID.text = barcodeScanRes;
      } else if (type == 'EMPL_NO') {
        _EMPL_NO = barcodeScanRes;
        _controller_EMPL_NO.text = barcodeScanRes;
      } else if (type == 'M_LOT_NO') {
        _M_LOT_NO = barcodeScanRes;
        _controller_M_LOT_NO.text = barcodeScanRes;
      } else if (type == 'MACHINE_NO') {
        _MACHINE_NO = barcodeScanRes;
        _controller_MACHINE_NO.text = barcodeScanRes;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan Lieu Input'),
        ),
        body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            child: ListView(children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "PLAN_ID:",
                          hintText: "Quét PLAN_ID",
                        ),
                        onTap: () {
                          scanBarcodeNormal("PLAN_ID");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _controller_PLAN_ID,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "M_LOT_NO:",
                          hintText: "Quét M_LOT_NO",
                        ),
                        onTap: () {
                          scanBarcodeNormal("M_LOT_NO");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _controller_M_LOT_NO,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "EMPL_NO:",
                          hintText: "Quét EMPL_NO",
                        ),
                        onTap: () {
                          scanBarcodeNormal("EMPL_NO");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _controller_EMPL_NO,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "MACHINE:",
                          hintText: "Quét MACHINE",
                        ),
                        onTap: () {
                          scanBarcodeNormal("MACHINE_NO");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _controller_MACHINE_NO,
                      ),
                    ]),
              ),
              /*    ElevatedButton(
                  onPressed: () => scanBarcodeNormal('PLAN_ID'),
                  child: const Text('Start barcode scan')),
              ElevatedButton(
                  onPressed: () => scanQR(),
                  child: const Text('Start QR scan')),
              ElevatedButton(
                  onPressed: () => startBarcodeScanStream(),
                  child: const Text('Start barcode scan stream')), */
              ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Thông báo',
                        'PLAN_ID: $_PLAN_ID, M_LOT_NO: $_M_LOT_NO, EMPL_NO: $_EMPL_NO, MACHINE_NO: $_MACHINE_NO');
                  },
                  child: const Text('Input')),
            ])));
  }
}
