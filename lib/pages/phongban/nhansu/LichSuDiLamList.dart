// ignore: file_names
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/// The home page of the application which hosts the datagrid.
class LichSuDiLamTable extends StatefulWidget {
  /// Creates the home page.
  // ignore: prefer_const_constructors_in_immutables
  LichSuDiLamTable({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LichSuDiLamtableState createState() => _LichSuDiLamtableState();
}
class _LichSuDiLamtableState extends State<LichSuDiLamTable> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 228, 230, 225),
                    Color.fromARGB(255, 231, 188, 132),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: const Text(
            'Lịch sử đi làm',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        body: MyDiemDanhList());
  }
}
class MyDiemDanhList extends StatefulWidget {
  const MyDiemDanhList({Key? key}) : super(key: key);
  @override
  _MyDiemDanhListState createState() => _MyDiemDanhListState();
}
class _MyDiemDanhListState extends State<MyDiemDanhList> {
  List<MyDiemDanhData> _listDiemDanh = List.empty(),
      _orgListDiemDanh = List.empty();
  List<WorkPositionTableData> _workPositionTable = List.empty();
  TextEditingController _filterController = TextEditingController();
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String _searchString = "";
  String _teamNameList = "ALL";
  bool _allTeam = false;
  Future<void> loadDiemDanhNhom(String from_date, String to_date) async {
    API_Request.api_query(
            'mydiemdanhnhom', {'from_date': from_date, 'to_date': to_date})
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
          _listDiemDanh = dynamicList.map((dynamic item) {
            return MyDiemDanhData.fromJson(item);
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
  final TextEditingController colorController = TextEditingController();
  @override
  void initState() {
    DateTime rightnow = DateTime.now();
    fromDate = DateTime.parse('${rightnow.year}-${rightnow.month.toString().padLeft(2,"0")}-01');
    _fromDateController.text =
        GlobalFunction.MyDate('yyyy-MM-dd', fromDate.toString());
    _toDateController.text =
        GlobalFunction.MyDate('yyyy-MM-dd', toDate.toString());
    loadDiemDanhNhom(_fromDateController.text, _toDateController.text);
    _filterController.addListener(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 133, 204, 252),
                ],
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 60,
                  child: TextFormField(
                    readOnly: true,
                    controller: _fromDateController,
                    decoration: InputDecoration(labelText: 'From Date'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: fromDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != fromDate)
                        setState(() {
                          fromDate = pickedDate;
                          _fromDateController.text = GlobalFunction.MyDate(
                              'yyyy-MM-dd', fromDate.toString());
                        });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 60,
                  child: TextFormField(
                    readOnly: true,
                    controller: _toDateController,
                    decoration: InputDecoration(labelText: 'To Date'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: toDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != toDate)
                        setState(() {
                          toDate = pickedDate;
                          _toDateController.text = GlobalFunction.MyDate(
                              'yyyy-MM-dd', toDate.toString());
                        });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loadDiemDanhNhom(
                          _fromDateController.text, _toDateController.text);
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Load'),
                ),
              ],
            ),
          ),
        ),
        Flexible(
            child: RefreshIndicator(
                onRefresh: () async {
                  loadDiemDanhNhom(
                      _fromDateController.text, _toDateController.text);
                },
                child: ListView.builder(
                  itemBuilder: ((BuildContext context, int index) {
                    final rowData = _listDiemDanh[index];
                    final avatar = CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'http://14.160.33.94/Picture_NS/NS_${rowData.eMPLNO}.jpg'),
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
                            offset: const Offset(
                                0, 3), // Changes the position of the shadow
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 155, 252, 255),
                              Color.fromARGB(255, 245, 235, 248),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "${index + 1}.${GlobalFunction.MyDate('yyyy-MM-dd', rowData.dATECOLUMN.toString())}",
                              style: TextStyle(
                                  color: rowData.cHECK2 == null
                                      ? Colors.red
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: rowData.cHECK1 != null
                                ? Text(
                                    "${GlobalFunction.MyDate('HH:mm:ss', rowData.cHECK1.toString())}",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 32, 211),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  )
                                : Text('-',
                                    style: TextStyle(color: Colors.grey)),
                          ),
                          SizedBox(
                            width: 80,
                            child: rowData.cHECK2 != null
                                ? Text(
                                    "${GlobalFunction.MyDate('HH:mm:ss', rowData.cHECK2.toString())}",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 32, 211),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  )
                                : Text('-',
                                    style: TextStyle(color: Colors.grey)),
                          ),
                          SizedBox(
                            width: 80,
                            child: rowData.cHECK3 != null
                                ? Text(
                                    "${GlobalFunction.MyDate('HH:mm:ss', rowData.cHECK3.toString())}",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  )
                                : Text('-',
                                    style: TextStyle(color: Colors.grey)),
                          ),
                          rowData.cHECK2 != null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(Icons.cancel, color: Colors.red)
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
