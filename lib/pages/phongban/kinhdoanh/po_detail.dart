import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
class PoDetail extends StatefulWidget {
  final PODATA currentPO;
  const PoDetail({Key? key, required this.currentPO}) : super(key: key);
  @override
  _PoDetailState createState() => _PoDetailState();
}
class _PoDetailState extends State<PoDetail> {
  late PODATA _thisPO;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _poG_NAME_SEARCH = TextEditingController();
  final TextEditingController _poCUST_NAME_SEARCH = TextEditingController();
  final TextEditingController _poG_NAME = TextEditingController();
  final TextEditingController _poG_CODE = TextEditingController();
  final TextEditingController _poCUST_NAME_KD = TextEditingController();
  final TextEditingController _poCUST_CD = TextEditingController();
  final TextEditingController _poPO_NO = TextEditingController();
  final TextEditingController _poPO_QTY = TextEditingController();
  final TextEditingController _poEMPL_NO = TextEditingController();
  final TextEditingController _poPO_DATE = TextEditingController();
  final TextEditingController _poRD_DATE = TextEditingController();
  final TextEditingController _poPROD_PRICE = TextEditingController();
  final TextEditingController _poBEP = TextEditingController();
  final TextEditingController _poREMARK = TextEditingController();
  List<CustomerListData> _customerList = List.empty();
  List<CustomerListData> _filteredCustomerList = List.empty();
  List<CodeListData> _codeList = List.empty();
  void searchCustomer(String filter) {
    setState(() {
      _filteredCustomerList = _customerList
          .where((ele) =>
              ele.cUSTNAMEKD!.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }
  Future<void> _loadCustomerList() async {
    await API_Request.api_query('selectcustomerList', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        setState(() {
          _customerList = dynamicList.map((dynamic item) {
            return CustomerListData.fromJson(item);
          }).toList();
          _filteredCustomerList = _customerList;         
        });
      } else {}
    });
  }
  Future<void> _loadCodeList(String filter) async {
    await API_Request.api_query('selectcodeList', {'G_NAME': filter})
        .then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        setState(() {
          _codeList = dynamicList.map((dynamic item) {
            return CodeListData.fromJson(item);
          }).toList();
        });
      } else {}
    });
  }
  Future<void> _updatePO () async {
    
  }

  Future<List<CodeListData>> getData(String filter) async {
    List<CodeListData> filteredList =
        _codeList.where((ele) => ele.gNAME!.contains(filter)).toList();
    return filteredList;
  }

  void _khoiTao() {
    _poG_NAME_SEARCH.text = '';
    _poCUST_NAME_SEARCH.text = '';
    _poG_NAME.text = widget.currentPO.gNAME!;
    _poCUST_NAME_KD.text = widget.currentPO.cUSTNAMEKD!;
    _poG_CODE.text = widget.currentPO.gCODE!;
    _poCUST_CD.text = widget.currentPO.cUSTCD!;
    _poPO_NO.text = widget.currentPO.pONO!;
    _poPO_QTY.text = widget.currentPO.pOQTY.toString();
    _poPROD_PRICE.text = widget.currentPO.pRODPRICE.toString();
    _poBEP.text = widget.currentPO.bEP.toString();
    _poEMPL_NO.text = widget.currentPO.eMPLNO!;
    _poREMARK.text = widget.currentPO.rEMARK!;
    _poPO_DATE.text =
        GlobalFunction.MyDate('yyyy-MM-dd', widget.currentPO.pODATE!);
    _poRD_DATE.text =
        GlobalFunction.MyDate('yyyy-MM-dd', widget.currentPO.rDDATE!);
    _loadCustomerList();
    _loadCodeList('');
  }
  Widget _customPopupItemBuilderExample2(
      BuildContext context, CodeListData item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.gNAME!),
        subtitle: Text(item.gCODE.toString()),
      ),
    );
  }
  @override
  void initState() {
    _thisPO = widget.currentPO;
    _khoiTao();
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
          'Chi tiết PO',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Flex(direction: Axis.vertical, children: [
          Flexible(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'SEARCH CODE',
                            filled: true,
                            fillColor: Color.fromARGB(255, 216, 237, 240)),
                        controller: _poG_NAME_SEARCH,
                        onChanged: (value) {
                          _loadCodeList(value);
                        },
                      ),
                      DropdownSearch<CodeListData>(
                        asyncItems: (filter) => getData(filter),
                        items: _codeList,
                        itemAsString: (CodeListData u) =>
                            u.gCODE! + '_' + u.gNAME!,
                        onChanged: (CodeListData? data) {
                          setState(() {
                            _poG_CODE.text = data?.gCODE ?? '';
                            _poG_NAME.text = data?.gNAME ?? '';
                            _poPROD_PRICE.text =
                                (data?.pRODLASTPRICE ?? 0).toString();
                          });
                        },
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              labelText: "G_CODE",
                              filled: true,
                              fillColor: Color.fromARGB(255, 216, 237, 240)),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'G_CODE',
                            filled: true,
                            fillColor: Color.fromARGB(255, 231, 230, 228)),
                        controller: _poG_CODE,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'G_NAME',
                            filled: true,
                            fillColor: Color.fromARGB(255, 231, 230, 228)),
                        controller: _poG_NAME,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'SEARCH CUSTOMER',
                            filled: true,
                            fillColor: Color.fromARGB(255, 216, 237, 240)),
                        controller: _poCUST_NAME_SEARCH,
                        onChanged: (value) {
                          searchCustomer(value);
                        },
                      ),
                      DropdownSearch<CustomerListData>(
                        items: _filteredCustomerList,
                        itemAsString: (CustomerListData u) =>
                            u.cUSTCD! + '_' + u.cUSTNAMEKD!,
                        onChanged: (CustomerListData? data) {
                          setState(() {
                            _poCUST_CD.text = data?.cUSTCD ?? '';
                            _poCUST_NAME_KD.text = data?.cUSTNAMEKD ?? '';
                          });
                        },
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              labelText: "CUST_CD",
                              filled: true,
                              fillColor: Color.fromARGB(255, 216, 237, 240)),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'CUST_CD',
                            filled: true,
                            fillColor: Color.fromARGB(255, 231, 230, 228)),
                        controller: _poCUST_CD,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'CUST_NAME_KD',
                            filled: true,
                            fillColor: Color.fromARGB(255, 231, 230, 228)),
                        controller: _poCUST_NAME_KD,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'PO_NO',
                            filled: true,
                            fillColor: Color.fromARGB(255, 231, 230, 228)),
                        controller: _poPO_NO,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'PO_QTY'),
                        controller: _poPO_QTY,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'PROD_PRICE'),
                        controller: _poPROD_PRICE,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'BEP'),
                        controller: _poBEP,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'EMPL_NO',
                            filled: true,
                            fillColor: Color.fromARGB(255, 231, 230, 228)),
                        controller: _poEMPL_NO,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _poPO_DATE,
                        decoration: const InputDecoration(labelText: 'PO_DATE'),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(
                                widget.currentPO.pODATE ?? "1900-01-01"),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null &&
                              pickedDate !=
                                  DateTime.parse(widget.currentPO.pODATE ??
                                      "1900-01-01")) {
                            setState(() {
                              _poPO_DATE.text = GlobalFunction.MyDate(
                                  'yyyy-MM-dd', pickedDate.toString());
                            });
                          }
                        },
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _poRD_DATE,
                        decoration: const InputDecoration(labelText: 'RD_DATE'),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(
                                widget.currentPO.rDDATE ?? "1900-01-01"),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null &&
                              pickedDate !=
                                  DateTime.parse(widget.currentPO.rDDATE ??
                                      "1900-01-01")) {
                            setState(() {
                              _poRD_DATE.text = GlobalFunction.MyDate(
                                  'yyyy-MM-dd', pickedDate.toString());
                            });
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'REMARK'),
                        controller: _poREMARK,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Cảnh báo',
                    desc: 'Bạn muốn update thông tin nhân viên?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                },
                child: const Text('Update'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Cảnh báo',
                    desc: 'Bạn muốn add nhân viên?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                },
                child: const Text('Add New'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
