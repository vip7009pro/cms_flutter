import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';

class PoDetail extends StatefulWidget {
  final PODATA currentPO;
  const PoDetail({ Key? key, required this.currentPO}) : super(key: key);

  @override
  _PoDetailState createState() => _PoDetailState();
}

class _PoDetailState extends State<PoDetail> {
  late PODATA _thisPO ;

  @override
  void initState() {
    // TODO: implement initState
    _thisPO = widget.currentPO;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 211, 209, 185),
                  Color.fromARGB(255, 147, 241, 84),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: const Text(
          'Quản lý PO',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: ListView(
        children: [

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 125, 231, 76),
            child: const Icon(
              Icons.search,
            ),
            onPressed: () {
              
            });
      }),

    );
  }
}