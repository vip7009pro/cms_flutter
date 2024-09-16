import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/pages/phongban/nhansu/screen/sub_dept_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuanLyPhongBan extends StatefulWidget {
  const QuanLyPhongBan({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _QuanLyPhongBanState createState() => _QuanLyPhongBanState();
}
class _QuanLyPhongBanState extends State<QuanLyPhongBan> {
  List<MAINDEPTDATA> _mainDeptList = List.empty();
  Future<void> _loadMainDept() async {
    await API_Request.api_query('getmaindept', {}).then((value) {
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
          _mainDeptList = dynamicList.map((dynamic item) {
            return MAINDEPTDATA.fromJson(item);
          }).toList();
        });
      } else {}
    });
  }
  Future<void> _addMainDept(int MAINDEPTCODE, String MAINDEPTNAME, String maindeptnameKr) async {
    await API_Request.api_query('insertmaindept', {
      'MAINDEPTCODE':MAINDEPTCODE,
      'MAINDEPTNAME':MAINDEPTNAME,
      'MAINDEPTNAME_KR':maindeptnameKr,
    }).then((value) {
      if (value['tk_status'] == 'OK') {        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm MAINDEPT thành công',
          btnOkOnPress: () {},
        ).show();        
        _loadMainDept();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm MAINDEPT thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show(); 
      }
    });
  }
  Future<void> _updateMainDept(int MAINDEPTCODE, String MAINDEPTNAME, String maindeptnameKr) async {
    
     await API_Request.api_query('updatemaindept', {
      'MAINDEPTCODE':MAINDEPTCODE,
      'MAINDEPTNAME':MAINDEPTNAME,
      'MAINDEPTNAME_KR':maindeptnameKr,
    }).then((value) {
      if (value['tk_status'] == 'OK') {        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update MAINDEPT thành công',
          btnOkOnPress: () {},
        ).show();   
        _loadMainDept();    
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update MAINDEPT thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show(); 
      }
    });
    
  }
  Future<void> _deleteMainDept(int MAINDEPTCODE) async {
    await API_Request.api_query('deletemaindept', {
      'MAINDEPTCODE':MAINDEPTCODE,      
    }).then((value) {
      if (value['tk_status'] == 'OK') {        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xóa MAINDEPT thành công',
          btnOkOnPress: () {},
        ).show();      
        _loadMainDept();  
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xóa MAINDEPT thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show(); 
      }
    });
  }
  @override
  void initState() {
    _loadMainDept();
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
                  onRefresh: _loadMainDept,
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
                                  Color.fromARGB(255, 240, 238, 131),
                                  Color.fromARGB(255, 245, 235, 248),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: ListTile(
                            title:
                                Text("${_mainDeptList[index].MAINDEPTCODE ?? ""}_${_mainDeptList[index].MAINDEPTNAME ?? ""}"),
                            subtitle: Text(
                                _mainDeptList[index].MAINDEPTNAME_KR ?? ""),
                            iconColor: Colors.black,
                            onTap: () {
                              Get.to(() => SubDeptScreen(
                                    MAINDEPTCODE:
                                        _mainDeptList[index].MAINDEPTCODE ?? 0,
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
                                    if(value=='edit')
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                            TextEditingController maindeptnamevnctrl = TextEditingController();
                                            TextEditingController maindeptnamekrctrl = TextEditingController();
                                            maindeptnamevnctrl.text = _mainDeptList[index].MAINDEPTNAME??"";
                                            maindeptnamekrctrl.text = _mainDeptList[index].MAINDEPTNAME_KR??"";
                                          return AlertDialog(
                                            title: const Text('Edit Deparment'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                 TextField(
                                                  decoration:  const InputDecoration(
                                                    hintText: 'Main Dept Name VN',
                                                  ),
                                                  controller: maindeptnamevnctrl,
                                                ),
                                                 TextField(
                                                  decoration:  const  InputDecoration(
                                                    hintText: 'Main Dept Name KR',
                                                  ),
                                                  controller: maindeptnamekrctrl,
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Implement the button functionality here                                                   
                                                    _updateMainDept(_mainDeptList[index].MAINDEPTCODE ?? 111111, maindeptnamevnctrl.text, maindeptnamekrctrl.text);                                                     

                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const  Text('Save'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                    }
                                    else if(value=='delete') {
                                       AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.question,
                                        animType: AnimType.rightSlide,
                                        title: 'Cảnh báo',
                                        desc: 'Bạn muốn xóa maindept: ${_mainDeptList[index].MAINDEPTNAME?? ""}',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          _deleteMainDept(_mainDeptList[index].MAINDEPTCODE??111111);
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
                      itemCount: _mainDeptList.length,
                    ),
                    floatingActionButton: Builder(builder: (context) {
                      return FloatingActionButton(                        
                          backgroundColor: const Color.fromARGB(255, 60, 137, 236),
                          child: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                            TextEditingController maindeptcodectrl = TextEditingController();
                                            TextEditingController maindeptnamevnctrl = TextEditingController();
                                            TextEditingController maindeptnamekrctrl = TextEditingController();
                                            maindeptcodectrl.text = "";
                                            maindeptnamevnctrl.text = "";
                                            maindeptnamekrctrl.text = "";
                                          return AlertDialog(
                                            title: const Text('Add Deparment'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                 TextField(
                                                  decoration:  const InputDecoration(
                                                    hintText: 'Main Dept Code',
                                                  ),
                                                  controller: maindeptcodectrl,
                                                ),
                                                 TextField(
                                                  decoration:  const InputDecoration(
                                                    hintText: 'Main Dept Name VN',
                                                  ),
                                                  controller: maindeptnamevnctrl,
                                                ),
                                                 TextField(
                                                  decoration:  const  InputDecoration(
                                                    hintText: 'Main Dept Name KR',
                                                  ),
                                                  controller: maindeptnamekrctrl,
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Implement the button functionality here
                                                    _addMainDept(int.parse(maindeptcodectrl.text), maindeptnamevnctrl.text, maindeptnamekrctrl.text);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const  Text('Create New'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                          });
                    }),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
                    
                  ))),
        ],
      ),
    );
  }
}