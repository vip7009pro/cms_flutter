import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/pages/phongban/nhansu/screen/employee_info_screen.dart';
import 'package:cms_flutter/pages/phongban/nhansu/screen/work_position_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class QuanLyNhanSu extends StatefulWidget {
  const QuanLyNhanSu({
    super.key,
  });
  @override
  _SubDeptScreenState createState() => _SubDeptScreenState();
}
class _SubDeptScreenState extends State<QuanLyNhanSu> {
  final GlobalController globalC = Get.put(GlobalController());
  final String _searchString = "";
  String _teamNameList = "ALL";
  bool _allTeam = false;
  final TextEditingController _filterController = TextEditingController();
  List<SUBDEPTDATA> _subDeptList = List.empty();
  List<EmployeeData> _employeeList = List.empty();
  List<EmployeeData> _org_employeeList = List.empty();
  Future<void> _loadEmployeeList() async {
    await API_Request.api_query('getemployee_full', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        /* AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đã load ${dynamicList.length} dòng',
          btnOkOnPress: () {},
        ).show(); */
        setState(() {
          _employeeList = dynamicList.map((dynamic item) {
            return EmployeeData.fromJson(item);
          }).toList();
          _org_employeeList = _employeeList;
        });
      } else {}
    });
  }
  void filteringList() {
    setState(() {
      _employeeList = GlobalFunction.convertVietnameseString(
                      _filterController.text.toLowerCase()) !=
                  "" ||
              _teamNameList != 'ALL'
          ? _org_employeeList.where((element) {
              String fullName = GlobalFunction.convertVietnameseString(
                  ("${element.mIDLASTNAME} ${element.fIRSTNAME} ${element.cMSID} ${element.eMPLNO}")
                      .toLowerCase());
              String searchString = GlobalFunction.convertVietnameseString(
                      _filterController.text.toLowerCase())
                  .trim();
              bool checknghi = element.wORKSTATUSCODE != 0 || _allTeam == true;
              bool checkTeam = element.wORKSHIFNAME == _teamNameList ||
                  _teamNameList == 'ALL';
              //print('checknghi' + checknghi.toString());
              return fullName.contains(searchString) && checkTeam && checknghi;
            }).toList()
          : _org_employeeList;
    });
  }
  Future<void> _loadSubDept() async {
    await API_Request.api_query('getsubdept', {'MAINDEPTCODE': 1})
        .then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        /* AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đã load ${dynamicList.length} dòng',
          btnOkOnPress: () {},
        ).show(); */
        setState(() {
          _subDeptList = dynamicList.map((dynamic item) {
            return SUBDEPTDATA.fromJson(item);
          }).toList();
        });
      } else {}
    });
  }
  Future<void> _addSubDept(int MAINDEPTCODE, int sUBDEPTCODE,
      String sUBDEPTNAME, String sUBDEPTNAMEKR) async {
    await API_Request.api_query('insertsubdept', {
      'MAINDEPTCODE': MAINDEPTCODE,
      'SUBDEPTCODE': sUBDEPTCODE,
      'SUBDEPTNAME': sUBDEPTNAME,
      'SUBDEPTNAME_KR': sUBDEPTNAMEKR,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm SUBDEPT thành công',
          btnOkOnPress: () {},
        ).show();
        _loadSubDept();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm SUBDEPT thất bại: ${value['message']}',
          btnOkOnPress: () {},
        ).show();
      }
    });
  }
  Future<void> _updateSubDept(
      int sUBDEPTCODE, String sUBDEPTNAME, String sUBDEPTNAMEKR) async {
    await API_Request.api_query('updatesubdept', {
      'SUBDEPTCODE': sUBDEPTCODE,
      'SUBDEPTNAME': sUBDEPTNAME,
      'SUBDEPTNAME_KR': sUBDEPTNAMEKR,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update SUBDEPT thành công',
          btnOkOnPress: () {},
        ).show();
        _loadSubDept();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update SUBDEPT thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show();
      }
    });
  }
  Future<void> _deleteSubDept(int sUBDEPTCODE) async {
    await API_Request.api_query('deletesubdept', {
      'SUBDEPTCODE': sUBDEPTCODE,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xóa SUBDEPT thành công',
          btnOkOnPress: () {},
        ).show();
        _loadSubDept();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xóa SUBDEPT thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show();
      }
    });
  }
  @override
  void initState() {
    _loadEmployeeList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final search = Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: const Offset(0, 3), // Changes the position of the shadow
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 197, 241, 176),
              Color.fromARGB(255, 174, 207, 236),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: _allTeam,
                    onChanged: (value) {
                      setState(() {
                        _allTeam = value!;
                        filteringList();
                        //_loadEmployeeList();
                      });
                    }),
                const Text("All")
              ],
            ),
          ),
          SizedBox(
            width: 120,
            child: DropdownButton<String>(
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              menuMaxHeight: 200,
              value: _teamNameList,
              onChanged: (newValue) {
                setState(() {
                  _teamNameList = newValue!;
                  filteringList();
                });
              },
              items: ['ALL', 'TEAM 1', 'TEAM 2', 'Hành Chính']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: 150,
            height: 30,
            child: TextFormField(
              controller: _filterController,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                filteringList();
              },
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Tìm tên....',
                contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          search,
          Flexible(
              child: RefreshIndicator(
                  onRefresh: _loadEmployeeList,
                  child: Scaffold(
                      body: ListView.builder(
                        itemBuilder: ((BuildContext context, int index) {
                          final avatar = CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'http://14.160.33.94/Picture_NS/NS_${_employeeList[index].eMPLNO}.jpg'),
                          );
                          return Container(
                            margin: const EdgeInsets.all(2.0),
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0,
                                  offset: const Offset(0,
                                      3), // Changes the position of the shadow
                                )
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              gradient: LinearGradient(
                                  colors: [
                                    _employeeList[index].wORKSTATUSCODE == 1
                                        ? const Color.fromARGB(255, 229, 178, 245)
                                        : _employeeList[index].wORKSTATUSCODE ==
                                                2
                                            ? const Color.fromARGB(255, 211, 231, 119)
                                            : const Color.fromARGB(
                                                255, 144, 139, 146),
                                    const Color.fromARGB(255, 245, 235, 248),
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: const [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: ListTile(
                                title: Text(
                                    "${_employeeList[index].eMPLNO ?? ""}_${_employeeList[index].mIDLASTNAME ?? ""} ${_employeeList[index].fIRSTNAME ?? ""}"),
                                subtitle: Text(
                                    '${_employeeList[index].mAINDEPTNAME ?? ""}/${_employeeList[index].sUBDEPTNAME ?? ""}/${_employeeList[index].wORKPOSITIONNAME ?? ""}'),
                                iconColor: Colors.black,
                                onTap: () {
                                  Get.to(() => EmployeeInfoScreen(
                                      userData: _employeeList[index]));
                                },
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 156, 198, 233),
                                        Color.fromARGB(255, 108, 231, 110)
                                      ], // Your gradient colors
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        25), // Optional: for rounded corners
                                  ),
                                  child: avatar,
                                ),
                                /* Icon(Icons.man, color: Colors.red, size: 30,), */
                                trailing: const Icon(
                                  Icons.arrow_circle_right,
                                  color: Colors.black,
                                )),
                          );
                        }),
                        itemCount: _employeeList.length,
                      ),
                      floatingActionButton: Builder(builder: (context) {
                        return FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 60, 137, 236),
                            child: const Icon(Icons.add),
                            onPressed: () {
                              if (!CheckPermission(globalC.userData, ['NHANSU'],
                                  ['ALL'], ['ALL'], () {
                                Get.to(() => EmployeeInfoScreen(
                                    userData: EmployeeData(
                                        aDDCOMMUNE: "",
                                        aDDDISTRICT: "",
                                        aDDPROVINCE: "",
                                        aDDVILLAGE: "",
                                        aTTGROUPCODE: 1,
                                        cMSID: "---",
                                        cTRCD: "002",
                                        dOB: "1900-01-01",
                                        eMAIL: "",
                                        eMPLIMAGE: "",
                                        eMPLNO: "xxxx",
                                        fACTORYCODE: 1,
                                        fACTORYNAME: "NM1",
                                        fACTORYNAMEKR: "NM1",
                                        fIRSTNAME: "",
                                        hOMETOWN: "",
                                        id: "1",
                                        jOBCODE: 1,
                                        jOBNAME: "",
                                        jOBNAMEKR: "",
                                        mAINDEPTCODE: 1,
                                        mAINDEPTNAME: "",
                                        mAINDEPTNAMEKR: "",
                                        mIDLASTNAME: "",
                                        nVCCID: 1,
                                        oNLINEDATETIME: "",
                                        pASSWORD: "",
                                        pHONENUMBER: "",
                                        pOSITIONCODE: 1,
                                        pOSITIONNAME: "",
                                        pOSITIONNAMEKR: "",
                                        rEMARK: "",
                                        rESIGNDATE: "1900-01-01",
                                        sEXCODE: 1,
                                        sEXNAME: "",
                                        sEXNAMEKR: "",
                                        sUBDEPTCODE: 1,
                                        sUBDEPTNAME: "",
                                        sUBDEPTNAMEKR: "",
                                        wORKPOSITIONCODE: 1,
                                        wORKPOSITIONNAME: "",
                                        wORKPOSITIONNAMEKR: "",
                                        wORKSHIFNAME: "",
                                        wORKSHIFNAMEKR: "",
                                        wORKSHIFTCODE: 1,
                                        wORKSTARTDATE: "1900-01-01",
                                        wORKSTATUSCODE: 1,
                                        wORKSTATUSNAME: "",
                                        wORKSTATUSNAMEKR: "")));
                              })) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.topSlide,
                                  title: 'Cảnh báo',
                                  desc: 'Không đủ quyền hạn!',
                                  btnCancelOnPress: () {},
                                ).show();
                              }
                            });
                      }),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat))),
        ],
      ),
    );
  }
}
