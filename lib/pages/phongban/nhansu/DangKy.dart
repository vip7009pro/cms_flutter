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
          ),
          body:  TabBarView(
            children: [             
              Center(child: MyLeaveForm()),
              const Center(child: Text('Tab 2 Content')),
              const Center(child: Text('Tab 3 Content')),                       
            ],
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

   @override
  void initState() {
    super.initState();
    _fromDateController.text = GlobalFunction.MyDate('yyyy-MM-dd', fromDate.toString()) ; 
    _toDateController.text = GlobalFunction.MyDate('yyyy-MM-dd', toDate.toString()) ;
  }

  @override
  Widget build(BuildContext context) {    
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(          
          children: [Form(
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
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != fromDate)
                      setState(() {
                        fromDate = pickedDate;
                        _fromDateController.text = GlobalFunction.MyDate('yyyy-MM-dd', fromDate.toString());
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
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != toDate)
                      setState(() {
                        toDate = pickedDate;
                        _toDateController.text =  GlobalFunction.MyDate('yyyy-MM-dd', toDate.toString()); 
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
                  items: [
                    "Phép năm",
                    "Nửa phép",
                    "Nghỉ việc riêng",
                    "Nghỉ ốm",
                    "Lý do khác"
                  ]
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
          ),]
        ),
      );
    
  }
}