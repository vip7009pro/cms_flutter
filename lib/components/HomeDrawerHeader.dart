// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/model/UserData.dart';
import 'package:flutter/material.dart';

class HomeDrawerHeader extends StatefulWidget {
  const HomeDrawerHeader({Key? key}) : super(key: key);

  @override
  _HomeDrawerHeaderState createState() => _HomeDrawerHeaderState();
}

class _HomeDrawerHeaderState extends State<HomeDrawerHeader> {
  String EMPL_NO = 'NHU1903';
  @override
  void initState() {
    super.initState();
    LocalDataAccess.getVariable('userData').then(
      (value) {
        setState(() {
          Map<String, dynamic> rawJson = jsonDecode(value);
          EMPL_NO = rawJson['EMPL_NO'];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final logo =
        Image.asset('assets/images/cmslogo.jpg', width: 120, fit: BoxFit.cover);
    final empl_image = CircleAvatar(
      radius: 60,
      backgroundImage:
          NetworkImage('http://14.160.33.94/Picture_NS/NS_$EMPL_NO.jpg'),
    );

    return Container(
      alignment: Alignment.center,
      child: Row(children: <Widget>[
        empl_image,
        logo,
      ]),
    );
  }
}
