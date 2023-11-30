import 'dart:convert';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}
class _HomeWidgetState extends State<HomeWidget> {
  UserData _myUserData = UserData(
      aDDCOMMUNE: '',
      aDDDISTRICT: '',
      aDDPROVINCE: '',
      aDDVILLAGE: '',
      aTTGROUPCODE: 0,
      cMSID: '',
      cTRCD: '',
      dOB: '2023-11-30',
      eMAIL: '',
      eMPLNO: '',
      fACTORYCODE: 1,
      fACTORYNAME: '',
      fACTORYNAMEKR: '',
      fIRSTNAME: '',
      hOMETOWN: '',
      jOBCODE: 0,
      jOBNAME: '',
      jOBNAMEKR: '',
      mAINDEPTCODE: 0,
      mAINDEPTNAME: '',
      mAINDEPTNAMEKR: '',
      mIDLASTNAME: '',
      oNLINEDATETIME: '',
      pASSWORD: '',
      pHONENUMBER: '',
      pOSITIONCODE: 0,
      pOSITIONNAME: '',
      pOSITIONNAMEKR: '',
      rEMARK: '',
      sEXCODE: 0,
      sEXNAME: '',
      sEXNAMEKR: '',
      sUBDEPTCODE: 0,
      sUBDEPTNAME: '',
      sUBDEPTNAMEKR: '',
      wORKPOSITIONCODE: 0,
      wORKPOSITIONNAME: '',
      wORKPOSITIONNAMEKR: '',
      wORKSHIFNAME: '',
      wORKSHIFNAMEKR: '',
      wORKSHIFTCODE: 0,
      wORKSTARTDATE: '',
      wORKSTATUSCODE: 0,
      wORKSTATUSNAME: '',
      wORKSTATUSNAMEKR: '');
  String _minTime= "Chưa chấm";
  String _maxTime= "Chưa chấm";

  Future<bool> _checkMyChamCong() async {
    bool check = true;
    await API_Request.api_query('checkMYCHAMCONG', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
        var response = value['data'][0];        
        setState(() {
          _minTime = response['MIN_TIME'] != null ? GlobalFunction.MyDate('HH:mm:ss', response['MIN_TIME']) : "Chưa chấm";
          _maxTime = response['MAX_TIME'] != null ? GlobalFunction.MyDate('HH:mm:ss', response['MAX_TIME']) : "Chưa chấm";
          if(_maxTime != "Chưa chấm") {
            DateTime dtMin = DateTime.parse(response['MIN_TIME']);
            DateTime dtMax = DateTime.parse(response['MAX_TIME']);
            int minDiff = dtMax.difference(dtMin).inMinutes;
            if(minDiff < 30) {
              _maxTime = "Chưa chấm" ;
            }
          }
        });
       
      } else {
        check = false;
      }
    });
    return check;
  }
  


  @override
  void initState() {
    LocalDataAccess.getVariable('userData').then(
      (value) {
        setState(() {
          Map<String, dynamic> rawJson = jsonDecode(value);
          _myUserData = UserData.fromJson(rawJson);
        });
      },
    );
    _checkMyChamCong();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: 150,
      height: 190,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(0, 3), // Offset in the x, y direction
            )
          ],
          image: DecorationImage(
              image: NetworkImage(
                  'http://14.160.33.94/Picture_NS/NS_${_myUserData.eMPLNO}.jpg'),
              fit: BoxFit.cover)),
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(                  
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 237, 248, 243),
                          Color.fromARGB(255, 118, 218, 156),
                        ],
                        begin: FractionalOffset(1.0, 0.5),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avatar,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Chấm công hôm nay", style: TextStyle(fontWeight: FontWeight.bold),),      
                        const SizedBox(height: 8.0,),     
                        Row(                        
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.only(right: 8.0),
                                decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),                           
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 133, 196, 248),
                                        Color.fromARGB(255, 118, 173, 218),
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                    boxShadow: [
                                       BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                    ]
                                ),
                                child: Text("$_minTime")),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                                decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),                           
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 133, 196, 248),
                                        Color.fromARGB(255, 118, 173, 218),
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                    boxShadow: [
                                       BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                    ]
                                ),
                                child: Text("$_maxTime")),
                          ],
                        ),                                           
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(                  
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 237, 248, 243),
                          Color.fromARGB(255, 118, 218, 156),
                        ],
                        begin: FractionalOffset(1.0, 0.5),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thông tin nhân viên",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "1. Họ và tên: ${_myUserData.mIDLASTNAME} ${_myUserData.fIRSTNAME}"),
                    Text("2. Mã nhân sự: ${_myUserData.cMSID}"),
                    Text("3. Mã ERP: ${_myUserData.eMPLNO}"),
                    Text(
                        "4. DOB: ${GlobalFunction.MyDate('dd-MM-yyyy', _myUserData.dOB!)}"),
                    Text("5. Quê quán: ${_myUserData.hOMETOWN}"),
                    Text(
                        "6. Địa chỉ: ${_myUserData.aDDVILLAGE}-${_myUserData.aDDCOMMUNE}-${_myUserData.aDDDISTRICT}-${_myUserData.aDDPROVINCE}"),
                    Text("7. Bộ phận chính: ${_myUserData.mAINDEPTNAME}"),
                    Text("8. Bộ phận phụ: ${_myUserData.sUBDEPTNAME}"),
                    Text("9. Vị trí làm việc: ${_myUserData.wORKPOSITIONNAME}"),
                    Text("10. Nhóm điểm danh: ${_myUserData.aTTGROUPCODE}"),
                    Text("11. Chức vụ: ${_myUserData.jOBNAME}"),
                  ],
                ),
              ),
            ],
          ),          
        ],
      ),
    );
  }
}
