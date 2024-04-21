import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';

class EmployeeInfoScreen extends StatefulWidget {
  final EmployeeData userData;
  const EmployeeInfoScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  _EmployeeInfoScreenState createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  DropListModel listSEX = DropListModel([
    OptionItem(id: "0", title: "NỮ"),
    OptionItem(id: "1", title: "NAM"),
  ]);
  DropListModel listFACTORY = DropListModel([
    OptionItem(id: "1", title: "NM1"),
    OptionItem(id: "2", title: "NM2"),
  ]);
  DropListModel listWorkPosition = DropListModel([]);
  List<WORKPOSITIONDATA> listWorkPosition_org = List.empty();
  OptionItem selectedSexOption = OptionItem(id: "0", title: "NỮ");
  OptionItem selectedFactoryOption = OptionItem(id: "1", title: "NM1");
  OptionItem selectedWorkPositionOption = OptionItem(id: "1", title: "Chọn vị trí làm việc");
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
  final TextEditingController _user_WORK_START_DATE_ctrl =TextEditingController();
  final TextEditingController _user_WORK_END_DATE_ctrl =TextEditingController();
  final TextEditingController _user_PASSWORD_ctrl = TextEditingController();
  final TextEditingController _user_EMAIL_ctrl = TextEditingController();
  final TextEditingController _user_WORK_POSITION_CODE_ctrl =TextEditingController();
  final TextEditingController _user_WORK_SHIFT_CODE_ctrl =TextEditingController();
  final TextEditingController _user_POSITION_CODE_ctrl =TextEditingController();
  final TextEditingController _user_JOB_CODE_ctrl = TextEditingController();
  final TextEditingController _user_FACTORY_CODE_ctrl = TextEditingController();
  final TextEditingController _user_WORK_STATUS_CODE_ctrl =TextEditingController();
    Future<void> _loadWorkPosition() async {
    await API_Request.api_query('workpositionlist', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        setState(() {        
          listWorkPosition_org =   dynamicList.map((dynamic item) {
            return WORKPOSITIONDATA.fromJson(item);
          }).toList();
          listWorkPosition = DropListModel(dynamicList.map((dynamic item) {
            return WORKPOSITIONDATA.fromJson(item);
          }).toList().map((e) => OptionItem(title: e.wORKPOSITIONNAME??"", id: e.wORKPOSITIONCODE.toString())).toList());
          init2();
        });
      } else {}
    });
  }
  void init2(){
    setState(() {
 _user_DOB_ctrl.text =
        GlobalFunction.MyDate('yyyy-MM-dd', widget.userData.dOB.toString());
    _user_WORK_START_DATE_ctrl.text = GlobalFunction.MyDate('yyyy-MM-dd',(widget.userData.wORKSTARTDATE ?? "1900-01-01").toString());
    _user_WORK_END_DATE_ctrl.text = GlobalFunction.MyDate('yyyy-MM-dd', (widget.userData.rESIGNDATE ?? "1900-01-01").toString());
    _user_SEX_CODE_ctrl.text = widget.userData.sEXCODE.toString();
    _user_FACTORY_CODE_ctrl.text = widget.userData.fACTORYCODE.toString();
    _user_WORK_POSITION_CODE_ctrl.text = widget.userData.wORKPOSITIONCODE.toString();
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

    

    final List<WORKPOSITIONDATA>  tempFilteredWorkPosition = listWorkPosition_org.where((element) => element.wORKPOSITIONCODE == int.parse(_user_WORK_POSITION_CODE_ctrl.text)).toList();
    final String tempVitrilamviec;

    tempVitrilamviec =  tempFilteredWorkPosition.isNotEmpty ? tempFilteredWorkPosition[0].wORKPOSITIONNAME??"": "Chọn vị trí làm việc";

print('tempVitrilamviec:'+ tempVitrilamviec + ' id:' + _user_WORK_POSITION_CODE_ctrl.text);

      selectedWorkPositionOption = OptionItem(
          title: tempVitrilamviec, id: _user_WORK_POSITION_CODE_ctrl.text);
      selectedSexOption = OptionItem(
          id: _user_SEX_CODE_ctrl.text,
          title: _user_SEX_CODE_ctrl.text == "0" ? "NỮ" : "NAM");
      selectedFactoryOption = OptionItem(
          id: _user_FACTORY_CODE_ctrl.text,
          title: _user_FACTORY_CODE_ctrl.text == "1" ? "NM1" : "NM2");
    });
   
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadWorkPosition();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {   
   
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
        body: Column(
          children: [
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
                          decoration:
                              const InputDecoration(labelText: 'Tỉnh/thành phố'),
                          controller: _user_ADD_PROVINCE_ctrl,
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
                          decoration:
                              const InputDecoration(labelText: 'Số ĐT'),
                          controller: _user_PHONE_NUMBER_ctrl,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'PASSWORD'),
                          controller: _user_PASSWORD_ctrl,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'EMAIL'),
                          controller: _user_EMAIL_ctrl,
                        ),
                         SelectDropList(
                          itemSelected: selectedSexOption,
                          dropListModel: listSEX,
                          showIcon: false,
                          showArrowIcon: true,
                          showBorder: true,
                          paddingTop: 0,
                          paddingDropItem: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          suffixIcon: Icons.arrow_drop_down,
                          containerPadding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.person, color: Colors.black),
                          onOptionSelected: (optionItem) {
                            
                            setState(() {              
                              selectedSexOption = optionItem;                
                              _user_SEX_CODE_ctrl.text =optionItem.id.toString();
                            });
                          },
                        ), 
                         SelectDropList(
                          itemSelected: selectedWorkPositionOption,
                          dropListModel: listWorkPosition,
                          showIcon: false,
                          showArrowIcon: true,
                          showBorder: true,
                          paddingTop: 0,
                          paddingDropItem: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          suffixIcon: Icons.arrow_drop_down,
                          containerPadding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.person, color: Colors.black),
                          onOptionSelected: (optionItem) {
                            
                            setState(() {             
                              selectedWorkPositionOption = optionItem;                 
                              _user_WORK_POSITION_CODE_ctrl.text =optionItem.id.toString();
                            });
                          },
                        ), 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.reset();
                                }
                              },
                              child: const Text('Save'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                _formKey.currentState!.reset();
                              },
                              child: const Text('Clear Form'),
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
    );
  }
}
