import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:flutter/material.dart';
class DangKy extends StatefulWidget {
  const DangKy({Key? key}) : super(key: key);
  @override
  _DangKyState createState() => _DangKyState();
}
class _DangKyState extends State<DangKy> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đăng ký'),
          bottom: const TabBar(
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
            isScrollable: true,
            indicatorColor: Colors.greenAccent,
            tabs: [
              Tab(text: 'Đăng ký nghỉ'),
              Tab(text: 'Đăng ký tăng ca'),
              Tab(text: 'Xác nhận chấm công'),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 241, 241, 241),
                    Color.fromARGB(255, 76, 142, 230),
                  ],
                  begin: FractionalOffset(0.0, 1.0),
                  end: FractionalOffset(0.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 241, 241, 241),
              Color.fromARGB(255, 76, 142, 230),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          width: double.infinity,
          height: double.infinity,
          child: TabBarView(
            children: [
              Center(child: MyLeaveForm()),
              Center(child: OvertimeRegistrationForm()),
              Center(child: ForgotAttendanceForm()),
            ],
          ),
        ),
      ),
    );
  }
}
class MyLeaveForm extends StatefulWidget {
  @override
  _MyLeaveFormState createState() => _MyLeaveFormState();
}
class _MyLeaveFormState extends State<MyLeaveForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedShift = "Ca1";
  String selectedLeaveType = "Phép năm";
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String remark = "";
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  var kieuNghi = <String>[
    "Phép năm",
    "Nửa phép",
    "Nghỉ việc riêng",
    "Nghỉ ốm",
    "Chế độ",
    "Lý do khác"
  ];
  var leaveShift = <String>['Ca1', 'Ca2'];
  Future<bool> dangKyNghi() async {
    bool check = true;
    await API_Request.api_query('dangkynghi2', {
      'canghi': leaveShift.indexOf(selectedShift) + 1,
      'reason_code': kieuNghi.indexOf(selectedLeaveType) + 1,
      'remark_content': remark,
      'ngaybatdau': _fromDateController.text,
      'ngayketthuc': _toDateController.text,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đăng ký nghỉ thành công',
          btnOkOnPress: () {},
        ).show();
      } else {
        check = false;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đăng ký nghỉ thất bại',
          btnOkOnPress: () {},
        ).show();
      }
    });
    return check;
  }
  @override
  void initState() {
    super.initState();
    _fromDateController.text =
        GlobalFunction.MyDate('yyyy-MM-dd', fromDate.toString());
    _toDateController.text =
        GlobalFunction.MyDate('yyyy-MM-dd', toDate.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: selectedShift,
                onChanged: (value) {
                  setState(() {
                    selectedShift = value!;
                  });
                },
                items: ["Ca1", "Ca2"]
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Ca nghỉ'),
              ),
              SizedBox(height: 16),
              TextFormField(
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
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedLeaveType,
                onChanged: (value) {
                  setState(() {
                    selectedLeaveType = value!;
                  });
                },
                items: kieuNghi
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Phân loại nghỉ'),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Remark'),
                onChanged: (value) {
                  setState(() {
                    remark = value;
                  });
                },
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
                        dangKyNghi();
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
      ]),
    );
  }
}
class OvertimeRegistrationForm extends StatefulWidget {
  @override
  _OvertimeRegistrationFormState createState() =>
      _OvertimeRegistrationFormState();
}
class _OvertimeRegistrationFormState extends State<OvertimeRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String startTime = "";
  String endTime = "";
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  Future<bool> dangKyTangCa(String overStart, String overFinish) async {
    bool check = true;
    await API_Request.api_query('dangkytangcacanhan', {
      'over_start': overStart,
      'over_finish': overFinish,
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đăng ký tăng ca thành công',
          btnOkOnPress: () {},
        ).show();
      } else {
        check = false;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đăng ký tăng ca thất bại',
          btnOkOnPress: () {},
        ).show();
      }
    });
    return check;
  }
  @override
  void initState() {
    super.initState();
    _startTimeController.text = "";
    _endTimeController.text = "";
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Start Time'),
              onChanged: (value) {
                setState(() {
                  startTime = value;
                  _startTimeController.text = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _endTimeController,
              decoration: InputDecoration(labelText: 'End Time'),
              onChanged: (value) {
                setState(() {
                  endTime = value;
                  _endTimeController.text = value;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform the overtime registration logic here
                      // For example, send data to server or save locally
                      // Reset form after successful registration
                      dangKyTangCa(startTime, endTime);
                      _formKey.currentState!.reset();
                      _startTimeController.text = startTime.toString();
                      _endTimeController.text = endTime.toString();
                    }
                  },
                  child: Text('Đăng ký'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    _startTimeController.text = startTime.toString();
                    _endTimeController.text = endTime.toString();
                  },
                  child: Text('Clear Form'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class ForgotAttendanceForm extends StatefulWidget {
  @override
  _ForgotAttendanceFormState createState() => _ForgotAttendanceFormState();
}
class _ForgotAttendanceFormState extends State<ForgotAttendanceForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedAttendanceType = "Quên giờ vào";
  DateTime selectedDate = DateTime.now();
  String specificTime = "";
  var confirmList = <String>["Quên giờ vào", "Quên giờ về", "Quên cả 2"];
  var confirmListCode = <String>["GD", "GS", "CA"];
  Future<bool> xacNhanChamCong() async {
    bool check = true;
    await API_Request.api_query('xacnhanchamcongnhom', {
      'confirm_worktime':
          "${confirmListCode[confirmList.indexOf(selectedAttendanceType)]}:$specificTime",
      'confirm_date':
          GlobalFunction.MyDate("yyyy-MM-dd", selectedDate.toString()),
    }).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xác nhận thành công',
          btnOkOnPress: () {},
        ).show();
      } else {
        check = false;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Xác nhận thất bại',
          btnOkOnPress: () {},
        ).show();
      }
    });
    return check;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: selectedAttendanceType,
              onChanged: (value) {
                setState(() {
                  selectedAttendanceType = value!;
                });
              },
              items: confirmList
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(labelText: 'Kiểu nghỉ'),
            ),
            SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(1900).subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              decoration: InputDecoration(labelText: 'Ngày quên'),
              controller: TextEditingController(
                text: selectedDate.toLocal().toString().split(' ')[0],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Giờ quên cụ thể'),
              onChanged: (value) {
                setState(() {
                  specificTime = value;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform the attendance confirmation logic here
                      // For example, send data to server or save locally
                      // Reset form after successful confirmation
                      xacNhanChamCong();
                      _formKey.currentState!.reset();
                      selectedDate = DateTime.now();
                    }
                  },
                  child: Text('Xác nhận'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    selectedDate = DateTime.now();
                  },
                  child: Text('Clear Form'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
