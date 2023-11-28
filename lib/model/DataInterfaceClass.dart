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
