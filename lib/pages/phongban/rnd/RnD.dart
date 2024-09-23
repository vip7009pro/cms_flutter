import 'package:flutter/material.dart';

class RnD extends StatefulWidget {
  const RnD({super.key});

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
