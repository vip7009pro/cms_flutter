import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/pages/phongban/nhansu/QuanLyPhongBanNhanSu.dart';
import 'package:cms_flutter/pages/phongban/nhansu/work_position_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SubDeptScreen extends StatefulWidget {
  final int MAINDEPTCODE;
  const SubDeptScreen({Key? key, required this.MAINDEPTCODE}) : super(key: key);
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
                                offset: const Offset(
                                    0, 3), // Changes the position of the shadow
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
                            title: Text(_subDeptList[index].sUBDEPTNAME ?? ""),
                            subtitle:
                                Text(_subDeptList[index].sUBDEPTNAMEKR ?? ""),
                            iconColor: Colors.black,
                            onTap: () {
                              Get.to(() => WorkPositionScreen(SUBDEPTCODE: _subDeptList[index].sUBDEPTCODE??0,));
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
                              child:
                                  const Icon(Icons.house, color: Colors.white),
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
                                    // Handle menu item selection here
                                    print('Selected: $value');
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
                          backgroundColor: const Color.fromARGB(255, 60, 137, 236),
                          child: const Icon(Icons.add),
                          onPressed: () {});
                    }),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
                  ))),
        ],
      ),
    );
  }
}
