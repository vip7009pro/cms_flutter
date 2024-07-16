import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

class PoDetail extends StatefulWidget {
  final PODATA currentPO;
  const PoDetail({Key? key, required this.currentPO}) : super(key: key);

  @override
  _PoDetailState createState() => _PoDetailState();
}

class _PoDetailState extends State<PoDetail> {
  late PODATA _thisPO;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _poG_CODE = TextEditingController();
  final TextEditingController _poCUST_CD = TextEditingController();
  final TextEditingController _poPO_NO = TextEditingController();
  final TextEditingController _poPO_QTY = TextEditingController();
  final TextEditingController _poEMPL_NO = TextEditingController();
  final TextEditingController _poPO_DATE = TextEditingController();
  final TextEditingController _poRD_DATE = TextEditingController();
  final TextEditingController _poPROD_PRICE = TextEditingController();
  final TextEditingController _poBEP = TextEditingController();
  final TextEditingController _poREMARK = TextEditingController();
  
 

  void _khoiTao() {
      _poG_CODE.text = widget.currentPO.gCODE!;
      _poCUST_CD.text =  widget.currentPO.cUSTCD!;
      _poPO_NO.text =  widget.currentPO.pONO!;
      _poPO_QTY.text =  widget.currentPO.pOQTY.toString();
      _poPROD_PRICE.text =  widget.currentPO.pRODPRICE.toString();
      _poBEP.text =  widget.currentPO.bEP.toString();
      _poEMPL_NO.text =  widget.currentPO.eMPLNO!;
      _poREMARK.text =  widget.currentPO.rEMARK!;
      _poPO_DATE.text =  GlobalFunction.MyDate('yyyy-MM-dd', widget.currentPO.pODATE!);
      _poRD_DATE.text =   GlobalFunction.MyDate('yyyy-MM-dd', widget.currentPO.rDDATE!);
  }
  @override
  void initState() {
    // TODO: implement initState
    _thisPO = widget.currentPO;
    _khoiTao();

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
          'Chi tiết PO',
          style: TextStyle(color: Colors.blueAccent),
        ),

      ),
      body: Flex(
        direction: Axis.vertical,
        children: [ Flexible(
                  child: ListView(
                    children: [                    
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'G_CODE',
                              ),
                              controller: _poG_CODE,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'CUST_CD'),
                              controller: _poCUST_CD,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'PO_NO'),
                              controller: _poPO_NO,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'PO_QTY'),
                              controller: _poPO_QTY,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'PROD_PRICE'),
                              controller: _poPROD_PRICE,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'BEP'),
                              controller: _poBEP,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'EMPL_NO'),
                              controller: _poEMPL_NO,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _poPO_DATE,
                              decoration: const InputDecoration(
                                  labelText: 'PO_DATE'),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                      widget.currentPO.pODATE ?? "1900-01-01"),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null &&
                                    pickedDate !=
                                        DateTime.parse(
                                            widget.currentPO.pODATE ?? "1900-01-01")) {
                                  setState(() {
                                    _poPO_DATE.text = GlobalFunction.MyDate(
                                        'yyyy-MM-dd', pickedDate.toString());
                                  });
                                }
                              },
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _poRD_DATE,
                              decoration:
                                  const InputDecoration(labelText: 'RD_DATE'),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                      widget.currentPO.rDDATE ??
                                          "1900-01-01"),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null &&
                                    pickedDate !=
                                        DateTime.parse(
                                            widget.currentPO.rDDATE ??
                                                "1900-01-01")) {
                                  setState(() {
                                    _poRD_DATE.text =
                                        GlobalFunction.MyDate(
                                            'yyyy-MM-dd', pickedDate.toString());
                                  });
                                }
                              },
                            ),  
                             TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'REMARK'),
                              controller: _poREMARK,
                            ), 
                            const SizedBox(height: 10,),                       
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: 'Cảnh báo',
                                      desc: 'Bạn muốn update thông tin nhân viên?',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        
                                      },
                                    ).show();
                                  },
                                  child: const Text('Update'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {                                   
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: 'Cảnh báo',
                                      desc: 'Bạn muốn add nhân viên?',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        
                                      },
                                    ).show();
                                    
                                  },
                                  child: const Text('Add New'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 125, 231, 76),
            child: const Icon(
              Icons.search,
            ),
            onPressed: () {});
      }),
    );
  }
}
