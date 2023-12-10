import 'package:cms_flutter/components/DiemDanhNhomTable.dart';
import 'package:flutter/material.dart';

class DiemDanhNhom extends StatefulWidget {
  const DiemDanhNhom({Key? key}) : super(key: key);
  @override
  _DiemDanhNhomState createState() => _DiemDanhNhomState();
}

class _DiemDanhNhomState extends State<DiemDanhNhom> { 
  @override
  Widget build(BuildContext context) {
    return    
    Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 228, 230, 225),
                    Color.fromARGB(255, 198, 233, 133),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: const Text('Điểm danh nhóm', style: TextStyle(color: Colors.blueAccent),),
        ),
        body: DiemDanhNhomTable());   
    
  }
}
