class UserData {
  String? cTRCD;
  String? eMPLNO;
  String? cMSID;
  String? fIRSTNAME;
  String? mIDLASTNAME;
  String? dOB;
  String? hOMETOWN;
  int? sEXCODE;
  String? aDDPROVINCE;
  String? aDDDISTRICT;
  String? aDDCOMMUNE;
  String? aDDVILLAGE;
  String? pHONENUMBER;
  String? wORKSTARTDATE;
  String? pASSWORD;
  String? eMAIL;
  int? wORKPOSITIONCODE;
  int? wORKSHIFTCODE;
  int? pOSITIONCODE;
  int? jOBCODE;
  int? fACTORYCODE;
  int? wORKSTATUSCODE;
  String? rEMARK;
  String? oNLINEDATETIME;
  String? sEXNAME;
  String? sEXNAMEKR;
  String? wORKSTATUSNAME;
  String? wORKSTATUSNAMEKR;
  String? fACTORYNAME;
  String? fACTORYNAMEKR;
  String? jOBNAME;
  String? jOBNAMEKR;
  String? pOSITIONNAME;
  String? pOSITIONNAMEKR;
  String? wORKSHIFNAME;
  String? wORKSHIFNAMEKR;
  int? sUBDEPTCODE;
  String? wORKPOSITIONNAME;
  String? wORKPOSITIONNAMEKR;
  int? aTTGROUPCODE;
  int? mAINDEPTCODE;
  String? sUBDEPTNAME;
  String? sUBDEPTNAMEKR;
  String? mAINDEPTNAME;
  String? mAINDEPTNAMEKR;

  UserData(
      {this.cTRCD,
      this.eMPLNO,
      this.cMSID,
      this.fIRSTNAME,
      this.mIDLASTNAME,
      this.dOB,
      this.hOMETOWN,
      this.sEXCODE,
      this.aDDPROVINCE,
      this.aDDDISTRICT,
      this.aDDCOMMUNE,
      this.aDDVILLAGE,
      this.pHONENUMBER,
      this.wORKSTARTDATE,
      this.pASSWORD,
      this.eMAIL,
      this.wORKPOSITIONCODE,
      this.wORKSHIFTCODE,
      this.pOSITIONCODE,
      this.jOBCODE,
      this.fACTORYCODE,
      this.wORKSTATUSCODE,
      this.rEMARK,
      this.oNLINEDATETIME,
      this.sEXNAME,
      this.sEXNAMEKR,
      this.wORKSTATUSNAME,
      this.wORKSTATUSNAMEKR,
      this.fACTORYNAME,
      this.fACTORYNAMEKR,
      this.jOBNAME,
      this.jOBNAMEKR,
      this.pOSITIONNAME,
      this.pOSITIONNAMEKR,
      this.wORKSHIFNAME,
      this.wORKSHIFNAMEKR,
      this.sUBDEPTCODE,
      this.wORKPOSITIONNAME,
      this.wORKPOSITIONNAMEKR,
      this.aTTGROUPCODE,
      this.mAINDEPTCODE,
      this.sUBDEPTNAME,
      this.sUBDEPTNAMEKR,
      this.mAINDEPTNAME,
      this.mAINDEPTNAMEKR});

  UserData.fromJson(Map<String, dynamic> json) {
    cTRCD = json['CTR_CD'];
    eMPLNO = json['EMPL_NO'];
    cMSID = json['CMS_ID'];
    fIRSTNAME = json['FIRST_NAME'];
    mIDLASTNAME = json['MIDLAST_NAME'];
    dOB = json['DOB'];
    hOMETOWN = json['HOMETOWN'];
    sEXCODE = json['SEX_CODE'];
    aDDPROVINCE = json['ADD_PROVINCE'];
    aDDDISTRICT = json['ADD_DISTRICT'];
    aDDCOMMUNE = json['ADD_COMMUNE'];
    aDDVILLAGE = json['ADD_VILLAGE'];
    pHONENUMBER = json['PHONE_NUMBER'];
    wORKSTARTDATE = json['WORK_START_DATE'];
    pASSWORD = json['PASSWORD'];
    eMAIL = json['EMAIL'];
    wORKPOSITIONCODE = json['WORK_POSITION_CODE'];
    wORKSHIFTCODE = json['WORK_SHIFT_CODE'];
    pOSITIONCODE = json['POSITION_CODE'];
    jOBCODE = json['JOB_CODE'];
    fACTORYCODE = json['FACTORY_CODE'];
    wORKSTATUSCODE = json['WORK_STATUS_CODE'];
    rEMARK = json['REMARK'];
    oNLINEDATETIME = json['ONLINE_DATETIME'];
    sEXNAME = json['SEX_NAME'];
    sEXNAMEKR = json['SEX_NAME_KR'];
    wORKSTATUSNAME = json['WORK_STATUS_NAME'];
    wORKSTATUSNAMEKR = json['WORK_STATUS_NAME_KR'];
    fACTORYNAME = json['FACTORY_NAME'];
    fACTORYNAMEKR = json['FACTORY_NAME_KR'];
    jOBNAME = json['JOB_NAME'];
    jOBNAMEKR = json['JOB_NAME_KR'];
    pOSITIONNAME = json['POSITION_NAME'];
    pOSITIONNAMEKR = json['POSITION_NAME_KR'];
    wORKSHIFNAME = json['WORK_SHIF_NAME'];
    wORKSHIFNAMEKR = json['WORK_SHIF_NAME_KR'];
    sUBDEPTCODE = json['SUBDEPTCODE'];
    wORKPOSITIONNAME = json['WORK_POSITION_NAME'];
    wORKPOSITIONNAMEKR = json['WORK_POSITION_NAME_KR'];
    aTTGROUPCODE = json['ATT_GROUP_CODE'];
    mAINDEPTCODE = json['MAINDEPTCODE'];
    sUBDEPTNAME = json['SUBDEPTNAME'];
    sUBDEPTNAMEKR = json['SUBDEPTNAME_KR'];
    mAINDEPTNAME = json['MAINDEPTNAME'];
    mAINDEPTNAMEKR = json['MAINDEPTNAME_KR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CTR_CD'] = this.cTRCD;
    data['EMPL_NO'] = this.eMPLNO;
    data['CMS_ID'] = this.cMSID;
    data['FIRST_NAME'] = this.fIRSTNAME;
    data['MIDLAST_NAME'] = this.mIDLASTNAME;
    data['DOB'] = this.dOB;
    data['HOMETOWN'] = this.hOMETOWN;
    data['SEX_CODE'] = this.sEXCODE;
    data['ADD_PROVINCE'] = this.aDDPROVINCE;
    data['ADD_DISTRICT'] = this.aDDDISTRICT;
    data['ADD_COMMUNE'] = this.aDDCOMMUNE;
    data['ADD_VILLAGE'] = this.aDDVILLAGE;
    data['PHONE_NUMBER'] = this.pHONENUMBER;
    data['WORK_START_DATE'] = this.wORKSTARTDATE;
    data['PASSWORD'] = this.pASSWORD;
    data['EMAIL'] = this.eMAIL;
    data['WORK_POSITION_CODE'] = this.wORKPOSITIONCODE;
    data['WORK_SHIFT_CODE'] = this.wORKSHIFTCODE;
    data['POSITION_CODE'] = this.pOSITIONCODE;
    data['JOB_CODE'] = this.jOBCODE;
    data['FACTORY_CODE'] = this.fACTORYCODE;
    data['WORK_STATUS_CODE'] = this.wORKSTATUSCODE;
    data['REMARK'] = this.rEMARK;
    data['ONLINE_DATETIME'] = this.oNLINEDATETIME;
    data['SEX_NAME'] = this.sEXNAME;
    data['SEX_NAME_KR'] = this.sEXNAMEKR;
    data['WORK_STATUS_NAME'] = this.wORKSTATUSNAME;
    data['WORK_STATUS_NAME_KR'] = this.wORKSTATUSNAMEKR;
    data['FACTORY_NAME'] = this.fACTORYNAME;
    data['FACTORY_NAME_KR'] = this.fACTORYNAMEKR;
    data['JOB_NAME'] = this.jOBNAME;
    data['JOB_NAME_KR'] = this.jOBNAMEKR;
    data['POSITION_NAME'] = this.pOSITIONNAME;
    data['POSITION_NAME_KR'] = this.pOSITIONNAMEKR;
    data['WORK_SHIF_NAME'] = this.wORKSHIFNAME;
    data['WORK_SHIF_NAME_KR'] = this.wORKSHIFNAMEKR;
    data['SUBDEPTCODE'] = this.sUBDEPTCODE;
    data['WORK_POSITION_NAME'] = this.wORKPOSITIONNAME;
    data['WORK_POSITION_NAME_KR'] = this.wORKPOSITIONNAMEKR;
    data['ATT_GROUP_CODE'] = this.aTTGROUPCODE;
    data['MAINDEPTCODE'] = this.mAINDEPTCODE;
    data['SUBDEPTNAME'] = this.sUBDEPTNAME;
    data['SUBDEPTNAME_KR'] = this.sUBDEPTNAMEKR;
    data['MAINDEPTNAME'] = this.mAINDEPTNAME;
    data['MAINDEPTNAME_KR'] = this.mAINDEPTNAMEKR;
    return data;
  }
}
