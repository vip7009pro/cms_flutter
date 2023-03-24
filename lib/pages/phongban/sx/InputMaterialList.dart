import 'package:cms_flutter/model/MaterialInputHistoryDataModel.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    inputList = [
      MaterialInputHistoryData(
          planId: 'A123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'B123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'C123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'D123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'E123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'F123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'G123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'H123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'I123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'J123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'K123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'L123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'M123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'N123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
      MaterialInputHistoryData(
          planId: 'O123456',
          mCode: 'ABC123',
          mLotNo: '123456789',
          totalOutQty: 100,
          remainQty: 50,
          equipmentCd: 'FR01',
          insDate: '2023-04-23 15:20:21'),
    ];
    materialInputDataSource =
        MaterialInputDataSource(materialInputHistoryData: inputList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        SfDataGrid(
          allowSorting: true,
          allowColumnsResizing: true,
          allowFiltering: true,
          allowEditing: true,
          allowMultiColumnSorting: true,
          columnResizeMode: ColumnResizeMode.onResize,
          allowPullToRefresh: true,
          rowHeight: 25,
          source: materialInputDataSource,
          columnWidthMode: ColumnWidthMode.fill,
          columns: <GridColumn>[
            GridColumn(
                allowFiltering: true,
                allowSorting: true,
                minimumWidth: 100,
                columnName: 'PLAN_ID',
                label: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'PLAN_ID',
                    ))),
            GridColumn(
                minimumWidth: 100,
                columnName: 'M_CODE',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('M_CODE'))),
            GridColumn(
                minimumWidth: 100,
                columnName: 'M_LOT_NO',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'M_LOT_NO',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                minimumWidth: 100,
                columnName: 'TOTAL_OUT_QTY',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('TOTAL_OUT_QTY'))),
            GridColumn(
                minimumWidth: 100,
                columnName: 'REMAIN_QTY',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('REMAIN_QTY'))),
            GridColumn(
                minimumWidth: 100,
                columnName: 'EQUIPMENT_CD',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('EQUIPMENT_CD'))),
            GridColumn(
                minimumWidth: 100,
                columnName: 'INS_DATE',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('INS_DATE'))),
          ],
        )
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
