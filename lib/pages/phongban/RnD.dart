import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RnD extends StatefulWidget {
  const RnD({Key? key}) : super(key: key);

  @override
  _RnDState createState() => _RnDState();
}

class _RnDState extends State<RnD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RnD'),
        ),
        body: Container(
          child: const Text('Màn hình bộ phận RnD'),
        ),
      ),
    );
  }
}
