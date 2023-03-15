import 'package:cms_flutter/components/DataTable.dart';
import 'package:cms_flutter/components/DiemDanhNhomTable.dart';
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
          title: const Text('Điểm danh nhóm table'),
        ),
        body: DiemDanhNhomTable());
  }
}
