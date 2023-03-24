class MaterialInputHistoryData {
  String? planId;
  String? mCode;
  String? mLotNo;
  int? totalOutQty;
  int? remainQty;
  String? equipmentCd;
  String? insDate;

  MaterialInputHistoryData(
      {this.planId,
      this.mCode,
      this.mLotNo,
      this.totalOutQty,
      this.remainQty,
      this.equipmentCd,
      this.insDate});

  MaterialInputHistoryData.fromJson(Map<String, dynamic> json) {
    planId = json['PLAN_ID'];
    mCode = json['M_CODE'];
    mLotNo = json['M_LOT_NO'];
    totalOutQty = json['TOTAL_OUT_QTY'];
    remainQty = json['REMAIN_QTY'];
    equipmentCd = json['EQUIPMENT_CD'];
    insDate = json['INS_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PLAN_ID'] = this.planId;
    data['M_CODE'] = this.mCode;
    data['M_LOT_NO'] = this.mLotNo;
    data['TOTAL_OUT_QTY'] = this.totalOutQty;
    data['REMAIN_QTY'] = this.remainQty;
    data['EQUIPMENT_CD'] = this.equipmentCd;
    data['INS_DATE'] = this.insDate;
    return data;
  }
}
