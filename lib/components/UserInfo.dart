import 'package:cms_flutter/controller/network_request.dart';
import 'package:cms_flutter/model/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cms_flutter/controller/network_request.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  //List<UserData> userDatas = [];
  List<UserData> userDatas = List<UserData>.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetWorkRequestAPI.fetchUserData().then((value) => {
          setState(() {
            userDatas = value;
          })
        });
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
