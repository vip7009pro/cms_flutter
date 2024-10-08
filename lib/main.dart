import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final GlobalController c = Get.put(GlobalController());
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMS VINA APP',
      home: LoginPage(),
    );
  }
}
