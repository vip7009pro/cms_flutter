import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:dropdown_search/dropdown_search.dart';
class EmployeeInfoScreen extends StatefulWidget {
  final EmployeeData userData;
  const EmployeeInfoScreen({Key? key, required this.userData})
      : super(key: key);
  @override
  _EmployeeInfoScreenState createState() => _EmployeeInfoScreenState();
}
class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  List<WORKPOSITIONDATA> listWorkPosition_org = List.empty();
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _user_EMPL_NO_ctrl = TextEditingController();
  final TextEditingController _user_CMS_ID_ctrl = TextEditingController();
  final TextEditingController _user_NV_CCID_ctrl = TextEditingController();
  final TextEditingController _user_FIRST_NAME_ctrl = TextEditingController();
  final TextEditingController _user_MIDLAST_NAME_ctrl = TextEditingController();
  final TextEditingController _user_DOB_ctrl = TextEditingController();
  final TextEditingController _user_HOMETOWN_ctrl = TextEditingController();
  final TextEditingController _user_SEX_CODE_ctrl = TextEditingController();
  final TextEditingController _user_ADD_PROVINCE_ctrl = TextEditingController();
  final TextEditingController _user_ADD_DISTRICT_ctrl = TextEditingController();
  final TextEditingController _user_ADD_COMMUNE_ctrl = TextEditingController();
  final TextEditingController _user_ADD_VILLAGE_ctrl = TextEditingController();
  final TextEditingController _user_PHONE_NUMBER_ctrl = TextEditingController();
  final TextEditingController _user_WORK_START_DATE_ctrl =
      TextEditingController();
  final TextEditingController _user_WORK_END_DATE_ctrl =
      TextEditingController();
  final TextEditingController _user_PASSWORD_ctrl = TextEditingController();
  final TextEditingController _user_EMAIL_ctrl = TextEditingController();
  final TextEditingController _user_WORK_POSITION_CODE_ctrl =
      TextEditingController();
  final TextEditingController _user_WORK_SHIFT_CODE_ctrl =
      TextEditingController();
  final TextEditingController _user_POSITION_CODE_ctrl =
      TextEditingController();
  final TextEditingController _user_JOB_CODE_ctrl = TextEditingController();
  final TextEditingController _user_FACTORY_CODE_ctrl = TextEditingController();
  final TextEditingController _user_WORK_STATUS_CODE_ctrl =
      TextEditingController();
  String userWorkPositionName = "Rau má";
  List<String> listPosition = ['Manager', 'AM', 'Senior', 'Staff', 'NoPos'];
  List<String> listWorkStatus = ['Đã nghỉ', 'Đang làm', 'Nghỉ sinh'];
  Future<void> _loadWorkPosition() async {
    await API_Request.api_query('workpositionlist', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        setState(() {
          listWorkPosition_org = dynamicList.map((dynamic item) {
            return WORKPOSITIONDATA.fromJson(item);
          }).toList();
          init();
        });
      } else {}
    });
  }
  Future<void> _updateEmployeeInfo() async {
    await API_Request.api_query('updateemployee', {
      'NV_CCID': _user_NV_CCID_ctrl.text,
      'EMPL_NO': _user_EMPL_NO_ctrl.text,
      'CMS_ID': _user_CMS_ID_ctrl.text,
      'FIRST_NAME': _user_FIRST_NAME_ctrl.text,
      'MIDLAST_NAME': _user_MIDLAST_NAME_ctrl.text,
      'DOB': _user_DOB_ctrl.text,
      'HOMETOWN': _user_HOMETOWN_ctrl.text,
      'SEX_CODE': _user_SEX_CODE_ctrl.text,
      'ADD_PROVINCE': _user_ADD_PROVINCE_ctrl.text,
      'ADD_DISTRICT': _user_ADD_DISTRICT_ctrl.text,
      'ADD_COMMUNE': _user_ADD_COMMUNE_ctrl.text,
      'ADD_VILLAGE': _user_ADD_VILLAGE_ctrl.text,
      'PHONE_NUMBER': _user_PHONE_NUMBER_ctrl.text,
      'WORK_START_DATE': _user_WORK_START_DATE_ctrl.text,
      'PASSWORD': _user_PASSWORD_ctrl.text,
      'EMAIL': _user_EMAIL_ctrl.text,
      'WORK_POSITION_CODE': _user_WORK_POSITION_CODE_ctrl.text,
      'WORK_SHIFT_CODE': _user_WORK_SHIFT_CODE_ctrl.text,
      'POSITION_CODE': _user_POSITION_CODE_ctrl.text,
      'JOB_CODE': _user_JOB_CODE_ctrl.text,
      'FACTORY_CODE': _user_FACTORY_CODE_ctrl.text,
      'WORK_STATUS_CODE': _user_WORK_STATUS_CODE_ctrl.text,
      'RESIGN_DATE': _user_WORK_END_DATE_ctrl.text,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update thông tin nhân viên thành công',
          btnOkOnPress: () {},
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Update thông tin nhân viên thất bại',
          btnOkOnPress: () {},
        ).show();
      }
    });
  }
  Future<void> _addEmployeeInfo() async {
    await API_Request.api_query('insertemployee', {
      'NV_CCID': _user_NV_CCID_ctrl.text,
      'EMPL_NO': _user_EMPL_NO_ctrl.text,
      'CMS_ID': _user_CMS_ID_ctrl.text,
      'FIRST_NAME': _user_FIRST_NAME_ctrl.text,
      'MIDLAST_NAME': _user_MIDLAST_NAME_ctrl.text,
      'DOB': _user_DOB_ctrl.text,
      'HOMETOWN': _user_HOMETOWN_ctrl.text,
      'SEX_CODE': _user_SEX_CODE_ctrl.text,
      'ADD_PROVINCE': _user_ADD_PROVINCE_ctrl.text,
      'ADD_DISTRICT': _user_ADD_DISTRICT_ctrl.text,
      'ADD_COMMUNE': _user_ADD_COMMUNE_ctrl.text,
      'ADD_VILLAGE': _user_ADD_VILLAGE_ctrl.text,
      'PHONE_NUMBER': _user_PHONE_NUMBER_ctrl.text,
      'WORK_START_DATE': _user_WORK_START_DATE_ctrl.text,
      'PASSWORD': _user_PASSWORD_ctrl.text,
      'EMAIL': _user_EMAIL_ctrl.text,
      'WORK_POSITION_CODE': _user_WORK_POSITION_CODE_ctrl.text,
      'WORK_SHIFT_CODE': _user_WORK_SHIFT_CODE_ctrl.text,
      'POSITION_CODE': _user_POSITION_CODE_ctrl.text,
      'JOB_CODE': _user_JOB_CODE_ctrl.text,
      'FACTORY_CODE': _user_FACTORY_CODE_ctrl.text,
      'WORK_STATUS_CODE': _user_WORK_STATUS_CODE_ctrl.text,
      'RESIGN_DATE': _user_WORK_END_DATE_ctrl.text,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm nhân viên thành công',
          btnOkOnPress: () {},
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Thêm nhân viên thất bại',
          btnOkOnPress: () {},
        ).show();
      }
    });
  }
  void init() {
    _user_DOB_ctrl.text =
        GlobalFunction.MyDate('yyyy-MM-dd', widget.userData.dOB.toString());
    _user_WORK_START_DATE_ctrl.text = GlobalFunction.MyDate('yyyy-MM-dd',
        (widget.userData.wORKSTARTDATE ?? "1900-01-01").toString());
    _user_WORK_END_DATE_ctrl.text = GlobalFunction.MyDate(
        'yyyy-MM-dd', (widget.userData.rESIGNDATE ?? "1900-01-01").toString());
    _user_SEX_CODE_ctrl.text = widget.userData.sEXCODE.toString();
    _user_FACTORY_CODE_ctrl.text = widget.userData.fACTORYCODE.toString();
    _user_WORK_POSITION_CODE_ctrl.text =
        widget.userData.wORKPOSITIONCODE.toString();
    _user_EMPL_NO_ctrl.text = widget.userData.eMPLNO.toString();
    _user_CMS_ID_ctrl.text = widget.userData.cMSID.toString();
    _user_NV_CCID_ctrl.text = widget.userData.nVCCID.toString();
    _user_FIRST_NAME_ctrl.text = widget.userData.fIRSTNAME.toString();
    _user_MIDLAST_NAME_ctrl.text = widget.userData.mIDLASTNAME.toString();
    _user_HOMETOWN_ctrl.text = widget.userData.hOMETOWN.toString();
    _user_ADD_PROVINCE_ctrl.text = widget.userData.aDDPROVINCE.toString();
    _user_ADD_DISTRICT_ctrl.text = widget.userData.aDDDISTRICT.toString();
    _user_ADD_COMMUNE_ctrl.text = widget.userData.aDDCOMMUNE.toString();
    _user_ADD_VILLAGE_ctrl.text = widget.userData.aDDVILLAGE.toString();
    _user_PHONE_NUMBER_ctrl.text = widget.userData.pHONENUMBER.toString();
    _user_PASSWORD_ctrl.text = widget.userData.pASSWORD.toString();
    _user_EMAIL_ctrl.text = widget.userData.eMAIL.toString();
    _user_WORK_SHIFT_CODE_ctrl.text = widget.userData.wORKSHIFTCODE.toString();
    _user_POSITION_CODE_ctrl.text = widget.userData.pOSITIONCODE.toString();
    _user_JOB_CODE_ctrl.text = widget.userData.jOBCODE.toString();
    _user_WORK_STATUS_CODE_ctrl.text =
        widget.userData.wORKSTATUSCODE.toString();
    List<WORKPOSITIONDATA> tempWorkPositionList = listWorkPosition_org
        .where((e) =>
            e.wORKPOSITIONCODE.toString() ==
            widget.userData.wORKPOSITIONCODE.toString())
        .toList();
    userWorkPositionName = (tempWorkPositionList.isNotEmpty
        ? tempWorkPositionList[0].wORKPOSITIONNAME
        : "Đậu xanh")!;
  }
  @override
  void initState() {
    // TODO: implement initState
    _loadWorkPosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: 150,
      height: 390,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(0, 3), // Offset in the x, y direction
            )
          ],
          image: DecorationImage(
              image: NetworkImage(
                  'http://14.160.33.94/Picture_NS/NS_${widget.userData.eMPLNO}.jpg'),
              fit: BoxFit.cover)),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Row(
              children: [
                Icon(Icons.person),
                Text(
                  "Thông tin nhân viên",
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 133, 196, 248),
                      Color.fromARGB(0, 0, 140, 255),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            )),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    avatar,
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'ERP ID',
                            ),
                            controller: _user_EMPL_NO_ctrl,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'CMS ID'),
                            controller: _user_CMS_ID_ctrl,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Mã chấm công'),
                            controller: _user_NV_CCID_ctrl,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Tên'),
                            controller: _user_FIRST_NAME_ctrl,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Họ và đệm'),
                            controller: _user_MIDLAST_NAME_ctrl,
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _user_DOB_ctrl,
                            decoration: const InputDecoration(
                                labelText: 'Ngày tháng năm sinh'),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(
                                    widget.userData.dOB ?? "1900-01-01"),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null &&
                                  pickedDate !=
                                      DateTime.parse(
                                          widget.userData.dOB ?? "1900-01-01")) {
                                setState(() {
                                  _user_DOB_ctrl.text = GlobalFunction.MyDate(
                                      'yyyy-MM-dd', pickedDate.toString());
                                });
                              }
                            },
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _user_WORK_START_DATE_ctrl,
                            decoration:
                                const InputDecoration(labelText: 'Ngày vào cty'),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(
                                    widget.userData.wORKSTARTDATE ??
                                        "1900-01-01"),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null &&
                                  pickedDate !=
                                      DateTime.parse(
                                          widget.userData.wORKSTARTDATE ??
                                              "1900-01-01")) {
                                setState(() {
                                  _user_WORK_START_DATE_ctrl.text =
                                      GlobalFunction.MyDate(
                                          'yyyy-MM-dd', pickedDate.toString());
                                });
                              }
                            },
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _user_WORK_END_DATE_ctrl,
                            decoration:
                                const InputDecoration(labelText: 'Ngày nghỉ'),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(
                                    widget.userData.rESIGNDATE ?? "1900-01-01"),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null &&
                                  pickedDate !=
                                      DateTime.parse(widget.userData.rESIGNDATE ??
                                          "1900-01-01")) {
                                setState(() {
                                  _user_WORK_END_DATE_ctrl.text =
                                      GlobalFunction.MyDate(
                                          'yyyy-MM-dd', pickedDate.toString());
                                });
                              }
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Quê quán'),
                            controller: _user_HOMETOWN_ctrl,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Tỉnh/thành phố'),
                            controller: _user_ADD_PROVINCE_ctrl,
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: listWorkPosition_org
                                .map((e) => e.wORKPOSITIONNAME ?? "")
                                .toList(),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Vị trí làm việc",
                                hintText: "Chọn vị trí",
                              ),
                            ),
                            onChanged: (value) {
                              List<WORKPOSITIONDATA> tempWorkPositionList =
                                  listWorkPosition_org
                                      .where((e) => e.wORKPOSITIONNAME == value)
                                      .toList();
                              _user_WORK_POSITION_CODE_ctrl.text =
                                  (tempWorkPositionList.isNotEmpty
                                      ? tempWorkPositionList[0]
                                          .wORKPOSITIONCODE
                                          .toString()
                                      : "Đậu xanh");
                            },
                            selectedItem: userWorkPositionName,
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: const ['NM1', 'NM2'],
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Nhà máy",
                                hintText: "Chọn nhà máy",
                              ),
                            ),
                            onChanged: (value) {
                              _user_FACTORY_CODE_ctrl.text =
                                  value == 'NM1' ? '1' : '2';
                            },
                            selectedItem: _user_FACTORY_CODE_ctrl.text == '1'
                                ? 'NM1'
                                : 'NM2',
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: const ['TEAM 1', 'TEAM 2', 'Hành Chính'],
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Team",
                                hintText: "Chọn Team",
                              ),
                            ),
                            onChanged: (value) {
                              _user_WORK_SHIFT_CODE_ctrl.text = value == 'TEAM 1'
                                  ? '1'
                                  : value == 'TEAM 2'
                                      ? '2'
                                      : '0';
                            },
                            selectedItem: _user_WORK_SHIFT_CODE_ctrl.text == '1'
                                ? 'TEAM 1'
                                : _user_WORK_SHIFT_CODE_ctrl.text == '2'
                                    ? 'TEAM 2'
                                    : 'Hành Chính',
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: listPosition,
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Position",
                                hintText: "Chọn Position",
                              ),
                            ),
                            onChanged: (value) {
                              _user_POSITION_CODE_ctrl.text =
                                  listPosition.indexOf(value ?? '').toString();
                            },
                            selectedItem: listPosition[int.parse(
                                _user_POSITION_CODE_ctrl.text != ''
                                    ? _user_POSITION_CODE_ctrl.text
                                    : '0')],
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Quận huyện'),
                            controller: _user_ADD_DISTRICT_ctrl,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Xã/Thị trấn'),
                            controller: _user_ADD_COMMUNE_ctrl,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Thôn/xóm'),
                            controller: _user_ADD_VILLAGE_ctrl,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Số ĐT'),
                            controller: _user_PHONE_NUMBER_ctrl,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'PASSWORD'),
                            controller: _user_PASSWORD_ctrl,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'EMAIL'),
                            controller: _user_EMAIL_ctrl,
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: listWorkStatus,
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Trạng thái làm việc",
                                hintText: "Chọn trạng thái làm việc",
                              ),
                            ),
                            onChanged: (value) {
                              _user_WORK_STATUS_CODE_ctrl.text =
                                  listWorkStatus.indexOf(value ?? '').toString();
                            },
                            selectedItem: listWorkStatus[int.parse(
                                _user_WORK_STATUS_CODE_ctrl.text != ''
                                    ? _user_WORK_STATUS_CODE_ctrl.text
                                    : '0')],
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
                                    btnOkOnPress: () {
                                      _updateEmployeeInfo();
                                    },
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
                                    btnOkOnPress: () {
                                      _addEmployeeInfo();
                                    },
                                  ).show();
                                  
                                },
                                child: const Text('Add New'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
