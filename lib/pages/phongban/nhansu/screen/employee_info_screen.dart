import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';


class EmployeeInfoScreen extends StatefulWidget {
  final EmployeeData userData;
  const EmployeeInfoScreen({ Key? key, required this.userData }) : super(key: key);

  @override
  _EmployeeInfoScreenState createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "NAM"),
    OptionItem(id: "0", title: "Nữ"), 
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Chọn giới tính");
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
   final TextEditingController _user_WORK_START_DATE_ctrl = TextEditingController();
   final TextEditingController _user_WORK_END_DATE_ctrl = TextEditingController();
   final TextEditingController _user_PASSWORD_ctrl = TextEditingController();
   final TextEditingController _user_EMAIL_ctrl = TextEditingController();
   final TextEditingController _user_WORK_POSITION_CODE_ctrl = TextEditingController();
   final TextEditingController _user_WORK_SHIFT_CODE_ctrl = TextEditingController();
   final TextEditingController _user_POSITION_CODE_ctrl = TextEditingController();
   final TextEditingController _user_JOB_CODE_ctrl = TextEditingController();
   final TextEditingController _user_FACTORY_CODE_ctrl = TextEditingController();
   final TextEditingController _user_WORK_STATUS_CODE_ctrl = TextEditingController();

   int _user_WORK_SHIFT_CODE = 1;
   
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
        body: Flexible(
            child: ListView(
              children: [
                Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SelectDropList(
              itemSelected: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showArrowIcon: true,
              showBorder: true,
              paddingTop: 0,
              paddingDropItem: const EdgeInsets.only(left: 20,top: 10,bottom: 10,right: 20),
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(0),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionSelected: (optionItem) {
                optionItemSelected = optionItem;
                setState(() {});
              },
            ),
              SizedBox(height: 16),
              /* TextFormField(
                readOnly: true,
                controller: _user_EMPL_NO_ctrl,
                decoration: InputDecoration(labelText: 'ERP ID'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: user,
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
              SizedBox(height: 16),
              TextFormField(
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
              ), */
            
             
              TextFormField(
                decoration: InputDecoration(labelText: 'ERP ID'),
                controller: _user_EMPL_NO_ctrl,               
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform the leave registration logic here
                        // For example, send data to server or save locally
                        // Reset form after successful registration
                       
                        _formKey.currentState!.reset();
                      }
                    },
                    child: Text('Đăng ký nghỉ'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text('Clear Form'),
                  ),
                ],
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