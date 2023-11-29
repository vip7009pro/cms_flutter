import 'dart:convert';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({ Key? key }) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
   UserData _myUserData = UserData(aDDCOMMUNE: '', aDDDISTRICT: '', aDDPROVINCE: '',aDDVILLAGE: '',aTTGROUPCODE: 0, cMSID: '',cTRCD: '',dOB: '',eMAIL: '',eMPLNO: '',fACTORYCODE: 1,fACTORYNAME: '',fACTORYNAMEKR: '',fIRSTNAME: '',hOMETOWN: '',jOBCODE: 0,jOBNAME: '',jOBNAMEKR: '',mAINDEPTCODE: 0,mAINDEPTNAME: '',mAINDEPTNAMEKR: '',mIDLASTNAME: '',oNLINEDATETIME: '',pASSWORD: '',pHONENUMBER: '',pOSITIONCODE: 0,pOSITIONNAME: '',pOSITIONNAMEKR: '',rEMARK: '',sEXCODE: 0,sEXNAME: '',sEXNAMEKR: '',sUBDEPTCODE: 0,sUBDEPTNAME: '',sUBDEPTNAMEKR: '',wORKPOSITIONCODE: 0,wORKPOSITIONNAME: '',wORKPOSITIONNAMEKR: '',wORKSHIFNAME: '',wORKSHIFNAMEKR: '',wORKSHIFTCODE: 0,wORKSTARTDATE: '',wORKSTATUSCODE: 0,wORKSTATUSNAME: '',wORKSTATUSNAMEKR: '');


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
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: 150,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 3, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: Offset(0, 3), // Offset in the x, y direction
                )],
        image: DecorationImage(image: NetworkImage('http://14.160.33.94/Picture_NS/NS_${_myUserData.eMPLNO}.jpg'), fit: BoxFit.cover)
        
      ),
      
     ) ;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              avatar,
              Column(
                children: [
                  Text("Đây là Home widget"),
                ],
              ),
            ],
          ),
          Text("Đây là Home widget"),
          Text("Đây là Home widget"),
        ],
      ),
      
    );
  }
}