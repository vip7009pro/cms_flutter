import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';

class QuanLyPo extends StatefulWidget {
  const QuanLyPo({Key? key}) : super(key: key);

  @override
  _QuanLyPoState createState() => _QuanLyPoState();
}

class _QuanLyPoState extends State<QuanLyPo> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  String _gName="";
  String _gCode="";
  String _emplName="";
  String _custName="";
  String _prodType="";
  String _id="";
  String _poNo="";
  String _mainMaterial="";
  String _overDue="";
  String _invoiceNo="";
  bool _allTime = false;
  bool _justPOBalance = false;

  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  
  List<PODATA> _poDataTable = List.empty();
  Future<void> _loadPOData() async {
    await API_Request.api_query('traPODataFull', {
      'alltime': _allTime,
      'justPoBalance': _justPOBalance,
      'start_date': GlobalFunction.MyDate('yyyy-MM-dd', _fromDate.toString()),
      'end_date': GlobalFunction.MyDate('yyyy-MM-dd', _toDate.toString()),
      'cust_name': _custName,
      'codeCMS': _gCode,
      'codeKD': _gName,
      'prod_type': _prodType,
      'empl_name': _emplName,
      'po_no': _poNo,
      'over': _overDue,
      'id': _id,
      'material': _mainMaterial,
    }).then((value) {
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
        setState(() {
          _poDataTable = dynamicList.map((dynamic item) {
            return PODATA.fromJson(item);
          }).toList();
        });
      } else {}
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _fromDateController.text = GlobalFunction.MyDate('yyyy-MM-dd', _fromDate.toString());
    _toDateController.text = GlobalFunction.MyDate('yyyy-MM-dd', _toDate.toString());
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
                    Color.fromARGB(255, 211, 209, 185),
                    Color.fromARGB(255, 147, 241, 84),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: const Text(
            'Quản lý PO',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        body: Container(
          child: Text("OKOK"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 125, 231, 76),
            child: const Icon(
              Icons.search,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 500,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Search Filter'),
                          TextFormField(
                            readOnly: true,    
                            controller: _fromDateController,                        
                            decoration: const InputDecoration(labelText: 'From Date'),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _fromDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null && pickedDate != _fromDate) {
                                setState(() {
                                  _fromDate = pickedDate;   
                                  _fromDateController.text = GlobalFunction.MyDate('yyyy-MM-dd', _fromDate.toString());                               
                                });
                              }
                            },
                          ),                         
                          ElevatedButton(
                            child: const Text('Search'),
                            onPressed: () {
                              Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      }),
    );
        
  }
}
