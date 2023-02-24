import 'package:flutter/material.dart';

class DangKy extends StatefulWidget {
  const DangKy({Key? key}) : super(key: key);

  @override
  _DangKyState createState() => _DangKyState();
}

class _DangKyState extends State<DangKy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký nghỉ, tăng ca'),
      ),
      body: Container(),
    );
  }
}
