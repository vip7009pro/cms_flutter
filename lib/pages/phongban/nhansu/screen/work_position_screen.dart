import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkPositionScreen extends StatefulWidget {
  final int SUBDEPTCODE;
  const WorkPositionScreen({Key? key, required this.SUBDEPTCODE})
      : super(key: key);

  @override
  _WorkPositionScreenState createState() => _WorkPositionScreenState();
}

class _WorkPositionScreenState extends State<WorkPositionScreen> {
  List<WORKPOSITIONDATA> _workPositionList = List.empty();
  Future<void> _loadWorkPosition() async {
    await API_Request.api_query(
        'getworkposition', {'SUBDEPTCODE': widget.SUBDEPTCODE}).then((value) {
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
          _workPositionList = dynamicList.map((dynamic item) {
            return WORKPOSITIONDATA.fromJson(item);
          }).toList();
        });
      } else {}
    });
  }

 Future<void> _addWorkPosition(int SUBDEPTCODE, int WORK_POSITION_CODE, String WORK_POSITION_NAME, String WORK_POSITION_NAME_KR, int ATT_GROUP_CODE ) async {
    await API_Request.api_query('insertworkposition', {      
      'SUBDEPTCODE':SUBDEPTCODE,
      'WORK_POSITION_CODE':WORK_POSITION_CODE,
      'WORK_POSITION_NAME':WORK_POSITION_NAME,
      'WORK_POSITION_NAME_KR':WORK_POSITION_NAME_KR,
      'ATT_GROUP_CODE':ATT_GROUP_CODE,
    }).then((value) {
      if (value['tk_status'] == 'OK') {        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm Work Position thành công',
          btnOkOnPress: () {},
        ).show();        
        _loadWorkPosition();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm Work Position thất bại: ${value['message']}',
          btnOkOnPress: () {},
        ).show(); 
      }
    });
  }
  Future<void> _updateWorkPosition(int sUBDEPTCODE, int WORK_POSITION_CODE, String WORK_POSITION_NAME, String WORK_POSITION_NAME_KR) async {    
     await API_Request.api_query('updateworkposition', {
      'SUBDEPTCODE':sUBDEPTCODE,
      'WORK_POSITION_CODE':WORK_POSITION_CODE,
      'WORK_POSITION_NAME':WORK_POSITION_NAME,
      'WORK_POSITION_NAME_KR':WORK_POSITION_NAME_KR,
    }).then((value) {
      if (value['tk_status'] == 'OK') {        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update Work Position thành công',
          btnOkOnPress: () {},
        ).show();   
        _loadWorkPosition();    
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update Work Position thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show(); 
      }
    });
    
  }
  Future<void> _deleteWorkPosition(int WORK_POSITION_CODE) async {
    await API_Request.api_query('deleteworkposition', {
      'WORK_POSITION_CODE':WORK_POSITION_CODE,      
    }).then((value) {
      if (value['tk_status'] == 'OK') {        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xóa Work Position thành công',
          btnOkOnPress: () {},
        ).show();   
        _loadWorkPosition();     
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xóa Work Position thất bại: ' + value['message'],
          btnOkOnPress: () {},
        ).show(); 
      }
    });
  }
  
  @override
  void initState() {
    _loadWorkPosition();
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
                  onRefresh: _loadWorkPosition,
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
                                  Color.fromARGB(255, 255, 154, 154),
                                  Color.fromARGB(255, 245, 235, 248),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: ListTile(
                            title: Text("${_workPositionList[index].wORKPOSITIONCODE ?? ""}_${_workPositionList[index].wORKPOSITIONNAME ?? ""}"),
                            subtitle: Text(
                                _workPositionList[index].wORKPOSITIONNAMEKR ??
                                    ""),
                            iconColor: Colors.black,
                            onTap: () {},
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
                                            TextEditingController _workpositionnamevnctrl = TextEditingController();
                                            TextEditingController _workpositionnamekrctrl = TextEditingController();
                                            _workpositionnamevnctrl.text = _workPositionList[index].wORKPOSITIONNAME??"";
                                            _workpositionnamekrctrl.text = _workPositionList[index].wORKPOSITIONNAMEKR??"";
                                          return AlertDialog(
                                            title: const Text('Edit SubDeparment'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                 TextField(
                                                  decoration:  const InputDecoration(
                                                    hintText: 'Work Pos Name VN',
                                                  ),
                                                  controller: _workpositionnamevnctrl,
                                                ),
                                                 TextField(
                                                  decoration:  const  InputDecoration(
                                                    hintText: 'Work Pos Name KR',
                                                  ),
                                                  controller: _workpositionnamekrctrl,
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Implement the button functionality here                                                   
                                                    _updateWorkPosition(widget.SUBDEPTCODE, _workPositionList[index].wORKPOSITIONCODE ?? 111111, _workpositionnamevnctrl.text, _workpositionnamekrctrl.text);                                                     

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
                                        desc: 'Bạn muốn xóa Work Pos Name: ${_workPositionList[index].wORKPOSITIONNAME?? ""}',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          _deleteWorkPosition(_workPositionList[index].wORKPOSITIONCODE??111111);
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
                      itemCount: _workPositionList.length,
                    ),
                   floatingActionButton: Builder(builder: (context) {
                      return FloatingActionButton(                        
                          backgroundColor: const Color.fromARGB(255, 60, 137, 236),
                          child: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                            TextEditingController _workpositioncodectrl = TextEditingController();
                                            TextEditingController _workpositionnamevnctrl = TextEditingController();
                                            TextEditingController _workpositionnamekrctrl = TextEditingController();
                                            TextEditingController _attgroupctrl = TextEditingController();
                                            _workpositioncodectrl.text = "";
                                            _workpositionnamevnctrl.text = "";
                                            _workpositionnamekrctrl.text = "";
                                            _attgroupctrl.text = "";
                                          return AlertDialog(
                                            title: const Text('Add Work Position'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                 TextField(
                                                  decoration:  const InputDecoration(
                                                    hintText: 'Work Pos Code',
                                                  ),
                                                  controller: _workpositioncodectrl,
                                                ),
                                                 TextField(
                                                  decoration:  const InputDecoration(
                                                    hintText: 'Work Pos Name VN',
                                                  ),
                                                  controller: _workpositionnamevnctrl,
                                                ),
                                                 TextField(
                                                  decoration:  const  InputDecoration(
                                                    hintText: 'Work Pos Name KR',
                                                  ),
                                                  controller: _workpositionnamekrctrl,
                                                ),
                                                 TextField(
                                                  decoration:  const  InputDecoration(
                                                    hintText: 'ATT Group Code',
                                                  ),
                                                  controller: _attgroupctrl,
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Implement the button functionality here
                                                    _addWorkPosition(widget.SUBDEPTCODE, int.parse(_workpositioncodectrl.text), _workpositionnamevnctrl.text, _workpositionnamekrctrl.text, int.parse(_attgroupctrl.text));
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
