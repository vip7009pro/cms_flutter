import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NhanSu extends StatefulWidget {
  const NhanSu({Key? key}) : super(key: key);

  @override
  _NhanSuState createState() => _NhanSuState();
}

class _NhanSuState extends State<NhanSu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nhân Sự'),
        ),
        body: Container(
          child: const Text('Đây là màn hình quản lý nhân sự'),
        ),
      ),
    );
  }
}
