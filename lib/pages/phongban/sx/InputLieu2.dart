import 'dart:async';
import 'dart:convert';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:cms_flutter/pages/phongban/sx/InputMaterialList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ota_update/ota_update.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class InputLieu2 extends StatefulWidget {
  const InputLieu2({super.key});
  @override
  _InputLieu2State createState() => _InputLieu2State();
}
class _InputLieu2State extends State<InputLieu2> {
  bool _useScanner = false;
  String _token = "reset";
  String _planId = '';
  String _emplNo = '';
  String _mLotNo = '';
  String _mLotNo2 = '';
  String _machineNo = '';
  String _mName = '';
  String _mCode = '';
  String _mSize = '';
  String _checkEmplOK = 'NG';
  String _checkPlanIdOK = 'NG';
  String _checkMLotNoOK = 'NG';
  dynamic _planInfo;
  dynamic _userInfo;
  final GlobalController c = Get.put(GlobalController());
  final TextEditingController _controllerPlanId = TextEditingController();
  final TextEditingController _controllerEmplNo = TextEditingController();
  final TextEditingController _controllerMLotNo = TextEditingController();
  final TextEditingController _controllerMachineNo = TextEditingController();
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? 'reset';
    return savedToken;
  }
  late OtaEvent currentEvent = OtaEvent(OtaStatus.DOWNLOADING, 'Current Status');
  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute(
        'http://14.160.33.94:3010/update/cmsflutter.apk',
        destinationFilename: 'cms.apk',
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
          _machineNo = response['PLAN_EQ'];
          _controllerMachineNo.text = response['PLAN_EQ'];
          _planInfo = response;
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
      _mSize = mSize;
      _mName = mName;
      _mCode = mCode;
      _mLotNo = mLotNo;
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
              _emplNo = response['EMPL_NO'].toString();
              _userInfo = response;
              _checkEmplOK = 'OK';
            } else {
              _controllerEmplNo.text = '-1';
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
      'PLAN_ID_OUTPUT': _planId,
      'M_CODE': _mCode,
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
      'PROD_REQUEST_DATE': _planInfo['PROD_REQUEST_DATE'],
      'PROD_REQUEST_NO': _planInfo['PROD_REQUEST_NO'],
      'G_CODE': _planInfo['G_CODE'],
      'EMPL_NO': _emplNo,
      'phanloai': _machineNo,
      'PLAN_ID': _planId,
      'M_CODE': _mCode,
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
          'PLAN_ID_SUDUNG': _planId,
          'M_CODE': _mCode,
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
          'PLAN_ID_OUTPUT': _planId,
          'M_CODE': _mCode,
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
    await checkEmplNo(_emplNo);
    await checkPlanIdInfo(_planId);
    await checkMLotNoInfo(_mLotNo2, _planId);
    if ((_checkEmplOK == 'OK') &&
        (_checkMLotNoOK == 'OK') &&
        (_checkPlanIdOK == 'OK')) {
      //print('OK');
      await insertP500(_mLotNo, _planId);
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
          _emplNo = rawJson['EMPL_NO'];
          _controllerEmplNo.text = rawJson['EMPL_NO'];
          _userInfo = rawJson;
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
    setState(() {
      _planId = barcodeScanRes;
      _controllerPlanId.text = barcodeScanRes;
    });
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
        _planId = barcodeScanRes;
        _controllerPlanId.text = barcodeScanRes;
        checkPlanIdInfo(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'EMPL_NO') {
        _emplNo = barcodeScanRes;
        _controllerEmplNo.text = barcodeScanRes;
        checkEmplNo(barcodeScanRes);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'M_LOT_NO') {
        _mLotNo = barcodeScanRes;
        _controllerMLotNo.text = barcodeScanRes;
        checkMLotNoInfo(barcodeScanRes, _planId);
        //Get.snackbar('Thông báo', barcodeScanRes);
      } else if (type == 'MACHINE_NO') {
        _machineNo = barcodeScanRes;
        if (barcodeScanRes == _planInfo?['PLAN_EQ']) {
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
          backgroundColor: Colors.green,
          title: const Text('CMS VINA: Scan Input Material'),
        ),
        body: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16),
            child: ListView(  
              children: [
                Text('Input Material'),
                ElevatedButton(onPressed: (){
                  scanQR();

                }, child: Text('Start Scan')),
                Text('Scanned Data: $_planId'),
              ],
            )));
  }
}
