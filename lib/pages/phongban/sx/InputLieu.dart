import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ota_update/ota_update.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  var _plan_info;
  var _user_info;

  final GlobalController c = Get.put(GlobalController());

  final TextEditingController _controller_PLAN_ID = TextEditingController();
  final TextEditingController _controller_EMPL_NO = TextEditingController();
  final TextEditingController _controller_M_LOT_NO = TextEditingController();
  final TextEditingController _controller_MACHINE_NO = TextEditingController();
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? 'reset';
    return savedToken;
  }

  late OtaEvent currentEvent =
      OtaEvent(OtaStatus.DOWNLOADING, 'Current Status');

  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES

      OtaUpdate()
          .execute(
        'http://14.160.33.94:3010/update/cmsflutter.apk',
        destinationFilename: 'cmsflutter.apk',
        //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        /* sha256checksum:
            'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478', */
      )
          .listen(
        (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
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
              _plan_info = response;
            } else {
              _controller_PLAN_ID.text = '-1';
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Thông báo',
                desc: 'Không có số chỉ thị này / 지시번호 존재하지 않습니다',
                btnCancelOnPress: () {},
                /* btnOkOnPress: () {}, */
              ).show();
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
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Lỗi',
                desc:
                    'Lot liệu không đúng hoặc chưa được xuất cho chỉ thị này / LOT No 잘 못 입력하거나 이 지시 번호에 출고 된 Lot No 아닙니다',
                btnCancelOnPress: () {},
                /* btnOkOnPress: () {}, */
              ).show();
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
              _user_info = response;
            } else {
              _controller_EMPL_NO.text = '-1';
              _EMPL_NAME = '';
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Có lỗi',
                desc: 'Không có nhân viên này / 이 직원 ID가 존재하지 않습니다',
                btnCancelOnPress: () {},
                /* btnOkOnPress: () {}, */
              ).show();
              Get.snackbar('Thông báo', 'Có lỗi: + ${value['message']}',
                  duration: const Duration(seconds: 1));
            }
          }))
        });
  }

  @override
  void initState() {
    super.initState();
    //tryOtaUpdate();
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
          _user_info = rawJson;
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
        if (barcodeScanRes == _plan_info?['PLAN_EQ']) {
          _controller_MACHINE_NO.text = barcodeScanRes;
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Cảnh báo',
            desc: 'Máy input khác so với chỉ thị / 지시된 호기와 다릅니다',
            btnCancelOnPress: () {},
            /* btnOkOnPress: () {}, */
          ).show();
          _controller_MACHINE_NO.text = barcodeScanRes;
        }

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
                          labelText: "EMPL_NO/사원ID:",
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
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
                          }
                          return null;
                        },
                        controller: _controller_EMPL_NO,
                      ),
                      Text(
                        'PIC: ${_user_info?['MIDLAST_NAME'].toString() ?? ''} ${_user_info?['FIRST_NAME'].toString() ?? ''}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 30, 7, 233)),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "PLAN_ID/지시 번호:",
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
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
                          }
                          return null;
                        },
                        controller: _controller_PLAN_ID,
                        onChanged: (value) {
                          Get.snackbar('Thông báo', value);
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "MACHINE/호기:",
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
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
                          }
                          return null;
                        },
                        controller: _controller_MACHINE_NO,
                      ),
                      Text(
                        'CODE: ${_plan_info?['G_NAME'].toString() ?? ''} | ${_plan_info?['PLAN_EQ'].toString() ?? ''}',
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
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
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
                            color: Color.fromARGB(255, 243, 8, 192)),
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
                          const Text('Dùng camera')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'Thông báo',
                                    desc:
                                        'Input liệu thành công / 원단 투입 처리 완료 되었습니다',
                                    /* btnCancelOnPress: () {}, */
                                    btnOkOnPress: () {},
                                  ).show();
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
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.rightSlide,
                                  title: 'Cảnh báo',
                                  desc: 'Bạn muốn logout? / Logout 하시겠습니까?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    GlobalFunction.logout();
                                    Get.to(const LoginPage());
                                  },
                                ).show();
                              },
                              child: const Text('Back')),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            /* c.mytimer.cancel(); */
                          },
                          child: const Text('Stop Timer')),
                      /* Text(
                          'OTA status: ${currentEvent.status} : ${currentEvent.value} \n'), */
                    ]),
              ),
            ])));
  }
}
