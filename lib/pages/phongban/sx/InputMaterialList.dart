import 'dart:convert';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/MaterialInputHistoryDataModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InputMaterialList extends StatefulWidget {
  final String planID;
  const InputMaterialList({Key? key, required this.planID}) : super(key: key);
  @override
  _InputMaterialListState createState() => _InputMaterialListState();
}

class _InputMaterialListState extends State<InputMaterialList> {
  List<MaterialInputHistoryData> inputList = <MaterialInputHistoryData>[];
  late MaterialInputDataSource materialInputDataSource;
  String _token = '';
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? 'reset';
    return savedToken;
  }

  Future<void> loadP500PlanId(String planId) async {
    await API_Request.api_query('checkP500PlanID_mobile', {
      'token_string': _token,
      'PLAN_ID': planId,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dataArray = value['data'];
        List<MaterialInputHistoryData> tempInputList = [];
        for (int i = 0; i < dataArray.length; i++) {
          tempInputList.add(MaterialInputHistoryData.fromJson(dataArray[i]));
        }
        setState(() {
          inputList = tempInputList;
          materialInputDataSource =
              MaterialInputDataSource(materialInputHistoryData: inputList);
        });
      } else {}
    });
  }

  late Map<String, double> columnWidths = {
    'PLAN_ID': double.nan,
    'M_CODE': double.nan,
    'M_NAME': double.nan,
    'WIDTH_CD': double.nan,
    'M_LOT_NO': double.nan,
    'TOTAL_OUT_QTY': double.nan,
    'REMAIN_QTY': double.nan,
    'EQUIPMENT_CD': double.nan,
    'INS_DATE': double.nan,
  };

  @override
  void initState() {
    materialInputDataSource =
        MaterialInputDataSource(materialInputHistoryData: inputList);
    _getToken().then((value) {
      _token = value;
      loadP500PlanId(widget.planID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      allowSorting: true,
      selectionMode: SelectionMode.multiple,
      showCheckboxColumn: true,
      allowColumnsResizing: true,
      onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
        setState(() {
          columnWidths[details.column.columnName] = details.width;
        });
        return true;
      },
      rowHeight: 30,
      source: materialInputDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
            width: columnWidths['PLAN_ID']!,
            minimumWidth: 50,
            columnName: 'PLAN_ID',
            label: Container(
                alignment: Alignment.center,
                child: const Text(
                  'PLAN_ID',
                ))),
        GridColumn(
            width: columnWidths['M_CODE']!,
            minimumWidth: 50,
            columnName: 'M_CODE',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('M_CODE'))),
        GridColumn(
            width: columnWidths['M_NAME']!,
            minimumWidth: 50,
            columnName: 'M_NAME',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('M_NAME'))),
        GridColumn(
            width: columnWidths['WIDTH_CD']!,
            minimumWidth: 50,
            columnName: 'WIDTH_CD',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('WIDTH_CD'))),
        GridColumn(
            width: columnWidths['M_LOT_NO']!,
            minimumWidth: 50,
            columnName: 'M_LOT_NO',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  'M_LOT_NO',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            width: columnWidths['TOTAL_OUT_QTY']!,
            minimumWidth: 50,
            columnName: 'TOTAL_OUT_QTY',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('TOTAL_OUT_QTY'))),
        GridColumn(
            width: columnWidths['REMAIN_QTY']!,
            minimumWidth: 50,
            columnName: 'REMAIN_QTY',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('REMAIN_QTY'))),
        GridColumn(
            width: columnWidths['EQUIPMENT_CD']!,
            minimumWidth: 50,
            columnName: 'EQUIPMENT_CD',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('EQUIPMENT_CD'))),
        GridColumn(
            width: columnWidths['INS_DATE']!,
            minimumWidth: 50,
            columnName: 'INS_DATE',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('INS_DATE'))),
      ],
    );
  }
}

List<DataGridRow> _materialInputHistoryData = [];

class MaterialInputDataSource extends DataGridSource {
  MaterialInputDataSource(
      {required List<MaterialInputHistoryData> materialInputHistoryData}) {
    _materialInputHistoryData = materialInputHistoryData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'PLAN_ID', value: e.planId),
              DataGridCell<String>(columnName: 'M_CODE', value: e.mCode),
              DataGridCell<String>(columnName: 'M_NAME', value: e.mName),
              DataGridCell<int>(columnName: 'WIDTH_CD', value: e.widthCd),
              DataGridCell<String>(columnName: 'M_LOT_NO', value: e.mLotNo),
              DataGridCell<int>(
                  columnName: 'TOTAL_OUT_QTY', value: e.totalOutQty),
              DataGridCell<int>(columnName: 'REMAIN_QTY', value: e.remainQty),
              DataGridCell<String>(
                  columnName: 'EQUIPMENT_CD', value: e.equipmentCd),
              DataGridCell<String>(columnName: 'INS_DATE', value: e.insDate),
            ]))
        .toList();
  }
  @override
  List<DataGridRow> get rows => _materialInputHistoryData;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(1.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
