import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:shared_preferences/shared_preferences.dart';

const defaultPlayerCount = 4;

class InputLieu extends StatefulWidget {
  const InputLieu({Key? key}) : super(key: key);
  @override
  _InputLieuState createState() => _InputLieuState();
}

class _InputLieuState extends State<InputLieu> {
  bool _useScanner = true;
  String _token = "reset";
  String _scanBarcode = '';
  String _PLAN_ID = '';
  String _EMPL_NO = '';
  String _M_LOT_NO = '';
  String _MACHINE_NO = '';
  String _G_NAME = '';
  String _M_NAME = '';
  String _M_SIZE = '';
  String _PLAN_EQ = '';
  String _EMPL_NAME = '';
  final TextEditingController _controller_PLAN_ID = TextEditingController();
  final TextEditingController _controller_EMPL_NO = TextEditingController();
  final TextEditingController _controller_M_LOT_NO = TextEditingController();
  final TextEditingController _controller_MACHINE_NO = TextEditingController();
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? 'reset';
    return savedToken;
  }

  Future<void> checkPLAN_ID_INFO(String planId) async {
    API_Request.api_query('checkPLAN_ID', {
      'token_string': _token,
      'PLAN_ID': planId,
    }).then((value) => {
          setState((() {
            if (value['tk_status'] == 'OK') {
              var response = value['data'][0];
              //print(response['INS_EMPL']);
              _G_NAME = response['G_NAME'];
              _PLAN_EQ = response['PLAN_EQ'];
              _controller_MACHINE_NO.text = response['PLAN_EQ'];
            } else {
              _controller_PLAN_ID.text = '-1';
              Get.snackbar('Thông báo', 'Có lỗi: + ${value['message']}',
                  duration: const Duration(seconds: 1));
            }
          }))
        });
  }

  Future<void> checkM_LOT_NO_INFO(String mLotNo, String planId) async {
    API_Request.api_query('check_xuat_kho_ao_mobile', {
      'token_string': _token,
      'PLAN_ID': planId,
      'M_LOT_NO': mLotNo,
    }).then((value) => {
          setState((() {
            if (value['tk_status'] == 'OK') {
              var response = value['data'][0];
              _M_NAME = response['M_NAME'].toString();
              _M_SIZE = response['WIDTH_CD'].toString();
            } else {
              _controller_M_LOT_NO.text = '-1';
              Get.snackbar('Thông báo',
                  'Có lỗi: lot liệu không đúng hoặc chưa được xuất cho chỉ thị này: + ${value['message'].toString()}',
                  duration: const Duration(seconds: 1));
            }
          }))
        });
  }

  Future<void> check_EMPL_NO(String emplNo) async {
    API_Request.api_query('checkEMPL_NO_mobile', {
      'token_string': _token,
      'EMPL_NO': emplNo,
    }).then((value) => {
          setState((() {
            if (value['tk_status'] == 'OK') {
              var response = value['data'][0];
              _EMPL_NO = response['EMPL_NO'].toString();
              _EMPL_NAME =
                  '${response['MIDLAST_NAME']} ${response['FIRST_NAME']}';
            } else {
              _controller_EMPL_NO.text = '-1';
              _EMPL_NAME = '';
              Get.snackbar('Thông báo', 'Có lỗi: + ${value['message']}',
                  duration: const Duration(seconds: 1));
            }
          }))
        });
  }

  @override
  void initState() {
    super.initState();
    _controller_EMPL_NO.text = '';
    _controller_PLAN_ID.text = '';
    _controller_M_LOT_NO.text = '';
    _controller_MACHINE_NO.text = '';
    LocalDataAccess.getVariable('userData').then(
      (value) {
        setState(() {
          Map<String, dynamic> rawJson = jsonDecode(value);
          _EMPL_NO = rawJson['EMPL_NO'];
          _controller_EMPL_NO.text = rawJson['EMPL_NO'];
          _EMPL_NAME = rawJson['MIDLAST_NAME'] + ' ' + rawJson['FIRST_NAME'];
        });
      },
    );
    _getToken().then((value) => {_token = value});
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
      //FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
      FlutterBeep.beep();
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
        checkPLAN_ID_INFO(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'EMPL_NO') {
        _EMPL_NO = barcodeScanRes;
        _controller_EMPL_NO.text = barcodeScanRes;
        check_EMPL_NO(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'M_LOT_NO') {
        _M_LOT_NO = barcodeScanRes;
        _controller_M_LOT_NO.text = barcodeScanRes;
        checkM_LOT_NO_INFO(barcodeScanRes, _PLAN_ID);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'MACHINE_NO') {
        _MACHINE_NO = barcodeScanRes;
        _controller_MACHINE_NO.text = barcodeScanRes;
        //Get.snackbar('Thông báo', barcodeScanRes);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CMS VINA: Scan Input Material'),
        ),
        body: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16),
            child: ListView(children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "EMPL_NO:",
                          hintText: "Quét EMPL_NO",
                        ),
                        onTap: () {
                          if (_useScanner) {
                            scanBarcodeNormal("EMPL_NO");
                          }
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Phải quét mã vạch';
                          }
                          return null;
                        },
                        controller: _controller_EMPL_NO,
                      ),
                      Text(
                        'PIC: $_EMPL_NAME',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 30, 7, 233)),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "MACHINE:",
                          hintText: "Quét MACHINE",
                        ),
                        onTap: () {
                          if (_useScanner) scanBarcodeNormal("MACHINE_NO");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Phải quét mã vạch';
                          }
                          return null;
                        },
                        controller: _controller_MACHINE_NO,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "PLAN_ID:",
                          hintText: "Quét PLAN_ID",
                        ),
                        onTap: () {
                          if (_useScanner) scanBarcodeNormal("PLAN_ID");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Phải quét mã vạch';
                          }
                          return null;
                        },
                        controller: _controller_PLAN_ID,
                        onChanged: (value) {
                          Get.snackbar('Thông báo', value);
                        },
                      ),
                      Text(
                        'CODE: ${_G_NAME}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "M_LOT_NO:",
                          hintText: "Quét M_LOT_NO",
                        ),
                        onTap: () {
                          if (_useScanner) scanBarcodeNormal("M_LOT_NO");
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Lot liệu không đúng hoặc chưa được xuất cho chỉ thị này';
                          }
                          return null;
                        },
                        controller: _controller_M_LOT_NO,
                      ),
                      Text(
                        'LIỆU: ${_M_NAME} | SIZE: ${_M_SIZE}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 10, 176, 226)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.green,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: _useScanner,
                            onChanged: (bool? value) {
                              setState(() {
                                _useScanner = value!;
                              });
                            },
                          ),
                          Text('Dùng camera')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Get.snackbar('Thông báo',
                                      'PLAN_ID: $_PLAN_ID, M_LOT_NO: $_M_LOT_NO, EMPL_NO: $_EMPL_NO, MACHINE_NO: $_MACHINE_NO',
                                      duration:
                                          const Duration(milliseconds: 800));
                                  setState(() {
                                    _controller_M_LOT_NO.text = '';
                                    _M_LOT_NO = '';
                                    _M_NAME = '';
                                    _M_SIZE = '';
                                  });
                                }
                              },
                              child: const Text('Input')),
                          ElevatedButton(
                              onPressed: () {
                                GlobalFunction.logout();
                                Get.to(const LoginPage());
                              },
                              child: const Text('Back')),
                        ],
                      ),
                    ]),
              ),
            ])));
  }
}
