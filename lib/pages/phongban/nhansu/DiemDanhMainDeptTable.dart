// ignore_for_file: library_private_types_in_public_api
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/model/MaterialInputHistoryDataModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
class DiemDanhMainDeptTable extends StatefulWidget {
  final List<DIEMDANHMAINDEPT> diemdanhmaindeptdata;
  const DiemDanhMainDeptTable({Key? key, required this.diemdanhmaindeptdata})
      : super(key: key);
  @override
  _DiemDanhMainDeptTableState createState() => _DiemDanhMainDeptTableState();
}
class _DiemDanhMainDeptTableState extends State<DiemDanhMainDeptTable> {
  late DiemDanhMainDeptDataSource _diemDanhMainDeptDataSource;
  late Map<String, double> columnWidths = {
    'MAINDEPTNAME': double.nan,
    'COUNT_TOTAL': double.nan,
    'COUT_ON': double.nan,
    'COUT_OFF': double.nan,
    'COUNT_CDD': double.nan,
    'ON_RATE': double.nan,
  };
  @override
  void initState() {
    _diemDanhMainDeptDataSource = DiemDanhMainDeptDataSource(
        diemdanhmaindeptdata: widget.diemdanhmaindeptdata);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      allowColumnsResizing: true,
      onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
        setState(() {
          columnWidths[details.column.columnName] = details.width;
        });
        return true;
      },
      rowHeight: 30,
      source: _diemDanhMainDeptDataSource,
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      columns: <GridColumn>[
        GridColumn(
            minimumWidth: 50,
            columnName: 'MAINDEPTNAME',
            label: Container(
                alignment: Alignment.center,
                child: const Text(
                  'DEPTNAME',
                  style: TextStyle(fontSize: 12),
                ))),
        GridColumn(
            minimumWidth: 50,
            columnName: 'COUNT_TOTAL',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('TOTAL', style: TextStyle(fontSize: 12)))),
        GridColumn(
            minimumWidth: 50,
            columnName: 'COUT_ON',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('COUT_ON', style: TextStyle(fontSize: 12)))),
        GridColumn(
            minimumWidth: 50,
            columnName: 'COUT_OFF',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('COUT_OFF', style: TextStyle(fontSize: 12)))),
        GridColumn(
            minimumWidth: 50,
            columnName: 'COUNT_CDD',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('COUNT_CDD',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12)))),
        GridColumn(
            minimumWidth: 50,
            columnName: 'ON_RATE',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('ON_RATE',
                    style: TextStyle(
                      fontSize: 12,
                    )))),
      ],
    );
  }
}
List<DataGridRow> _dataGridRow = [];
class DiemDanhMainDeptDataSource extends DataGridSource {
  DiemDanhMainDeptDataSource(
      {required List<DIEMDANHMAINDEPT> diemdanhmaindeptdata}) {
    _dataGridRow = diemdanhmaindeptdata
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'MAINDEPTNAME', value: e.mAINDEPTNAME),
              DataGridCell<int>(columnName: 'COUNT_TOTAL', value: e.cOUNTTOTAL),
              DataGridCell<int>(columnName: 'COUT_ON', value: e.cOUTON),
              DataGridCell<int>(columnName: 'COUT_OFF', value: e.cOUTOFF),
              DataGridCell<int>(columnName: 'COUNT_CDD', value: e.cOUNTCDD),
              DataGridCell<String>(
                  columnName: 'ON_RATE',
                  value: NumberFormat.percentPattern()
                      .format((e.oNRATE ?? 100) / 100)),
            ]))
        .toList();
  }
  @override
  List<DataGridRow> get rows => _dataGridRow;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(1.0),
        child: Text(e.value.toString(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      );
    }).toList());
  }
}
