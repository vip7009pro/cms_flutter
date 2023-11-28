// ignore: file_names
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
/// The home page of the application which hosts the datagrid.
class DiemDanhNhomTable extends StatefulWidget {
  /// Creates the home page.
  // ignore: prefer_const_constructors_in_immutables
  DiemDanhNhomTable({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _DiemDanhNhomTableState createState() => _DiemDanhNhomTableState();
}
class _DiemDanhNhomTableState extends State<DiemDanhNhomTable> {
  List<DiemDanhNhom> employees = <DiemDanhNhom>[];
  @override
  void initState() {
    super.initState();
  }
  Future<void> loadData() async {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 241, 241, 241),
            Color.fromARGB(255, 255, 255, 255),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        width: double.infinity,
        height: double.infinity,
        child: const DiemDanhNhomList(),
      ),
    ));
  }
}
class DiemDanhNhomList extends StatefulWidget {
  const DiemDanhNhomList({Key? key}) : super(key: key);
  @override
  _DiemDanhNhomListState createState() => _DiemDanhNhomListState();
}
class _DiemDanhNhomListState extends State<DiemDanhNhomList> {
  List<DiemDanhNhom> _listDiemDanh = List.empty();
  Future<void> loadDiemDanhNhom() async {
    API_Request.api_query('diemdanhnhom', {'team_name_list': 5}).then((value) {
      setState((() {
        if (value['tk_status'] == 'OK') {
          List<dynamic> dynamicList = value['data'];
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Thông báo',
                  desc: 'Đã load ${dynamicList.length} dòng',
                  
                  btnOkOnPress: () {
                   
                  },
                ).show();
          _listDiemDanh = dynamicList.map((dynamic item) {
            return DiemDanhNhom.fromJson(item);
          }).toList();
        } else {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Cảnh báo',
                  desc: 'Không có dòng nào !',                  
                  btnOkOnPress: () {
                   
                  },
                ).show();
        }
      }));
    });
  }
  @override
  void initState() {
    loadDiemDanhNhom();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: loadDiemDanhNhom, child: 
    ListView.builder(
      itemBuilder: ((BuildContext context, int index) {
        final avatar = CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              'http://14.160.33.94/Picture_NS/NS_${_listDiemDanh[index].emplNo}.jpg'),
        );
        final diemdanhWidget = Wrap(spacing: 8.0, children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.green),
            child: const Text("Làm ngày", style: TextStyle(fontSize: 10.0)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.green),
            child: const Text("Làm đêm", style: TextStyle(fontSize: 10.0)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.orange),
            child: const Text("Nghỉ 50%", style: TextStyle(fontSize: 10.0)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.red),
            child: const Text("Nghỉ làm", style: TextStyle(fontSize: 10.0)),
          ),
        ]);
        final tangcawidget = Wrap(spacing: 8.0, children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.red),
            child: const Text("Không TC", style: TextStyle(fontSize: 10.0)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.blueAccent),
            child: const Text("17H-20H", style: TextStyle(fontSize: 10.0)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.blueAccent),
            child: const Text("05H-08H", style: TextStyle(fontSize: 10.0)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.blueAccent),
            child: const Text("17H-18H", style: TextStyle(fontSize: 10.0)),
          ),
        ]);
        
        return Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2.0,
                blurRadius: 5.0,
                offset:
                    const Offset(0, 3), // Changes the position of the shadow
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 189, 241, 176),
                  Color.fromARGB(255, 245, 235, 248),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  avatar,
                  Text(_listDiemDanh[index].emplNo),
                  Text(_listDiemDanh[index].cmsId)
                ],
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      "${index + 1}.${_listDiemDanh[index].midlastName} ${_listDiemDanh[index].firstName}", style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                  _listDiemDanh[index].onOff == 1 ? const Text("Đi làm", style: TextStyle(color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.bold)) :  _listDiemDanh[index].onOff == 0 ? const Text("Nghỉ làm", style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold)): diemdanhWidget ,
                  _listDiemDanh[index].overtime == null ?  tangcawidget : Text(_listDiemDanh[index].overtimeInfo??"KTC", style: const TextStyle(color: Colors.blueAccent, fontSize: 20.0, fontWeight: FontWeight.bold))
                ],
              ),
            const SizedBox(width: 8.0,),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [ ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5.0),
                backgroundColor: Colors.yellowAccent),                
            child: const Text("RESET", style: TextStyle(fontSize: 10.0, color: Colors.black)),
          ),],
            )          
            
            ],
          ),
        );
      }),
      itemCount: _listDiemDanh.length,
    ))    
    ;
  }
}
