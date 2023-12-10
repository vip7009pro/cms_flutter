import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';

class BaoCaoNhanSu extends StatefulWidget {
  const BaoCaoNhanSu({Key? key}) : super(key: key);

  @override
  _BaoCaoNhanSuState createState() => _BaoCaoNhanSuState();
}

class _BaoCaoNhanSuState extends State<BaoCaoNhanSu> {

List<DiemDanhNhomDataSummary> _listPheDuyet = List.empty();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
        title: const Text(
          'Báo cáo nhân sự',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: Container(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
