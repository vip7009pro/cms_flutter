import 'dart:async';
import 'dart:convert';
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
import 'package:moment_dart/moment_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ota_update/ota_update.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class NhatKyKT extends StatefulWidget {
  const NhatKyKT({super.key});
  @override
  _NhatKyKTState createState() => _NhatKyKTState();
}

class _NhatKyKTState extends State<NhatKyKT> {
  bool _useScanner = true;
  String _token = "reset";
  String _PLAN_ID = '';
  String _EMPL_NO = '';
  String _M_LOT_NO = '';
  final String _M_LOT_NO2 = '';
  String _MACHINE_NO = '';
  String _G_NAME = '';
  String _M_NAME = '';
  String _M_CODE = '';
  String _M_SIZE = '';
  String _PLAN_EQ = '';
  String _EMPL_NAME = '';
  String _checkEmplOK = 'NG';
  String _checkPlanIdOK = 'NG';
  String _checkMLotNoOK = 'NG';
  String _processLotNo = '';
  final String _lineQCEMPLNO = '';
  String _inspectStart = '';
  String _inspectStop = '';
  String _inspectQty = '';
  String _inspectOk = '';
  String _inspectNg = '';

  var _plan_info;
  var _user_info;
  var _processlotinfo;
  final GlobalController c = Get.put(GlobalController());
  final TextEditingController _controllerPlanId = TextEditingController();
  final TextEditingController _controllerEmplNo = TextEditingController();
  final TextEditingController _controllerMLotNo = TextEditingController();
  final TextEditingController _controllerProcessLotNo = TextEditingController();
  final TextEditingController _controllerMachineNo = TextEditingController();
  final TextEditingController _controllerInspectStart = TextEditingController();
  final TextEditingController _controllerInspectStop = TextEditingController();
  final TextEditingController _controllerInspectQty = TextEditingController();
  final TextEditingController _controllerInspectOK = TextEditingController();
  final TextEditingController _controllerInspectNG = TextEditingController();
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
    } on MissingPluginException {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Lỗi',
        desc: 'Thiếu pluggin/ Pluggin Missing Exception',
        btnCancelOnPress: () {},
        /* btnOkOnPress: () {}, */
      ).show();
    } catch (e) {
      //print('Failed to make OTA update. Details: $e');
    }
  }

  Future<void> checkPlanIdInfo(String planId) async {
    API_Request.api_query('checkPLAN_ID', {
      'token_string': _token,
      'PLAN_ID': planId,
    }).then((value) {
      setState((() {
        if (value['tk_status'] == 'OK') {
          var response = value['data'][0];
          //print(response['INS_EMPL']);
          _G_NAME = response['G_NAME'];
          _PLAN_EQ = response['PLAN_EQ'];
          _MACHINE_NO = response['PLAN_EQ'];
          _controllerMachineNo.text = response['PLAN_EQ'];
          _plan_info = response;
          _checkPlanIdOK = 'OK';
        } else {
          _controllerPlanId.text = '-1';
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
      }));
    });
  }

  Future<void> checkProcessLotNo(String processLotNo) async {
    API_Request.api_query('mobile_checkProcessLotNo', {
      'token_string': _token,
      'PROCESS_LOT_NO': processLotNo.length > 8
          ? processLotNo.substring(11, 19)
          : processLotNo,
    }).then((value) {
      setState((() {
        if (value['tk_status'] == 'OK') {
          var response = value['data'][0];
          _processlotinfo = response;
          _controllerInspectQty.text = '1331';
          _controllerInspectStart.text = _processlotinfo['INSPECT_START'] ?? '';
          _controllerInspectStop.text = _processlotinfo['INSPECT_STOP'] ?? '';
        } else {
          _controllerPlanId.text = '-1';
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Thông báo',
            desc: 'Không có lot sản xuất này / 생산 LOT 번호 존재하지 않습니다',
            btnCancelOnPress: () {},
            /* btnOkOnPress: () {}, */
          ).show();
          Get.snackbar('Thông báo', 'Có lỗi: + ${value['message']}',
              duration: const Duration(seconds: 1));
        }
      }));
    });
  }

  Future<void> checkMLotNoInfo(String mLotNo, String planId) async {
    bool mLotNoExistOutKhoAo = false;
    bool mLotNoExistInP500 = false;
    String mName = '', mSize = '', mCode = '';
    await API_Request.api_query('check_xuat_kho_ao_mobile', {
      'token_string': _token,
      'PLAN_ID': planId,
      'M_LOT_NO': mLotNo,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        var response = value['data'][0];
        mName = response['M_NAME'].toString();
        mSize = response['WIDTH_CD'].toString();
        mCode = response['M_CODE'].toString();
        mLotNoExistOutKhoAo = true;
      } else {
        mLotNoExistOutKhoAo = false;
      }
    });
    await API_Request.api_query('checkM_LOT_NO_p500_mobile', {
      'token_string': _token,
      'PLAN_ID': planId,
      'M_LOT_NO': mLotNo,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        mLotNoExistInP500 = true;
      } else {
        mLotNoExistInP500 = false;
      }
    });
    setState(() {
      _M_SIZE = mSize;
      _M_NAME = mName;
      _M_CODE = mCode;
      _M_LOT_NO = mLotNo;
      if (!mLotNoExistOutKhoAo) {
        _controllerMLotNo.text = '-1';
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
      } else if (mLotNoExistInP500) {
        _controllerMLotNo.text = '-1';
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Lỗi',
          desc:
              'Lot liệu đã bắn lot cho chỉ thị này rồi /이 LOT 번호가 이미 투입 처리 완료 되었습니다',
          btnCancelOnPress: () {},
          /* btnOkOnPress: () {}, */
        ).show();
      } else if (mLotNoExistOutKhoAo && !mLotNoExistInP500) {
        _checkMLotNoOK = 'OK';
        //Get.snackbar('Thông báo', 'Lot liệu input OK');
      }
    });
  }

  Future<void> checkEmplNo(String emplNo) async {
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
              _checkEmplOK = 'OK';
            } else {
              _controllerEmplNo.text = '-1';
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

  Future<void> insertP500(String mLotNo, String planId) async {
    String nextP500InNo = '001';
    bool insertP500Success = false;
    String totalOutQty = '', planIdInput = '', inKhoId = '';
    bool checkPlanIdInput = false;
    await API_Request.api_query('checkProcessInNoP500', {
      'token_string': _token,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        var response = value['data'][0];
        nextP500InNo = (int.parse(response['PROCESS_IN_NO']) + 1)
            .toString()
            .padLeft(3, '0');
      } else {
        nextP500InNo = '001';
      }
    });

    await API_Request.api_query('checkOutKhoSX_mobile', {
      'token_string': _token,
      'PLAN_ID_OUTPUT': _PLAN_ID,
      'M_CODE': _M_CODE,
      'M_LOT_NO': mLotNo,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        var response = value['data'][0];
        totalOutQty = response['TOTAL_OUT_QTY'].toString();
        planIdInput = response['PLAN_ID_INPUT'].toString();
        inKhoId = response['IN_KHO_ID'].toString();
        checkPlanIdInput = true;
      } else {}
    }).catchError((onError) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Lỗi',
        desc: '$onError',
        btnCancelOnPress: () {},
        /* btnOkOnPress: () {}, */
      ).show();
      //print(onError);
    });

    await API_Request.api_query('insert_p500_mobile', {
      'token_string': _token,
      'in_date': Moment.now().format('YYYYMMDD'),
      'next_process_in_no': nextP500InNo,
      'PROD_REQUEST_DATE': _plan_info['PROD_REQUEST_DATE'],
      'PROD_REQUEST_NO': _plan_info['PROD_REQUEST_NO'],
      'G_CODE': _plan_info['G_CODE'],
      'EMPL_NO': _EMPL_NO,
      'phanloai': _MACHINE_NO,
      'PLAN_ID': _PLAN_ID,
      'M_CODE': _M_CODE,
      'M_LOT_NO': mLotNo,
      'INPUT_QTY': totalOutQty,
      'IN_KHO_ID': inKhoId
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        //var response = value['data'][0];
        insertP500Success = true;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Input liệu thành công / 원단 투입 처리 완료 되었습니다',
          /* btnCancelOnPress: () {}, */
          btnOkOnPress: () {},
        ).show();
        setState(() {
          _checkEmplOK = 'NG';
          _checkMLotNoOK = 'NG';
          _checkPlanIdOK = 'NG';
        });
      } else {
        insertP500Success = false;
      }
    });
    if (insertP500Success) {
      if (checkPlanIdInput) {
        await API_Request.api_query('setUSE_YN_KHO_AO_INPUT_mobile', {
          'token_string': _token,
          'PLAN_ID_INPUT': planIdInput,
          'PLAN_ID_SUDUNG': _PLAN_ID,
          'M_CODE': _M_CODE,
          'M_LOT_NO': mLotNo,
          'TOTAL_IN_QTY': totalOutQty,
          'USE_YN': 'X',
        }).then((value) {
          if (value['tk_status'] == 'OK') {
            //var response = value['data'][0];
          } else {}
        }).catchError((onError) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'Lỗi',
            desc: '$onError',
            btnCancelOnPress: () {},
            /* btnOkOnPress: () {}, */
          ).show();
          //print(onError);
        });
        await API_Request.api_query('setUSE_YN_KHO_AO_OUTPUT_mobile', {
          'token_string': _token,
          'PLAN_ID_OUTPUT': _PLAN_ID,
          'M_CODE': _M_CODE,
          'M_LOT_NO': mLotNo,
          'TOTAL_OUT_QTY': totalOutQty,
          'USE_YN': 'X',
        }).then((value) {
          if (value['tk_status'] == 'OK') {
            //var response = value['data'][0];
          } else {}
        }).catchError((onError) {
          //print(onError);
        });
      } else {}
    } else {}
  }

  Future<void> insertP500NoCamera() async {
    //check EMPL_NO
    await checkEmplNo(_EMPL_NO);
    //check PLAN_ID
    await checkPlanIdInfo(_PLAN_ID);
    //check M_LOT_NO
    await checkMLotNoInfo(_M_LOT_NO2, _PLAN_ID);
    //insert P500
    print(_checkEmplOK);
    print(_checkMLotNoOK);
    print(_checkPlanIdOK);
    if ((_checkEmplOK == 'OK') &&
        (_checkMLotNoOK == 'OK') &&
        (_checkPlanIdOK == 'OK')) {
      //print('OK');
      await insertP500(_M_LOT_NO, _PLAN_ID);
    }
  }

  @override
  void initState() {
    super.initState();
    //tryOtaUpdate();
    _controllerEmplNo.text = '';
    _controllerPlanId.text = '';
    _controllerMLotNo.text = '';
    _controllerMachineNo.text = '';
    LocalDataAccess.getVariable('userData').then(
      (value) {
        setState(() {
          Map<String, dynamic> rawJson = jsonDecode(value);
          _EMPL_NO = rawJson['EMPL_NO'];
          _controllerEmplNo.text = rawJson['EMPL_NO'];
          _EMPL_NAME = rawJson['MIDLAST_NAME'] + ' ' + rawJson['FIRST_NAME'];
          _user_info = rawJson;
        });
      },
    );
    LocalDataAccess.getVariable('useCamera').then(
      (value) {
        setState(() {
          if (value != '') {
            _useScanner = true;
          } else {
            _useScanner = false;
          }
          _useScanner = true;
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
      //print(barcode);
      //FlutterBeep.beep();
      FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_CONFIRM);
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print(barcodeScanRes);
      FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_CONFIRM);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {});
  }

  Future<void> scanBarcodeNormal(String type) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      //FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
      FlutterBeep.beep();
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } on MissingPluginException {
      barcodeScanRes = 'Missing Plugin Exceltion';
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Lỗi',
        desc: 'Chưa có plugin / Plugin missing',
        /* btnCancelOnPress: () {}, */
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      //print(e.toString());
      barcodeScanRes = e.toString();
    }
    if (!mounted) return;
    setState(() {
      if (type == 'PLAN_ID') {
        _PLAN_ID = barcodeScanRes;
        _controllerPlanId.text = barcodeScanRes;
        checkPlanIdInfo(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'EMPL_NO') {
        _EMPL_NO = barcodeScanRes;
        _controllerEmplNo.text = barcodeScanRes;
        checkEmplNo(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'M_LOT_NO') {
        _M_LOT_NO = barcodeScanRes;
        _controllerMLotNo.text = barcodeScanRes;
        checkMLotNoInfo(barcodeScanRes, _PLAN_ID);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'PROCESS_LOT_NO') {
        _processLotNo = barcodeScanRes;
        _controllerProcessLotNo.text = barcodeScanRes;
        checkProcessLotNo(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'MACHINE_NO') {
        _MACHINE_NO = barcodeScanRes;
        if (barcodeScanRes == _plan_info?['PLAN_EQ']) {
          _controllerMachineNo.text = barcodeScanRes;
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
          _controllerMachineNo.text = barcodeScanRes;
        }
        //Get.snackbar('Thông báo', barcodeScanRes);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
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
          backgroundColor: const Color.fromARGB(255, 255, 91, 255),
          title: const Text('CMS VINA: Scan Input Nhật Ký Sản Xuất'),
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
                          labelText: "Mã nhân viên kiểm tra:",
                          hintText: "Quét mã người kiểm",
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
                        controller: _controllerEmplNo,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _EMPL_NO = value;
                          });
                        },
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
                          labelText: "LOT SX:",
                          hintText: "Quét LOTSX",
                        ),
                        onTap: () {
                          if (_useScanner) scanBarcodeNormal("PROCESS_LOT_NO");
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
                        controller: _controllerProcessLotNo,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _processLotNo = value;
                          });
                        },
                      ),
                      Text(
                        'CODE: ${_processlotinfo?['G_NAME'].toString() ?? ''} | ${_processlotinfo?['PLAN_EQ'].toString() ?? ''}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: "Giờ bắt đầu kiểm",
                          hintText: "Nhập giờ BĐ kiểm",
                        ),
                        onTap: () {},
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Giá trị nhập không hợp lệ';
                          }
                          return null;
                        },
                        controller: _controllerInspectStart,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _inspectStart = value;
                          });
                        },
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: "Giờ kết thúc kiểm",
                          hintText: "Nhập giờ KT kiểm",
                        ),
                        onTap: () {},
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Giá trị nhập không hợp lệ';
                          }
                          return null;
                        },
                        controller: _controllerInspectStop,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _inspectStop = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Số lượng kiểm tra",
                          hintText: "Nhập số lượng kiểm tra",
                        ),
                        onTap: () {},
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
                          }
                          return null;
                        },
                        controller: _controllerInspectQty,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _inspectQty = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Số lượng OK",
                          hintText: "Nhập số lượng OK",
                        ),
                        onTap: () {},
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
                          }
                          return null;
                        },
                        controller: _controllerInspectOK,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _inspectOk = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Số lượng NG",
                          hintText: "Nhập số lượng NG",
                        ),
                        onTap: () {},
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString() == '-1') {
                            return 'Phải quét mã vạch/ 바코드 스캔해야 합니다';
                          }
                          return null;
                        },
                        controller: _controllerInspectNG,
                        onChanged: (value) {
                          //Get.snackbar('Thông báo', value);
                          setState(() {
                            _inspectNg = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.green,
                            fillColor:
                                WidgetStateProperty.resolveWith(getColor),
                            value: _useScanner,
                            onChanged: /* null */ (bool? value) {
                              setState(() {
                                _useScanner = value!;
                                if (value == true) {
                                  LocalDataAccess.saveVariable(
                                      'useCamera', 'OK');
                                } else {
                                  LocalDataAccess.saveVariable('useCamera', '');
                                }
                              });
                            },
                          ),
                          const Text('Dùng camera')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_useScanner) {
                                    //insertP500(_M_LOT_NO, _PLAN_ID);
                                  } else {
                                    //insertP500NoCamera();
                                  }

                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'Thông báo',
                                    desc: 'Nhập nhật ký thành công',
                                    /* btnCancelOnPress: () {}, */
                                    btnOkOnPress: () {},
                                  ).show();

                                  setState(() {
                                    _controllerProcessLotNo.text = '';
                                    _processLotNo = '';
                                    _EMPL_NO = '';
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
                                    Get.off(() => const LoginPage());
                                  },
                                ).show();
                              },
                              child: const Text('Back')),
                        ],
                      ),

                      /* Text(
                          'OTA status: ${currentEvent.status} : ${currentEvent.value} \n'), */
                    ]),
              ),
            ])));
  }
}
