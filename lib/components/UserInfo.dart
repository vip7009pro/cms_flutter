import 'dart:convert';
import 'dart:developer';

import 'package:cms_flutter/model/UserData.dart';
import 'package:flutter/material.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  List<UserData> userDatas = List<UserData>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    LocalDataAccess.getVariable('userData').then(
      (value) {
        setState(() {
          Map<String, dynamic> rawJson = jsonDecode(value);
          userDatas.add(UserData.fromJson(rawJson));
          log(rawJson['EMPL_NO']);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: userDatas.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Họ và tên: ${userDatas[index].mIDLASTNAME} ${userDatas[index].fIRSTNAME}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text('Bộ phận: ${userDatas[index].mAINDEPTNAME}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            );
          },
        ))
      ]),
    );
  }
}
