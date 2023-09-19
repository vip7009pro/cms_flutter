
class MaterialInputHistoryData {
  String? planId;
  String? mCode;
  String? mName;
  int? widthCd;
  String? mLotNo;
  int? totalOutQty;
  int? remainQty;
  String? equipmentCd;
  String? insDate;

  MaterialInputHistoryData(
      {this.planId,
      this.mCode,
      this.mName,
      this.widthCd,
      this.mLotNo,
      this.totalOutQty,
      this.remainQty,
      this.equipmentCd,
      this.insDate});

  MaterialInputHistoryData.fromJson(Map<String, dynamic> json) {
    planId = json['PLAN_ID'];
    mCode = json['M_CODE'];
    mName = json['M_NAME'];
    widthCd = json['WIDTH_CD'];
    mLotNo = json['M_LOT_NO'];
    totalOutQty = json['TOTAL_OUT_QTY'];
    remainQty = json['REMAIN_QTY'];
    equipmentCd = json['EQUIPMENT_CD'];
    insDate = json['INS_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PLAN_ID'] = planId;
    data['M_CODE'] = mCode;
    data['M_NAME'] = mName;
    data['WIDTH_CD'] = widthCd;
    data['M_LOT_NO'] = mLotNo;
    data['TOTAL_OUT_QTY'] = totalOutQty;
    data['REMAIN_QTY'] = remainQty;
    data['EQUIPMENT_CD'] = equipmentCd;
    data['INS_DATE'] = insDate;
    return data;
  }
}
