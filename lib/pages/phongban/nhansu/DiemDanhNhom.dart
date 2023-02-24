import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiemDanhNhom extends StatefulWidget {
  const DiemDanhNhom({Key? key}) : super(key: key);
  @override
  _DiemDanhNhomState createState() => _DiemDanhNhomState();
}

class _DiemDanhNhomState extends State<DiemDanhNhom> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Điểm danh nhóm'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhập tên người dùng'),
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nhập giá trị vào';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Nhập mật khẩu'),
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nhập giá trị vào';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Xử lý dữ liệu')));
                      }
                    },
                    child: const Text('Submit'))
              ],
            ),
          ),
        ));
  }
}
