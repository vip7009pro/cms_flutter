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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CTR_CD'] = cTRCD;
    data['EMPL_NO'] = eMPLNO;
    data['CMS_ID'] = cMSID;
    data['FIRST_NAME'] = fIRSTNAME;
    data['MIDLAST_NAME'] = mIDLASTNAME;
    data['DOB'] = dOB;
    data['HOMETOWN'] = hOMETOWN;
    data['SEX_CODE'] = sEXCODE;
    data['ADD_PROVINCE'] = aDDPROVINCE;
    data['ADD_DISTRICT'] = aDDDISTRICT;
    data['ADD_COMMUNE'] = aDDCOMMUNE;
    data['ADD_VILLAGE'] = aDDVILLAGE;
    data['PHONE_NUMBER'] = pHONENUMBER;
    data['WORK_START_DATE'] = wORKSTARTDATE;
    data['PASSWORD'] = pASSWORD;
    data['EMAIL'] = eMAIL;
    data['WORK_POSITION_CODE'] = wORKPOSITIONCODE;
    data['WORK_SHIFT_CODE'] = wORKSHIFTCODE;
    data['POSITION_CODE'] = pOSITIONCODE;
    data['JOB_CODE'] = jOBCODE;
    data['FACTORY_CODE'] = fACTORYCODE;
    data['WORK_STATUS_CODE'] = wORKSTATUSCODE;
    data['REMARK'] = rEMARK;
    data['ONLINE_DATETIME'] = oNLINEDATETIME;
    data['SEX_NAME'] = sEXNAME;
    data['SEX_NAME_KR'] = sEXNAMEKR;
    data['WORK_STATUS_NAME'] = wORKSTATUSNAME;
    data['WORK_STATUS_NAME_KR'] = wORKSTATUSNAMEKR;
    data['FACTORY_NAME'] = fACTORYNAME;
    data['FACTORY_NAME_KR'] = fACTORYNAMEKR;
    data['JOB_NAME'] = jOBNAME;
    data['JOB_NAME_KR'] = jOBNAMEKR;
    data['POSITION_NAME'] = pOSITIONNAME;
    data['POSITION_NAME_KR'] = pOSITIONNAMEKR;
    data['WORK_SHIF_NAME'] = wORKSHIFNAME;
    data['WORK_SHIF_NAME_KR'] = wORKSHIFNAMEKR;
    data['SUBDEPTCODE'] = sUBDEPTCODE;
    data['WORK_POSITION_NAME'] = wORKPOSITIONNAME;
    data['WORK_POSITION_NAME_KR'] = wORKPOSITIONNAMEKR;
    data['ATT_GROUP_CODE'] = aTTGROUPCODE;
    data['MAINDEPTCODE'] = mAINDEPTCODE;
    data['SUBDEPTNAME'] = sUBDEPTNAME;
    data['SUBDEPTNAME_KR'] = sUBDEPTNAMEKR;
    data['MAINDEPTNAME'] = mAINDEPTNAME;
    data['MAINDEPTNAME_KR'] = mAINDEPTNAMEKR;
    return data;
  }
}
class DiemDanhNhom {
    String id;
    String emplNo;
    String cmsId;
    String midlastName;
    String firstName;
    String phoneNumber;
    String sexName;
    String workStatusName;
    String factoryName;
    String jobName;
    String workShifName;
    int workPositionCode;
    String workPositionName;
    String subdeptname;
    String maindeptname;
    dynamic requestDate;
    dynamic applyDate;
    dynamic approvalStatus;
    dynamic offId;
    dynamic caNghi;
    dynamic onOff;
    dynamic overtimeInfo;
    int? overtime;
    dynamic reasonName;
    dynamic remark;

    DiemDanhNhom({
        required this.id,
        required this.emplNo,
        required this.cmsId,
        required this.midlastName,
        required this.firstName,
        required this.phoneNumber,
        required this.sexName,
        required this.workStatusName,
        required this.factoryName,
        required this.jobName,
        required this.workShifName,
        required this.workPositionCode,
        required this.workPositionName,
        required this.subdeptname,
        required this.maindeptname,
        required this.requestDate,
        required this.applyDate,
        required this.approvalStatus,
        required this.offId,
        required this.caNghi,
        required this.onOff,
        required this.overtimeInfo,
        required this.overtime,
        required this.reasonName,
        required this.remark,
    });

    factory DiemDanhNhom.fromJson(Map<String, dynamic> json) => DiemDanhNhom(
        id: json["id"],
        emplNo: json["EMPL_NO"],
        cmsId: json["CMS_ID"],
        midlastName: json["MIDLAST_NAME"],
        firstName: json["FIRST_NAME"],
        phoneNumber: json["PHONE_NUMBER"],
        sexName: json["SEX_NAME"],
        workStatusName: json["WORK_STATUS_NAME"],
        factoryName: json["FACTORY_NAME"],
        jobName: json["JOB_NAME"],
        workShifName: json["WORK_SHIF_NAME"],
        workPositionCode: json["WORK_POSITION_CODE"],
        workPositionName: json["WORK_POSITION_NAME"],
        subdeptname: json["SUBDEPTNAME"],
        maindeptname: json["MAINDEPTNAME"],
        requestDate: json["REQUEST_DATE"],
        applyDate: json["APPLY_DATE"],
        approvalStatus: json["APPROVAL_STATUS"],
        offId: json["OFF_ID"],
        caNghi: json["CA_NGHI"],
        onOff: json["ON_OFF"],
        overtimeInfo: json["OVERTIME_INFO"],
        overtime: json["OVERTIME"],
        reasonName: json["REASON_NAME"],
        remark: json["REMARK"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "EMPL_NO": emplNo,
        "CMS_ID": cmsId,
        "MIDLAST_NAME": midlastName,
        "FIRST_NAME": firstName,
        "PHONE_NUMBER": phoneNumber,
        "SEX_NAME": sexName,
        "WORK_STATUS_NAME": workStatusName,
        "FACTORY_NAME": factoryName,
        "JOB_NAME": jobName,
        "WORK_SHIF_NAME": workShifName,
        "WORK_POSITION_CODE": workPositionCode,
        "WORK_POSITION_NAME": workPositionName,
        "SUBDEPTNAME": subdeptname,
        "MAINDEPTNAME": maindeptname,
        "REQUEST_DATE": requestDate,
        "APPLY_DATE": applyDate,
        "APPROVAL_STATUS": approvalStatus,
        "OFF_ID": offId,
        "CA_NGHI": caNghi,
        "ON_OFF": onOff,
        "OVERTIME_INFO": overtimeInfo,
        "OVERTIME": overtime,
        "REASON_NAME": reasonName,
        "REMARK": remark,
    };
}
class WorkPositionTableData {   
    String CTR_CD;
    int SUBDEPTCODE;
    int WORK_POSITION_CODE;
    String WORK_POSITION_NAME;
    String WORK_POSITION_NAME_KR;
    int ATT_GROUP_CODE;

    WorkPositionTableData({
      required this.CTR_CD,
      required this.SUBDEPTCODE,
      required this.WORK_POSITION_CODE,
      required this.WORK_POSITION_NAME,
      required this.WORK_POSITION_NAME_KR,
      required this.ATT_GROUP_CODE,        
    });

    factory WorkPositionTableData.fromJson(Map<String, dynamic> json) => WorkPositionTableData(      
        ATT_GROUP_CODE: json["ATT_GROUP_CODE"],
        CTR_CD: json["CTR_CD"],
        SUBDEPTCODE: json["SUBDEPTCODE"],
        WORK_POSITION_CODE: json["WORK_POSITION_CODE"],
        WORK_POSITION_NAME: json["WORK_POSITION_NAME"],
        WORK_POSITION_NAME_KR: json["WORK_POSITION_NAME_KR"],        
    );

    Map<String, dynamic> toJson() => {        
        "ATT_GROUP_CODE": ATT_GROUP_CODE,
        "CTR_CD": CTR_CD,
        "SUBDEPTCODE": SUBDEPTCODE,
        "WORK_POSITION_CODE": WORK_POSITION_CODE,
        "WORK_POSITION_NAME": WORK_POSITION_NAME,
        "WORK_POSITION_NAME_KR": WORK_POSITION_NAME_KR,        
    };
}
class PheDuyetNhomData {
  int? id;
  String? cTRCD;
  String? eMPLNO;
  String? rEQUESTDATE;
  String? aPPLYDATE;
  int? rEASONCODE;
  String? rEMARK;
  int? aPPROVALSTATUS;
  int? oFFID;
  int? cANGHI;
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
  String? rEASONNAME;
  String? rEASONNAMEKR;
  int? oNOFF;
  String? oVERTIMEINFO;
  int? oVERTIME;

  PheDuyetNhomData(
      {this.id,
      this.cTRCD,
      this.eMPLNO,
      this.rEQUESTDATE,
      this.aPPLYDATE,
      this.rEASONCODE,
      this.rEMARK,
      this.aPPROVALSTATUS,
      this.oFFID,
      this.cANGHI,
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
      this.mAINDEPTNAMEKR,
      this.rEASONNAME,
      this.rEASONNAMEKR,
      this.oNOFF,
      this.oVERTIMEINFO,
      this.oVERTIME});

  PheDuyetNhomData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cTRCD = json['CTR_CD'];
    eMPLNO = json['EMPL_NO'];
    rEQUESTDATE = json['REQUEST_DATE'];
    aPPLYDATE = json['APPLY_DATE'];
    rEASONCODE = json['REASON_CODE'];
    rEMARK = json['REMARK'];
    aPPROVALSTATUS = json['APPROVAL_STATUS'];
    oFFID = json['OFF_ID'];
    cANGHI = json['CA_NGHI'];
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
    rEASONNAME = json['REASON_NAME'];
    rEASONNAMEKR = json['REASON_NAME_KR'];
    oNOFF = json['ON_OFF'];
    oVERTIMEINFO = json['OVERTIME_INFO'];
    oVERTIME = json['OVERTIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CTR_CD'] = cTRCD;
    data['EMPL_NO'] = eMPLNO;
    data['REQUEST_DATE'] = rEQUESTDATE;
    data['APPLY_DATE'] = aPPLYDATE;
    data['REASON_CODE'] = rEASONCODE;
    data['REMARK'] = rEMARK;
    data['APPROVAL_STATUS'] = aPPROVALSTATUS;
    data['OFF_ID'] = oFFID;
    data['CA_NGHI'] = cANGHI;
    data['CMS_ID'] = cMSID;
    data['FIRST_NAME'] = fIRSTNAME;
    data['MIDLAST_NAME'] = mIDLASTNAME;
    data['DOB'] = dOB;
    data['HOMETOWN'] = hOMETOWN;
    data['SEX_CODE'] = sEXCODE;
    data['ADD_PROVINCE'] = aDDPROVINCE;
    data['ADD_DISTRICT'] = aDDDISTRICT;
    data['ADD_COMMUNE'] = aDDCOMMUNE;
    data['ADD_VILLAGE'] = aDDVILLAGE;
    data['PHONE_NUMBER'] = pHONENUMBER;
    data['WORK_START_DATE'] = wORKSTARTDATE;
    data['PASSWORD'] = pASSWORD;
    data['EMAIL'] = eMAIL;
    data['WORK_POSITION_CODE'] = wORKPOSITIONCODE;
    data['WORK_SHIFT_CODE'] = wORKSHIFTCODE;
    data['POSITION_CODE'] = pOSITIONCODE;
    data['JOB_CODE'] = jOBCODE;
    data['FACTORY_CODE'] = fACTORYCODE;
    data['WORK_STATUS_CODE'] = wORKSTATUSCODE;
    data['ONLINE_DATETIME'] = oNLINEDATETIME;
    data['SEX_NAME'] = sEXNAME;
    data['SEX_NAME_KR'] = sEXNAMEKR;
    data['WORK_STATUS_NAME'] = wORKSTATUSNAME;
    data['WORK_STATUS_NAME_KR'] = wORKSTATUSNAMEKR;
    data['FACTORY_NAME'] = fACTORYNAME;
    data['FACTORY_NAME_KR'] = fACTORYNAMEKR;
    data['JOB_NAME'] = jOBNAME;
    data['JOB_NAME_KR'] = jOBNAMEKR;
    data['POSITION_NAME'] = pOSITIONNAME;
    data['POSITION_NAME_KR'] = pOSITIONNAMEKR;
    data['WORK_SHIF_NAME'] = wORKSHIFNAME;
    data['WORK_SHIF_NAME_KR'] = wORKSHIFNAMEKR;
    data['SUBDEPTCODE'] = sUBDEPTCODE;
    data['WORK_POSITION_NAME'] = wORKPOSITIONNAME;
    data['WORK_POSITION_NAME_KR'] = wORKPOSITIONNAMEKR;
    data['ATT_GROUP_CODE'] = aTTGROUPCODE;
    data['MAINDEPTCODE'] = mAINDEPTCODE;
    data['SUBDEPTNAME'] = sUBDEPTNAME;
    data['SUBDEPTNAME_KR'] = sUBDEPTNAMEKR;
    data['MAINDEPTNAME'] = mAINDEPTNAME;
    data['MAINDEPTNAME_KR'] = mAINDEPTNAMEKR;
    data['REASON_NAME'] = rEASONNAME;
    data['REASON_NAME_KR'] = rEASONNAMEKR;
    data['ON_OFF'] = oNOFF;
    data['OVERTIME_INFO'] = oVERTIMEINFO;
    data['OVERTIME'] = oVERTIME;
    return data;
  }
}
class MyDiemDanhData {
  String? dATECOLUMN;
  int? nVCCID;
  String? eMPLNO;
  String? cMSID;
  String? mIDLASTNAME;
  String? fIRSTNAME;
  String? pHONENUMBER;
  String? sEXNAME;
  String? wORKSTATUSNAME;
  String? fACTORYNAME;
  String? jOBNAME;
  String? wORKSHIFNAME;
  String? wORKPOSITIONNAME;
  String? sUBDEPTNAME;
  String? mAINDEPTNAME;
  dynamic rEQUESTDATE;
  String? aPPLYDATE;
  dynamic aPPROVALSTATUS;
  dynamic oFFID;
  dynamic cANGHI;
  int? oNOFF;
  dynamic oVERTIMEINFO;
  int? oVERTIME;
  dynamic rEASONNAME;
  dynamic rEMARK;
  dynamic xACNHAN;
  int? cACODE;
  String? cANAME;
  String? iNSTART;
  String? iNEND;
  String? oUTSTART;
  String? oUTEND;
  String? cHECK1;
  String? cHECK2;
  dynamic cHECK3;

  MyDiemDanhData(
      {this.dATECOLUMN,
      this.nVCCID,
      this.eMPLNO,
      this.cMSID,
      this.mIDLASTNAME,
      this.fIRSTNAME,
      this.pHONENUMBER,
      this.sEXNAME,
      this.wORKSTATUSNAME,
      this.fACTORYNAME,
      this.jOBNAME,
      this.wORKSHIFNAME,
      this.wORKPOSITIONNAME,
      this.sUBDEPTNAME,
      this.mAINDEPTNAME,
      this.rEQUESTDATE,
      this.aPPLYDATE,
      this.aPPROVALSTATUS,
      this.oFFID,
      this.cANGHI,
      this.oNOFF,
      this.oVERTIMEINFO,
      this.oVERTIME,
      this.rEASONNAME,
      this.rEMARK,
      this.xACNHAN,
      this.cACODE,
      this.cANAME,
      this.iNSTART,
      this.iNEND,
      this.oUTSTART,
      this.oUTEND,
      this.cHECK1,
      this.cHECK2,
      this.cHECK3});

  MyDiemDanhData.fromJson(Map<String, dynamic> json) {
    dATECOLUMN = json['DATE_COLUMN'];
    nVCCID = json['NV_CCID'];
    eMPLNO = json['EMPL_NO'];
    cMSID = json['CMS_ID'];
    mIDLASTNAME = json['MIDLAST_NAME'];
    fIRSTNAME = json['FIRST_NAME'];
    pHONENUMBER = json['PHONE_NUMBER'];
    sEXNAME = json['SEX_NAME'];
    wORKSTATUSNAME = json['WORK_STATUS_NAME'];
    fACTORYNAME = json['FACTORY_NAME'];
    jOBNAME = json['JOB_NAME'];
    wORKSHIFNAME = json['WORK_SHIF_NAME'];
    wORKPOSITIONNAME = json['WORK_POSITION_NAME'];
    sUBDEPTNAME = json['SUBDEPTNAME'];
    mAINDEPTNAME = json['MAINDEPTNAME'];
    rEQUESTDATE = json['REQUEST_DATE'];
    aPPLYDATE = json['APPLY_DATE'];
    aPPROVALSTATUS = json['APPROVAL_STATUS'];
    oFFID = json['OFF_ID'];
    cANGHI = json['CA_NGHI'];
    oNOFF = json['ON_OFF'];
    oVERTIMEINFO = json['OVERTIME_INFO'];
    oVERTIME = json['OVERTIME'];
    rEASONNAME = json['REASON_NAME'];
    rEMARK = json['REMARK'];
    xACNHAN = json['XACNHAN'];
    cACODE = json['CA_CODE'];
    cANAME = json['CA_NAME'];
    iNSTART = json['IN_START'];
    iNEND = json['IN_END'];
    oUTSTART = json['OUT_START'];
    oUTEND = json['OUT_END'];
    cHECK1 = json['CHECK1'];
    cHECK2 = json['CHECK2'];
    cHECK3 = json['CHECK3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DATE_COLUMN'] = dATECOLUMN;
    data['NV_CCID'] = nVCCID;
    data['EMPL_NO'] = eMPLNO;
    data['CMS_ID'] = cMSID;
    data['MIDLAST_NAME'] = mIDLASTNAME;
    data['FIRST_NAME'] = fIRSTNAME;
    data['PHONE_NUMBER'] = pHONENUMBER;
    data['SEX_NAME'] = sEXNAME;
    data['WORK_STATUS_NAME'] = wORKSTATUSNAME;
    data['FACTORY_NAME'] = fACTORYNAME;
    data['JOB_NAME'] = jOBNAME;
    data['WORK_SHIF_NAME'] = wORKSHIFNAME;
    data['WORK_POSITION_NAME'] = wORKPOSITIONNAME;
    data['SUBDEPTNAME'] = sUBDEPTNAME;
    data['MAINDEPTNAME'] = mAINDEPTNAME;
    data['REQUEST_DATE'] = rEQUESTDATE;
    data['APPLY_DATE'] = aPPLYDATE;
    data['APPROVAL_STATUS'] = aPPROVALSTATUS;
    data['OFF_ID'] = oFFID;
    data['CA_NGHI'] = cANGHI;
    data['ON_OFF'] = oNOFF;
    data['OVERTIME_INFO'] = oVERTIMEINFO;
    data['OVERTIME'] = oVERTIME;
    data['REASON_NAME'] = rEASONNAME;
    data['REMARK'] = rEMARK;
    data['XACNHAN'] = xACNHAN;
    data['CA_CODE'] = cACODE;
    data['CA_NAME'] = cANAME;
    data['IN_START'] = iNSTART;
    data['IN_END'] = iNEND;
    data['OUT_START'] = oUTSTART;
    data['OUT_END'] = oUTEND;
    data['CHECK1'] = cHECK1;
    data['CHECK2'] = cHECK2;
    data['CHECK3'] = cHECK3;
    return data;
  }
}
class DiemDanhNhomDataSummary {
  String? id;
  String? aPPLYDATE;
  int? tOTAL;
  int? tOTALON;
  int? tOTALOFF;
  num? oNRATE;

  DiemDanhNhomDataSummary(
      {this.id,
      this.aPPLYDATE,
      this.tOTAL,
      this.tOTALON,
      this.tOTALOFF,
      this.oNRATE});

  DiemDanhNhomDataSummary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aPPLYDATE = json['APPLY_DATE'];
    tOTAL = json['TOTAL'];
    tOTALON = json['TOTAL_ON'];
    tOTALOFF = json['TOTAL_OFF'];
    oNRATE = json['ON_RATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['APPLY_DATE'] = aPPLYDATE;
    data['TOTAL'] = tOTAL;
    data['TOTAL_ON'] = tOTALON;
    data['TOTAL_OFF'] = tOTALOFF;
    data['ON_RATE'] = oNRATE;
    return data;
  }
}
class DIEMDANHMAINDEPT {
  String? mAINDEPTNAME;
  int? cOUNTTOTAL;
  int? cOUTON;
  int? cOUTOFF;
  int? cOUNTCDD;
  num? oNRATE;

  DIEMDANHMAINDEPT(
      {this.mAINDEPTNAME,
      this.cOUNTTOTAL,
      this.cOUTON,
      this.cOUTOFF,
      this.cOUNTCDD,
      this.oNRATE});

  DIEMDANHMAINDEPT.fromJson(Map<String, dynamic> json) {
    mAINDEPTNAME = json['MAINDEPTNAME'];
    cOUNTTOTAL = json['COUNT_TOTAL'];
    cOUTON = json['COUT_ON'];
    cOUTOFF = json['COUT_OFF'];
    cOUNTCDD = json['COUNT_CDD'];
    oNRATE = json['ON_RATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MAINDEPTNAME'] = mAINDEPTNAME;
    data['COUNT_TOTAL'] = cOUNTTOTAL;
    data['COUT_ON'] = cOUTON;
    data['COUT_OFF'] = cOUTOFF;
    data['COUNT_CDD'] = cOUNTCDD;
    data['ON_RATE'] = oNRATE;
    return data;
  }
}
class MAINDEPTDATA {
  int? id;
  String? CTR_CD;
  int? MAINDEPTCODE;
  String? MAINDEPTNAME;
  String? MAINDEPTNAME_KR;  

  MAINDEPTDATA(
      {this.id,
      this.CTR_CD,
      this.MAINDEPTCODE,
      this.MAINDEPTNAME,
      this.MAINDEPTNAME_KR,
      });

  MAINDEPTDATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    CTR_CD = json['CTR_CD'];
    MAINDEPTCODE = json['MAINDEPTCODE'];
    MAINDEPTNAME = json['MAINDEPTNAME'];
    MAINDEPTNAME_KR = json['MAINDEPTNAME_KR'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CTR_CD'] = CTR_CD;
    data['MAINDEPTCODE'] = MAINDEPTCODE;
    data['MAINDEPTNAME'] = MAINDEPTNAME;
    data['MAINDEPTNAME_KR'] = MAINDEPTNAME_KR;   
    return data;
  }
}
class SUBDEPTDATA {
  int? id;
  String? cTRCD;
  int? mAINDEPTCODE;
  int? sUBDEPTCODE;
  String? sUBDEPTNAME;
  String? sUBDEPTNAMEKR;

  SUBDEPTDATA(
      {this.id,
      this.cTRCD,
      this.mAINDEPTCODE,
      this.sUBDEPTCODE,
      this.sUBDEPTNAME,
      this.sUBDEPTNAMEKR});

  SUBDEPTDATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cTRCD = json['CTR_CD'];
    mAINDEPTCODE = json['MAINDEPTCODE'];
    sUBDEPTCODE = json['SUBDEPTCODE'];
    sUBDEPTNAME = json['SUBDEPTNAME'];
    sUBDEPTNAMEKR = json['SUBDEPTNAME_KR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CTR_CD'] = cTRCD;
    data['MAINDEPTCODE'] = mAINDEPTCODE;
    data['SUBDEPTCODE'] = sUBDEPTCODE;
    data['SUBDEPTNAME'] = sUBDEPTNAME;
    data['SUBDEPTNAME_KR'] = sUBDEPTNAMEKR;
    return data;
  }
}
class WORKPOSITIONDATA {
  int? id;
  String? cTRCD;
  int? sUBDEPTCODE;
  int? wORKPOSITIONCODE;
  String? wORKPOSITIONNAME;
  String? wORKPOSITIONNAMEKR;
  int? aTTGROUPCODE;

  WORKPOSITIONDATA(
      {this.id,
      this.cTRCD,
      this.sUBDEPTCODE,
      this.wORKPOSITIONCODE,
      this.wORKPOSITIONNAME,
      this.wORKPOSITIONNAMEKR,
      this.aTTGROUPCODE});

  WORKPOSITIONDATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cTRCD = json['CTR_CD'];
    sUBDEPTCODE = json['SUBDEPTCODE'];
    wORKPOSITIONCODE = json['WORK_POSITION_CODE'];
    wORKPOSITIONNAME = json['WORK_POSITION_NAME'];
    wORKPOSITIONNAMEKR = json['WORK_POSITION_NAME_KR'];
    aTTGROUPCODE = json['ATT_GROUP_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CTR_CD'] = cTRCD;
    data['SUBDEPTCODE'] = sUBDEPTCODE;
    data['WORK_POSITION_CODE'] = wORKPOSITIONCODE;
    data['WORK_POSITION_NAME'] = wORKPOSITIONNAME;
    data['WORK_POSITION_NAME_KR'] = wORKPOSITIONNAMEKR;
    data['ATT_GROUP_CODE'] = aTTGROUPCODE;
    return data;
  }
}
class EmployeeData {
  dynamic nVCCID;
  String? id;
  String? eMPLNO;
  String? cMSID;
  String? fIRSTNAME;
  String? mIDLASTNAME;
  String? dOB;
  String? hOMETOWN;
  String? aDDPROVINCE;
  String? aDDDISTRICT;
  String? aDDCOMMUNE;
  String? aDDVILLAGE;
  String? pHONENUMBER;
  String? wORKSTARTDATE;
  String? pASSWORD;
  String? eMAIL;
  dynamic rEMARK;
  dynamic oNLINEDATETIME;
  String? cTRCD;
  int? sEXCODE;
  String? sEXNAME;
  String? sEXNAMEKR;
  int? wORKSTATUSCODE;
  String? wORKSTATUSNAME;
  String? wORKSTATUSNAMEKR;
  int? fACTORYCODE;
  String? fACTORYNAME;
  String? fACTORYNAMEKR;
  int? jOBCODE;
  String? jOBNAME;
  String? jOBNAMEKR;
  int? pOSITIONCODE;
  String? pOSITIONNAME;
  String? pOSITIONNAMEKR;
  int? wORKSHIFTCODE;
  String? wORKSHIFNAME;
  String? wORKSHIFNAMEKR;
  int? wORKPOSITIONCODE;
  String? wORKPOSITIONNAME;
  String? wORKPOSITIONNAMEKR;
  int? aTTGROUPCODE;
  int? sUBDEPTCODE;
  String? sUBDEPTNAME;
  String? sUBDEPTNAMEKR;
  int? mAINDEPTCODE;
  String? mAINDEPTNAME;
  String? mAINDEPTNAMEKR;
  dynamic eMPLIMAGE;
  dynamic rESIGNDATE;

  EmployeeData(
      {this.nVCCID,
      this.id,
      this.eMPLNO,
      this.cMSID,
      this.fIRSTNAME,
      this.mIDLASTNAME,
      this.dOB,
      this.hOMETOWN,
      this.aDDPROVINCE,
      this.aDDDISTRICT,
      this.aDDCOMMUNE,
      this.aDDVILLAGE,
      this.pHONENUMBER,
      this.wORKSTARTDATE,
      this.pASSWORD,
      this.eMAIL,
      this.rEMARK,
      this.oNLINEDATETIME,
      this.cTRCD,
      this.sEXCODE,
      this.sEXNAME,
      this.sEXNAMEKR,
      this.wORKSTATUSCODE,
      this.wORKSTATUSNAME,
      this.wORKSTATUSNAMEKR,
      this.fACTORYCODE,
      this.fACTORYNAME,
      this.fACTORYNAMEKR,
      this.jOBCODE,
      this.jOBNAME,
      this.jOBNAMEKR,
      this.pOSITIONCODE,
      this.pOSITIONNAME,
      this.pOSITIONNAMEKR,
      this.wORKSHIFTCODE,
      this.wORKSHIFNAME,
      this.wORKSHIFNAMEKR,
      this.wORKPOSITIONCODE,
      this.wORKPOSITIONNAME,
      this.wORKPOSITIONNAMEKR,
      this.aTTGROUPCODE,
      this.sUBDEPTCODE,
      this.sUBDEPTNAME,
      this.sUBDEPTNAMEKR,
      this.mAINDEPTCODE,
      this.mAINDEPTNAME,
      this.mAINDEPTNAMEKR,
      this.eMPLIMAGE,
      this.rESIGNDATE});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    nVCCID = json['NV_CCID'];
    id = json['id'];
    eMPLNO = json['EMPL_NO'];
    cMSID = json['CMS_ID'];
    fIRSTNAME = json['FIRST_NAME'];
    mIDLASTNAME = json['MIDLAST_NAME'];
    dOB = json['DOB'];
    hOMETOWN = json['HOMETOWN'];
    aDDPROVINCE = json['ADD_PROVINCE'];
    aDDDISTRICT = json['ADD_DISTRICT'];
    aDDCOMMUNE = json['ADD_COMMUNE'];
    aDDVILLAGE = json['ADD_VILLAGE'];
    pHONENUMBER = json['PHONE_NUMBER'];
    wORKSTARTDATE = json['WORK_START_DATE'];
    pASSWORD = json['PASSWORD'];
    eMAIL = json['EMAIL'];
    rEMARK = json['REMARK'];
    oNLINEDATETIME = json['ONLINE_DATETIME'];
    cTRCD = json['CTR_CD'];
    sEXCODE = json['SEX_CODE'];
    sEXNAME = json['SEX_NAME'];
    sEXNAMEKR = json['SEX_NAME_KR'];
    wORKSTATUSCODE = json['WORK_STATUS_CODE'];
    wORKSTATUSNAME = json['WORK_STATUS_NAME'];
    wORKSTATUSNAMEKR = json['WORK_STATUS_NAME_KR'];
    fACTORYCODE = json['FACTORY_CODE'];
    fACTORYNAME = json['FACTORY_NAME'];
    fACTORYNAMEKR = json['FACTORY_NAME_KR'];
    jOBCODE = json['JOB_CODE'];
    jOBNAME = json['JOB_NAME'];
    jOBNAMEKR = json['JOB_NAME_KR'];
    pOSITIONCODE = json['POSITION_CODE'];
    pOSITIONNAME = json['POSITION_NAME'];
    pOSITIONNAMEKR = json['POSITION_NAME_KR'];
    wORKSHIFTCODE = json['WORK_SHIFT_CODE'];
    wORKSHIFNAME = json['WORK_SHIF_NAME'];
    wORKSHIFNAMEKR = json['WORK_SHIF_NAME_KR'];
    wORKPOSITIONCODE = json['WORK_POSITION_CODE'];
    wORKPOSITIONNAME = json['WORK_POSITION_NAME'];
    wORKPOSITIONNAMEKR = json['WORK_POSITION_NAME_KR'];
    aTTGROUPCODE = json['ATT_GROUP_CODE'];
    sUBDEPTCODE = json['SUBDEPTCODE'];
    sUBDEPTNAME = json['SUBDEPTNAME'];
    sUBDEPTNAMEKR = json['SUBDEPTNAME_KR'];
    mAINDEPTCODE = json['MAINDEPTCODE'];
    mAINDEPTNAME = json['MAINDEPTNAME'];
    mAINDEPTNAMEKR = json['MAINDEPTNAME_KR'];
    eMPLIMAGE = json['EMPL_IMAGE'];
    rESIGNDATE = json['RESIGN_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NV_CCID'] = nVCCID;
    data['id'] = id;
    data['EMPL_NO'] = eMPLNO;
    data['CMS_ID'] = cMSID;
    data['FIRST_NAME'] = fIRSTNAME;
    data['MIDLAST_NAME'] = mIDLASTNAME;
    data['DOB'] = dOB;
    data['HOMETOWN'] = hOMETOWN;
    data['ADD_PROVINCE'] = aDDPROVINCE;
    data['ADD_DISTRICT'] = aDDDISTRICT;
    data['ADD_COMMUNE'] = aDDCOMMUNE;
    data['ADD_VILLAGE'] = aDDVILLAGE;
    data['PHONE_NUMBER'] = pHONENUMBER;
    data['WORK_START_DATE'] = wORKSTARTDATE;
    data['PASSWORD'] = pASSWORD;
    data['EMAIL'] = eMAIL;
    data['REMARK'] = rEMARK;
    data['ONLINE_DATETIME'] = oNLINEDATETIME;
    data['CTR_CD'] = cTRCD;
    data['SEX_CODE'] = sEXCODE;
    data['SEX_NAME'] = sEXNAME;
    data['SEX_NAME_KR'] = sEXNAMEKR;
    data['WORK_STATUS_CODE'] = wORKSTATUSCODE;
    data['WORK_STATUS_NAME'] = wORKSTATUSNAME;
    data['WORK_STATUS_NAME_KR'] = wORKSTATUSNAMEKR;
    data['FACTORY_CODE'] = fACTORYCODE;
    data['FACTORY_NAME'] = fACTORYNAME;
    data['FACTORY_NAME_KR'] = fACTORYNAMEKR;
    data['JOB_CODE'] = jOBCODE;
    data['JOB_NAME'] = jOBNAME;
    data['JOB_NAME_KR'] = jOBNAMEKR;
    data['POSITION_CODE'] = pOSITIONCODE;
    data['POSITION_NAME'] = pOSITIONNAME;
    data['POSITION_NAME_KR'] = pOSITIONNAMEKR;
    data['WORK_SHIFT_CODE'] = wORKSHIFTCODE;
    data['WORK_SHIF_NAME'] = wORKSHIFNAME;
    data['WORK_SHIF_NAME_KR'] = wORKSHIFNAMEKR;
    data['WORK_POSITION_CODE'] = wORKPOSITIONCODE;
    data['WORK_POSITION_NAME'] = wORKPOSITIONNAME;
    data['WORK_POSITION_NAME_KR'] = wORKPOSITIONNAMEKR;
    data['ATT_GROUP_CODE'] = aTTGROUPCODE;
    data['SUBDEPTCODE'] = sUBDEPTCODE;
    data['SUBDEPTNAME'] = sUBDEPTNAME;
    data['SUBDEPTNAME_KR'] = sUBDEPTNAMEKR;
    data['MAINDEPTCODE'] = mAINDEPTCODE;
    data['MAINDEPTNAME'] = mAINDEPTNAME;
    data['MAINDEPTNAME_KR'] = mAINDEPTNAMEKR;
    data['EMPL_IMAGE'] = eMPLIMAGE;
    data['RESIGN_DATE'] = rESIGNDATE;
    return data;
  }
}
class PODATA {
  int? pOID;
  String? cUSTNAMEKD;
  String? pONO;
  String? gNAME;
  String? gNAMEKD;
  String? gCODE;
  String? pODATE;
  String? rDDATE;
  num? bEP;
  num? pRODPRICE;
  num? pOQTY;
  num? tOTALDELIVERED;
  num? pOBALANCE;
  num? pOAMOUNT;
  num? dELIVEREDAMOUNT;
  num? bALANCEAMOUNT;
  num? dELIVEREDBEPAMOUNT;
  String? eMPLNAME;
  String? pRODTYPE;
  dynamic mNAMEFULLBOM;
  String? pRODMAINMATERIAL;
  String? cUSTCD;
  String? eMPLNO;
  num? pOMONTH;
  num? pOWEEKNUM;
  String? oVERDUE;
  dynamic rEMARK;
  String? fINAL;

  PODATA(
      {this.pOID,
      this.cUSTNAMEKD,
      this.pONO,
      this.gNAME,
      this.gNAMEKD,
      this.gCODE,
      this.pODATE,
      this.rDDATE,
      this.bEP,
      this.pRODPRICE,
      this.pOQTY,
      this.tOTALDELIVERED,
      this.pOBALANCE,
      this.pOAMOUNT,
      this.dELIVEREDAMOUNT,
      this.bALANCEAMOUNT,
      this.dELIVEREDBEPAMOUNT,
      this.eMPLNAME,
      this.pRODTYPE,
      this.mNAMEFULLBOM,
      this.pRODMAINMATERIAL,
      this.cUSTCD,
      this.eMPLNO,
      this.pOMONTH,
      this.pOWEEKNUM,
      this.oVERDUE,
      this.rEMARK,
      this.fINAL});

  PODATA.fromJson(Map<String, dynamic> json) {
    pOID = json['PO_ID'];
    cUSTNAMEKD = json['CUST_NAME_KD'];
    pONO = json['PO_NO'];
    gNAME = json['G_NAME'];
    gNAMEKD = json['G_NAME_KD'];
    gCODE = json['G_CODE'];
    pODATE = json['PO_DATE'];
    rDDATE = json['RD_DATE'];
    bEP = json['BEP'];
    pRODPRICE = json['PROD_PRICE'];
    pOQTY = json['PO_QTY'];
    tOTALDELIVERED = json['TOTAL_DELIVERED'];
    pOBALANCE = json['PO_BALANCE'];
    pOAMOUNT = json['PO_AMOUNT'];
    dELIVEREDAMOUNT = json['DELIVERED_AMOUNT'];
    bALANCEAMOUNT = json['BALANCE_AMOUNT'];
    dELIVEREDBEPAMOUNT = json['DELIVERED_BEP_AMOUNT'];
    eMPLNAME = json['EMPL_NAME'];
    pRODTYPE = json['PROD_TYPE'];
    mNAMEFULLBOM = json['M_NAME_FULLBOM'];
    pRODMAINMATERIAL = json['PROD_MAIN_MATERIAL'];
    cUSTCD = json['CUST_CD'];
    eMPLNO = json['EMPL_NO'];
    pOMONTH = json['POMONTH'];
    pOWEEKNUM = json['POWEEKNUM'];
    oVERDUE = json['OVERDUE'];
    rEMARK = json['REMARK'];
    fINAL = json['FINAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PO_ID'] = pOID;
    data['CUST_NAME_KD'] = cUSTNAMEKD;
    data['PO_NO'] = pONO;
    data['G_NAME'] = gNAME;
    data['G_NAME_KD'] = gNAMEKD;
    data['G_CODE'] = gCODE;
    data['PO_DATE'] = pODATE;
    data['RD_DATE'] = rDDATE;
    data['BEP'] = bEP;
    data['PROD_PRICE'] = pRODPRICE;
    data['PO_QTY'] = pOQTY;
    data['TOTAL_DELIVERED'] = tOTALDELIVERED;
    data['PO_BALANCE'] = pOBALANCE;
    data['PO_AMOUNT'] = pOAMOUNT;
    data['DELIVERED_AMOUNT'] = dELIVEREDAMOUNT;
    data['BALANCE_AMOUNT'] = bALANCEAMOUNT;
    data['DELIVERED_BEP_AMOUNT'] = dELIVEREDBEPAMOUNT;
    data['EMPL_NAME'] = eMPLNAME;
    data['PROD_TYPE'] = pRODTYPE;
    data['M_NAME_FULLBOM'] = mNAMEFULLBOM;
    data['PROD_MAIN_MATERIAL'] = pRODMAINMATERIAL;
    data['CUST_CD'] = cUSTCD;
    data['EMPL_NO'] = eMPLNO;
    data['POMONTH'] = pOMONTH;
    data['POWEEKNUM'] = pOWEEKNUM;
    data['OVERDUE'] = oVERDUE;
    data['REMARK'] = rEMARK;
    data['FINAL'] = fINAL;
    return data;
  }
}
class CustomerListData {
  String? cUSTCD;
  String? cUSTNAMEKD;

  CustomerListData({this.cUSTCD, this.cUSTNAMEKD});

  CustomerListData.fromJson(Map<String, dynamic> json) {
    cUSTCD = json['CUST_CD'];
    cUSTNAMEKD = json['CUST_NAME_KD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CUST_CD'] = cUSTCD;
    data['CUST_NAME_KD'] = cUSTNAMEKD;
    return data;
  }
}

class CodeListData {
  String? gCODE;
  String? gNAME;
  String? gNAMEKD;
  num? pRODLASTPRICE;
  String? uSEYN;

  CodeListData(
      {this.gCODE, this.gNAME, this.gNAMEKD, this.pRODLASTPRICE, this.uSEYN});

  CodeListData.fromJson(Map<String, dynamic> json) {
    gCODE = json['G_CODE'];
    gNAME = json['G_NAME'];
    gNAMEKD = json['G_NAME_KD'];
    pRODLASTPRICE = json['PROD_LAST_PRICE'];
    uSEYN = json['USE_YN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['G_CODE'] = gCODE;
    data['G_NAME'] = gNAME;
    data['G_NAME_KD'] = gNAMEKD;
    data['PROD_LAST_PRICE'] = pRODLASTPRICE;
    data['USE_YN'] = uSEYN;
    return data;
  }
}
