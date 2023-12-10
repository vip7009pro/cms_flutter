import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
class PheDuyetNghi extends StatefulWidget {
  const PheDuyetNghi({Key? key}) : super(key: key);
  @override
  _PheDuyetNghiState createState() => _PheDuyetNghiState();
}
class _PheDuyetNghiState extends State<PheDuyetNghi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LeaveApprovalForm(),
    );
  }
}

class LeaveApprovalForm extends StatefulWidget {
  @override
  _LeaveApprovalFormState createState() => _LeaveApprovalFormState();
}
class _LeaveApprovalFormState extends State<LeaveApprovalForm> {

  List<PheDuyetNhomData> _listPheDuyet = List.empty(),
      _orgListPheDuyet = List.empty();
  bool _allTeam = false;
  String _searchString = "";
  String _teamNameList = "ALL";
  TextEditingController _filterController = TextEditingController();

  void filteringList() {
    setState(() {
      _listPheDuyet = GlobalFunction.convertVietnameseString(
                      _filterController.text.toLowerCase()) !=
                  "" ||
              _teamNameList != 'ALL'
          ? _orgListPheDuyet.where((element) {
              String fullName = GlobalFunction.convertVietnameseString(
                  ("${element.mIDLASTNAME} ${element.fIRSTNAME} ${element.cMSID} ${element.eMPLNO}")
                      .toLowerCase());
              String searchString = GlobalFunction.convertVietnameseString(
                      _filterController.text.toLowerCase())
                  .trim();
              bool checkTeam = element.wORKSHIFNAME == _teamNameList ||
                  _teamNameList == 'ALL';
              return fullName.contains(searchString) && checkTeam;
            }).toList()
          : _orgListPheDuyet;
    });
  }
  Future<void> loadPheDuyetNghi() async {
    API_Request.api_query(_allTeam ? 'pheduyetnhomBP' : 'pheduyetnhom', {})
        .then((value) {
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
          _listPheDuyet = dynamicList.map((dynamic item) {
            return PheDuyetNhomData.fromJson(item);
          }).toList();
          _orgListPheDuyet = _listPheDuyet;
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

  Future<bool> setPheDuyetNhom(
    int pheduyetValue, int offID) async {
  bool check = true;
  await API_Request.api_query('setpheduyetnhom', {
    'off_id': offID,
    'pheduyetvalue': pheduyetValue,
  }).then((value) {
    if (value['tk_status'] == 'OK') {
      check = true;
    } else {
      check = false;
    }
  });
  return check;
  }

  @override
  void initState() {
    loadPheDuyetNghi();
    _filterController.addListener(() {
      filteringList();
    });
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    final search = Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1.0,
            blurRadius: 5.0,
            offset: const Offset(0, 2), // Changes the position of the shadow
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 197, 241, 176),
              Color.fromARGB(255, 241, 247, 191),
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
            width: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: _allTeam,
                    onChanged: (value) {
                      setState(() {
                        _allTeam = value!;
                        loadPheDuyetNghi();
                      });
                    }),
                Text("Cấp cao")
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
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 228, 230, 225),
                    Color.fromARGB(255, 189, 255, 252),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: const Text(
            'Phê duyệt nghỉ',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      body: Column(
        children: [
          search,
          Expanded(
            child: RefreshIndicator(
              onRefresh: loadPheDuyetNghi,
              child: ListView.builder(
                itemCount: _listPheDuyet.length,
                itemBuilder: (context, index) {
                  final request = _listPheDuyet[index];
                  return Container(
                    margin: EdgeInsets.all(8.0),
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
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 241, 241, 241),
                            Color.fromARGB(255, 76, 142, 230),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(0.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 185,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${request.oFFID}:${request.mIDLASTNAME} ${request.fIRSTNAME}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text('Bộ phận: ${request.sUBDEPTNAME}'),
                                    Text(
                                        'Ngày đăng ký: ${GlobalFunction.MyDate('yyyy-MM-dd', request.rEQUESTDATE.toString())}'),
                                    Text(
                                        'Ngày nghỉ: ${GlobalFunction.MyDate('yyyy-MM-dd', request.aPPLYDATE.toString())}'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: 175,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Kiểu nghỉ: ${request.rEASONNAME.toString()}'),
                                    Text(
                                      'Chi tiết nghỉ: ${request.rEMARK.toString()}',
                                      overflow: TextOverflow.clip,
                                    ),
                                    Row(
                                      children: [
                                        Text('Trạng thái:'),
                                        Text(
                                            ' ${request.aPPROVALSTATUS == 1 ? 'Phê duyệt' : request.aPPROVALSTATUS == 0 ? 'Từ chối' : 'Chờ duyệt'}',
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: request.aPPROVALSTATUS == 1
                                                    ? Colors.green
                                                    : request.aPPROVALSTATUS == 0
                                                        ? Colors.red
                                                        : Colors.white,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (request.aPPROVALSTATUS == 2)
                                    ? Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              // Logic to approve leave request
                                              bool isSet = await setPheDuyetNhom(1, request.oFFID!);
                                              if(isSet)
                                              {
                                                setState(() {                                                
                                                  request.aPPROVALSTATUS = 1;                                                
                                                });
                                              }
                                              
                                              
                                            },
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size.zero,
                                                padding: const EdgeInsets.all(5.0),
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.green),
                                            child: Text(
                                              'Phê duyệt',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              // Logic to reject leave request
                                               bool isSet = await setPheDuyetNhom(0, request.oFFID!);
                                              if(isSet)
                                              {
                                                setState(() {                                                
                                                  request.aPPROVALSTATUS = 0;                                                
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size.zero,
                                                padding: const EdgeInsets.all(5.0),
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.red),
                                            child: Text(
                                              'Từ chối X',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(''),
                                ElevatedButton(
                                  onPressed: () {
                                    // Logic to cancel leave request
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: 'Cảnh báo',
                                      desc: 'Bạn muốn xóa đăng ký?',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        bool isSet = await setPheDuyetNhom(3, request.oFFID!);
                                              if(isSet)
                                              {
                                                setState(() {                                                
                                                  request.aPPROVALSTATUS = 3;                                                
                                                });
                                              }
                                      },
                                    ).show();
                                    
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(5.0),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.grey),
                                  child: Text(
                                    'Xóa Đ. Ký',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Logic to cancel leave request
                                    setState(() {                                      
                                    request.aPPROVALSTATUS =2;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(5.0),
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          Color.fromARGB(255, 226, 155, 48)),
                                  child: Text(
                                    'Reset Đ.Ký',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
