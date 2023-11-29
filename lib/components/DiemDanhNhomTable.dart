// ignore: file_names
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// The home page of the application which hosts the datagrid.
class DiemDanhNhomTable extends StatefulWidget {
  /// Creates the home page.
  // ignore: prefer_const_constructors_in_immutables
  DiemDanhNhomTable({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _DiemDanhNhomTableState createState() => _DiemDanhNhomTableState();
}

class _DiemDanhNhomTableState extends State<DiemDanhNhomTable> {
  List<DiemDanhNhom> employees = <DiemDanhNhom>[];
  @override
  void initState() {
    super.initState();
  }

  Future<void> loadData() async {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 241, 241, 241),
                    Color.fromARGB(255, 255, 255, 255),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                width: double.infinity,
                height: double.infinity,
                child: const DiemDanhNhomList())));
  }
}

class DiemDanhNhomList extends StatefulWidget {
  const DiemDanhNhomList({Key? key}) : super(key: key);
  @override
  _DiemDanhNhomListState createState() => _DiemDanhNhomListState();
}

class _DiemDanhNhomListState extends State<DiemDanhNhomList> {
  List<DiemDanhNhom> _listDiemDanh = List.empty(),
      _orgListDiemDanh = List.empty();
  TextEditingController _filterController = TextEditingController();
  String _searchString = "";
  Future<bool> setDiemDanhNhom(
      int currentTeam, int currentCa, String emplNo, int diemdanhvalue) async {
    bool check = true;
    await API_Request.api_query('setdiemdanhnhom', {
      'CURRENT_TEAM': currentTeam,
      'CURRENT_CA': currentCa,
      'EMPL_NO': emplNo,
      'diemdanhvalue': diemdanhvalue
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
      } else {
        check = false;
      }
    });
    return check;
  }

  Future<bool> dangKyTangCa(String overtimeInfo, String emplNo) async {
    bool check = true;
    await API_Request.api_query('dangkytangcanhom', {
      'tangcavalue': overtimeInfo == "KTC" ? 0 : 1,
      'EMPL_NO': emplNo,
      'overtime_info': overtimeInfo,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
      } else {
        check = false;
      }
    });
    return check;
  }

  Future<bool> dangKyNghiAuto(
      int canghi, int reasonCode, String remarkContent, String emplNo) async {
    bool check = true;
    DateTime now = DateTime.now();
    await API_Request.api_query('dangkynghi2_AUTO', {
      'canghi': 1,
      'reason_code': reasonCode,
      'remark_content': "AUTO",
      'ngaybatdau': DateFormat('yyyy-MM-dd').format(now),
      'ngayketthuc': DateFormat('yyyy-MM-dd').format(now),
      'EMPL_NO': emplNo,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
        if (reasonCode == 5) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Thông báo',
            desc: 'Nghỉ 50% tự đăng ký nghỉ chế độ !',
            btnOkOnPress: () {},
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Thông báo',
            desc: 'Nghỉ không đăng ký Auto điểm danh nghỉ việc riêng !',
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        check = false;
      }
    });
    return check;
  }

  Future<bool> xoaDangKyNghiAuto(String emplNo) async {
    bool check = true;
    DateTime now = DateTime.now();
    await API_Request.api_query('xoadangkynghi_AUTO', {
      'EMPL_NO': emplNo,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
      } else {
        check = false;
      }
    });
    return check;
  }

  Future<void> loadDiemDanhNhom() async {
    API_Request.api_query('diemdanhnhom', {'team_name_list': 5}).then((value) {
      setState((() {
        if (value['tk_status'] == 'OK') {
          List<dynamic> dynamicList = value['data'];
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Thông báo',
            desc: 'Đã load ${dynamicList.length} dòng',
            btnOkOnPress: () {},
          ).show();
          _listDiemDanh = dynamicList.map((dynamic item) {
            return DiemDanhNhom.fromJson(item);
          }).toList();
          _orgListDiemDanh = _listDiemDanh;
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Cảnh báo',
            desc: 'Không có dòng nào !',
            btnOkOnPress: () {},
          ).show();
        }
      }));
    });
  }

  void filteringList() {
    setState(() {
      _listDiemDanh = GlobalFunction.convertVietnameseString(
                  _filterController.text.toLowerCase()) !=
              ""
          ? _orgListDiemDanh.where((element) {
              String fullName = GlobalFunction.convertVietnameseString(
                  ("${element.midlastName} ${element.firstName} ${element.cmsId} ${element.emplNo}")
                      .toLowerCase());
              String searchString = GlobalFunction.convertVietnameseString(
                      _filterController.text.toLowerCase())
                  .trim();
              return fullName.contains(searchString);
            }).toList()
          : _orgListDiemDanh;
    });
  }

  @override
  void initState() {
    loadDiemDanhNhom();
    _filterController.addListener(() {
      filteringList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final search = TextFormField(
      controller: _filterController,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Tìm tên....',
        contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        search,
        Flexible(
            child: RefreshIndicator(
                onRefresh: loadDiemDanhNhom,
                child: ListView.builder(
                  itemBuilder: ((BuildContext context, int index) {
                    final avatar = CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'http://14.160.33.94/Picture_NS/NS_${_listDiemDanh[index].emplNo}.jpg'),
                    );
                    final diemdanhWidget = Wrap(spacing: 8.0, children: [
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await setDiemDanhNhom(
                              _listDiemDanh[index].workShifName == "Hành Chính"
                                  ? 0
                                  : _listDiemDanh[index].workShifName ==
                                          "TEAM 1"
                                      ? 1
                                      : 2,
                              1,
                              _listDiemDanh[index].emplNo,
                              1);
                          if (updated) {
                            setState(() {
                              _listDiemDanh[index].onOff = 1;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.green),
                        child: const Text("Làm ngày",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await setDiemDanhNhom(
                              _listDiemDanh[index].workShifName == "Hành Chính"
                                  ? 0
                                  : _listDiemDanh[index].workShifName ==
                                          "TEAM 1"
                                      ? 1
                                      : 2,
                              0,
                              _listDiemDanh[index].emplNo,
                              1);
                          if (updated) {
                            setState(() {
                              _listDiemDanh[index].onOff = 1;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.green),
                        child: const Text("Làm đêm",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await setDiemDanhNhom(
                              _listDiemDanh[index].workShifName == "Hành Chính"
                                  ? 0
                                  : _listDiemDanh[index].workShifName ==
                                          "TEAM 1"
                                      ? 1
                                      : 2,
                              1,
                              _listDiemDanh[index].emplNo,
                              1);
                          if (updated) {
                            dangKyNghiAuto(
                                1, 5, "AUTO", _listDiemDanh[index].emplNo);
                            setState(() {
                              _listDiemDanh[index].onOff = 1;
                              _listDiemDanh[index].reasonName = "Chế độ";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.orange),
                        child: const Text("Nghỉ 50%",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await setDiemDanhNhom(
                              _listDiemDanh[index].workShifName == "Hành Chính"
                                  ? 0
                                  : _listDiemDanh[index].workShifName ==
                                          "TEAM 1"
                                      ? 1
                                      : 2,
                              1,
                              _listDiemDanh[index].emplNo,
                              0);
                          if (updated) {
                            if (_listDiemDanh[index].offId == null) {
                              dangKyNghiAuto(
                                  1, 3, "AUTO", _listDiemDanh[index].emplNo);
                            }
                            setState(() {
                              _listDiemDanh[index].onOff = 0;
                              _listDiemDanh[index].reasonName =
                                  "Nghỉ việc riêng";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.red),
                        child: const Text("Nghỉ làm",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                    ]);
                    final tangcawidget = Wrap(spacing: 8.0, children: [
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await dangKyTangCa("KTC", _listDiemDanh[index].emplNo);      
                          if(updated) {
                            setState(() {
                              _listDiemDanh[index].overtime = 0;
                              _listDiemDanh[index].overtimeInfo = "KTC";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.red),
                        child: const Text("Không TC",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                           bool updated = await dangKyTangCa("1700-2000", _listDiemDanh[index].emplNo);      
                          if(updated) {
                            setState(() {
                              _listDiemDanh[index].overtime = 1;
                              _listDiemDanh[index].overtimeInfo = "17H-20H";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.blueAccent),
                        child: const Text("17H-20H",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await dangKyTangCa("0500-0800", _listDiemDanh[index].emplNo);      
                          if(updated) {
                            setState(() {
                              _listDiemDanh[index].overtime = 1;
                              _listDiemDanh[index].overtimeInfo = "05H-08H";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.blueAccent),
                        child: const Text("05H-08H",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool updated = await dangKyTangCa("1700-1800", _listDiemDanh[index].emplNo);      
                          if(updated) {
                            setState(() {
                              _listDiemDanh[index].overtime = 1;
                              _listDiemDanh[index].overtimeInfo = "17H-18H";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Colors.blueAccent),
                        child: const Text("17H-18H",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                    ]);
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2.0,
                            blurRadius: 5.0,
                            offset: const Offset(
                                0, 3), // Changes the position of the shadow
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 189, 241, 176),
                              Color.fromARGB(255, 245, 235, 248),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 140.0,
                            width: 65,
                            child: Column(
                              children: [
                                avatar,
                                Text(_listDiemDanh[index].emplNo),
                                Text(_listDiemDanh[index].cmsId),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          SizedBox(
                            height: 140,
                            width: 240,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}.${_listDiemDanh[index].midlastName} ${_listDiemDanh[index].firstName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  "${_listDiemDanh[index].factoryName}/ ${_listDiemDanh[index].workShifName}",
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                                _listDiemDanh[index].onOff == 1
                                    ? const Text("Đi làm",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold))
                                    : _listDiemDanh[index].onOff == 0
                                        ? Row(
                                            children: [
                                              const Text("Nghỉ làm",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "(${_listDiemDanh[index].reasonName})",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        : diemdanhWidget,
                                _listDiemDanh[index].overtime == null
                                    ? tangcawidget
                                    : Text(
                                        _listDiemDanh[index].overtimeInfo ??
                                            "KTC",
                                        style: const TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _listDiemDanh[index].onOff = null;
                                  _listDiemDanh[index].overtime = null;
                                  xoaDangKyNghiAuto(
                                      _listDiemDanh[index].emplNo);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5.0),
                                  backgroundColor: Colors.yellowAccent),
                              child: const Text("RESET",
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.black)),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  itemCount: _listDiemDanh.length,
                ))),
      ],
    );
  }
}
