class DiemDanhNhomTableData {
  String? cTRCD;
  String? eMPLNO;

  DiemDanhNhomTableData({
    this.cTRCD,
    this.eMPLNO,
  });

  DiemDanhNhomTableData.fromJson(Map<String, dynamic> json) {
    cTRCD = json['CTR_CD'];
    eMPLNO = json['EMPL_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CTR_CD'] = cTRCD;
    data['EMPL_NO'] = eMPLNO;

    return data;
  }
}
