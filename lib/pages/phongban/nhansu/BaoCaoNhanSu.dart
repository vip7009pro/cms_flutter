import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DiemDanhMainDeptTable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BaoCaoNhanSu extends StatefulWidget {
  const BaoCaoNhanSu({Key? key}) : super(key: key);
  @override
  _BaoCaoNhanSuState createState() => _BaoCaoNhanSuState();
}




class _BaoCaoNhanSuState extends State<BaoCaoNhanSu> {
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  String _teamNameList = "ALL";
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  List<DiemDanhNhomDataSummary> _listDiemDanhSummary = List.empty();
  List<DIEMDANHMAINDEPT>  _listDiemDanhMainDept = List.empty();

  Future<void> loadDiemDanhNhomSummary() async {
    API_Request.api_query('diemdanhhistorynhom', {
      'start_date': _fromDateController.text,
      'end_date': _toDateController.text,
      'MAINDEPTCODE': 0,
      'WORK_SHIFT_CODE': 0,
      'FACTORY_CODE': 0,
    }).then((value) {
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
          _listDiemDanhSummary = dynamicList.map((dynamic item) {
            return DiemDanhNhomDataSummary.fromJson(item);
          }).toList();
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

  Future<void> loadDiemDanhMainDept() async {
    API_Request.api_query('getddmaindepttb', {
      'FROM_DATE': _toDateController.text,
      'TO_DATE':_toDateController.text
    }).then((value) {
      setState((() {
        if (value['tk_status'] == 'OK') {
          List<dynamic> dynamicList = value['data'];         
          _listDiemDanhMainDept = dynamicList.map((dynamic item) {
            return DIEMDANHMAINDEPT.fromJson(item);
          }).toList();
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

  @override
  void initState() {
    // TODO: implement initState

    DateTime rightnow = DateTime.now();
    fromDate = DateTime.parse('${rightnow.year}-${rightnow.month}-01');
    _fromDateController.text =
        GlobalFunction.MyDate('yyyy-MM-dd', fromDate.toString());
    _toDateController.text =
        GlobalFunction.MyDate('yyyy-MM-dd', toDate.toString());
    loadDiemDanhNhomSummary();
    loadDiemDanhMainDept();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

final searchBar = Container(
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
                      loadDiemDanhNhomSummary();
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Load'),
                ),
              ],
            ),
          ),
        );

    final bieudonhansu = Container(
      height: 400,
      child: SfCartesianChart(
        title: ChartTitle(text: 'Daily status'),
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        primaryXAxis: DateTimeAxis(
          title: AxisTitle(text: 'Date'),
          dateFormat: DateFormat("yy-MM-dd"),
        ),
        axes: [
          NumericAxis(
            title: AxisTitle(text: 'ON_QTY'),
          ),
          NumericAxis(
            title: AxisTitle(text: 'ON_RATE'),
            opposedPosition: true,
            numberFormat: NumberFormat.percentPattern(),
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          StackedColumnSeries<DiemDanhNhomDataSummary, DateTime>(
              name: 'ON',
              color: Colors.blueAccent,
              dataSource: _listDiemDanhSummary,
              xValueMapper: (DiemDanhNhomDataSummary data, _) =>
                  DateTime.parse(data.aPPLYDATE.toString()),
              yValueMapper: (DiemDanhNhomDataSummary data, _) => data.tOTALON,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              yAxisName: 'ON_QTY'),
          StackedColumnSeries<DiemDanhNhomDataSummary, DateTime>(
              name: 'OFF',
              color: Colors.redAccent,
              dataSource: _listDiemDanhSummary,
              xValueMapper: (DiemDanhNhomDataSummary data, _) =>
                  DateTime.parse(data.aPPLYDATE.toString()),
              yValueMapper: (DiemDanhNhomDataSummary data, _) => data.tOTALOFF,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              yAxisName: 'ON_QTY'),
          LineSeries<DiemDanhNhomDataSummary, DateTime>(
              name: 'ON_RATE',
              color: Colors.redAccent,
              dataSource: _listDiemDanhSummary,
              xValueMapper: (DiemDanhNhomDataSummary data, _) =>
                  DateTime.parse(data.aPPLYDATE.toString()),
              yValueMapper: (DiemDanhNhomDataSummary data, _) => data.oNRATE,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              yAxisName: 'ON_RATE'),
        ],
      ),
    );

    final bieudophongban = Container(
        width: 500,
        height: 500,
        child: SfCircularChart(
          title: ChartTitle(text: 'Tỉ trọng nhân sự'),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),          
          series: <CircularSeries>[
            // Default Pie series
            PieSeries<DIEMDANHMAINDEPT, String>(
              dataSource: _listDiemDanhMainDept,
              xValueMapper: (DIEMDANHMAINDEPT data, _) => data.mAINDEPTNAME,
              yValueMapper: (DIEMDANHMAINDEPT data, _) => data.cOUNTTOTAL,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ));

    var diemdanhmaindeptdatatable = Container(
      width: double.infinity,
      height: 400 ,
      child: DiemDanhMainDeptTable(diemdanhmaindeptdata: _listDiemDanhMainDept));

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 228, 230, 225),
                  Color.fromARGB(255, 198, 233, 133),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: const Text(
          'Báo cáo nhân sự',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            searchBar,
            Expanded(
              child: ListView(
                children: [bieudonhansu, bieudophongban, diemdanhmaindeptdatatable],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


