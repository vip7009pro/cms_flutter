import 'package:flutter/material.dart';

class KinhDoanh extends StatefulWidget {
  const KinhDoanh({super.key});

  @override
  _KinhDoanhState createState() => _KinhDoanhState();
}

class _KinhDoanhState extends State<KinhDoanh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kinh Doanh'),
        ),
        body: Container(
          child: const Text('Màn hình bộ phận Kinh Doanh'),
        ),
      ),
    );
  }
}
