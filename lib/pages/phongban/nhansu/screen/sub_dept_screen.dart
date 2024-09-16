import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/pages/phongban/nhansu/screen/work_position_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SubDeptScreen extends StatefulWidget {
  final int MAINDEPTCODE;
  const SubDeptScreen({super.key, required this.MAINDEPTCODE});
  @override
  _SubDeptScreenState createState() => _SubDeptScreenState();
}
class _SubDeptScreenState extends State<SubDeptScreen> {
  List<SUBDEPTDATA> _subDeptList = List.empty();
  Future<void> _loadSubDept() async {
    await API_Request.api_query(
        'getsubdept', {'MAINDEPTCODE': widget.MAINDEPTCODE}).then((value) {
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
    _loadSubDept();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: RefreshIndicator(
                  onRefresh: _loadSubDept,
                  child: Scaffold(
                      body: ListView.builder(
                        itemBuilder: ((BuildContext context, int index) {
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
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 231, 197, 245),
                                    Color.fromARGB(255, 245, 235, 248),
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: ListTile(
                              title: Text(
                                  "${_subDeptList[index].sUBDEPTCODE ?? ""}_${_subDeptList[index].sUBDEPTNAME ?? ""}"),
                              subtitle:
                                  Text(_subDeptList[index].sUBDEPTNAMEKR ?? ""),
                              iconColor: Colors.black,
                              onTap: () {
                                Get.to(() => WorkPositionScreen(
                                      SUBDEPTCODE:
                                          _subDeptList[index].sUBDEPTCODE ?? 0,
                                    ));
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
                                child: const Icon(Icons.house,
                                    color: Colors.white),
                              ),
                              /* Icon(Icons.man, color: Colors.red, size: 30,), */
                              trailing: GestureDetector(
                                onTapDown: (TapDownDetails details) {
                                  showMenu(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                      details.globalPosition.dx,
                                      details.globalPosition.dy,
                                      details.globalPosition.dx + 1,
                                      details.globalPosition.dy + 1,
                                    ),
                                    items: <PopupMenuEntry>[
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value != null) {
                                      if (value == 'edit') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            TextEditingController
                                                subdeptnamevnctrl =
                                                TextEditingController();
                                            TextEditingController
                                                subdeptnamekrctrl =
                                                TextEditingController();
                                            subdeptnamevnctrl.text =
                                                _subDeptList[index]
                                                        .sUBDEPTNAME ??
                                                    "";
                                            subdeptnamekrctrl.text =
                                                _subDeptList[index]
                                                        .sUBDEPTNAMEKR ??
                                                    "";
                                            return AlertDialog(
                                              title: const Text(
                                                  'Edit SubDeparment'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Sub Dept Name VN',
                                                    ),
                                                    controller:
                                                        subdeptnamevnctrl,
                                                  ),
                                                  TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Sub Dept Name KR',
                                                    ),
                                                    controller:
                                                        subdeptnamekrctrl,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Implement the button functionality here
                                                      _updateSubDept(
                                                          _subDeptList[index]
                                                                  .sUBDEPTCODE ??
                                                              111111,
                                                          subdeptnamevnctrl
                                                              .text,
                                                          subdeptnamekrctrl
                                                              .text);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Save'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else if (value == 'delete') {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          title: 'Cảnh báo',
                                          desc:
                                              'Bạn muốn xóa subdept: ${_subDeptList[index].sUBDEPTNAME ?? ""}',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            _deleteSubDept(_subDeptList[index]
                                                    .sUBDEPTCODE ??
                                                111111);
                                          },
                                        ).show();
                                      }
                                    }
                                  });
                                },
                                child: const Icon(Icons.more_vert),
                              ),
                            ),
                          );
                        }),
                        itemCount: _subDeptList.length,
                      ),
                      floatingActionButton: Builder(builder: (context) {
                        return FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 60, 137, 236),
                            child: const Icon(Icons.add),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController subdeptcodectrl =
                                      TextEditingController();
                                  TextEditingController subdeptnamevnctrl =
                                      TextEditingController();
                                  TextEditingController subdeptnamekrctrl =
                                      TextEditingController();
                                  subdeptcodectrl.text = "";
                                  subdeptnamevnctrl.text = "";
                                  subdeptnamekrctrl.text = "";
                                  return AlertDialog(
                                    title: const Text('Add Sub Deparment'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Sub Dept Code',
                                          ),
                                          controller: subdeptcodectrl,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Sub Dept Name VN',
                                          ),
                                          controller: subdeptnamevnctrl,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Sub Dept Name KR',
                                          ),
                                          controller: subdeptnamekrctrl,
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Implement the button functionality here
                                            _addSubDept(
                                                widget.MAINDEPTCODE,
                                                int.parse(
                                                    subdeptcodectrl.text),
                                                subdeptnamevnctrl.text,
                                                subdeptnamekrctrl.text);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Create New'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                      }),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat))),
        ],
      ),
    );
  }
}
