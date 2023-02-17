import 'dart:convert';
import 'dart:developer';

import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/SuperLog.dart';
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
    super.initState();
    var postData = {
      'token_string':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjoiW3tcIkNUUl9DRFwiOlwiMDAyXCIsXCJFTVBMX05PXCI6XCJOSFUxOTAzXCIsXCJDTVNfSURcIjpcIkNNUzExNzlcIixcIkZJUlNUX05BTUVcIjpcIkjDmU5HM1wiLFwiTUlETEFTVF9OQU1FXCI6XCJOR1VZ4buETiBWxIJOXCIsXCJET0JcIjpcIjE5OTMtMTAtMThUMDA6MDA6MDAuMDAwWlwiLFwiSE9NRVRPV05cIjpcIlBow7ogVGjhu40gLSDEkMO0bmcgWHXDom4gLSBTw7NjIFPGoW4gLSBIw6AgTuG7mWlcIixcIlNFWF9DT0RFXCI6MSxcIkFERF9QUk9WSU5DRVwiOlwiSMOgIE7hu5lpXCIsXCJBRERfRElTVFJJQ1RcIjpcIlPDs2MgU8ahblwiLFwiQUREX0NPTU1VTkVcIjpcIsSQw7RuZyBYdcOiblwiLFwiQUREX1ZJTExBR0VcIjpcIlRow7RuIFBow7ogVGjhu41cIixcIlBIT05FX05VTUJFUlwiOlwiMDk3MTA5MjQ1NFwiLFwiV09SS19TVEFSVF9EQVRFXCI6XCIyMDE5LTAzLTExVDAwOjAwOjAwLjAwMFpcIixcIlBBU1NXT1JEXCI6XCJkYXV4YW5ocmF1bWFcIixcIkVNQUlMXCI6XCJudmgxOTAzQGNtc2JhbmRvLmNvbVwiLFwiV09SS19QT1NJVElPTl9DT0RFXCI6MixcIldPUktfU0hJRlRfQ09ERVwiOjAsXCJQT1NJVElPTl9DT0RFXCI6MyxcIkpPQl9DT0RFXCI6MSxcIkZBQ1RPUllfQ09ERVwiOjEsXCJXT1JLX1NUQVRVU19DT0RFXCI6MSxcIlJFTUFSS1wiOm51bGwsXCJPTkxJTkVfREFURVRJTUVcIjpcIjIwMjItMDktMTlUMTc6NTg6MTguODYzWlwiLFwiU0VYX05BTUVcIjpcIk5hbVwiLFwiU0VYX05BTUVfS1JcIjpcIuuCqOyekFwiLFwiV09SS19TVEFUVVNfTkFNRVwiOlwixJBhbmcgbMOgbVwiLFwiV09SS19TVEFUVVNfTkFNRV9LUlwiOlwi6re866y07KSRXCIsXCJGQUNUT1JZX05BTUVcIjpcIk5ow6AgbcOheSAxXCIsXCJGQUNUT1JZX05BTUVfS1JcIjpcIjHqs7XsnqVcIixcIkpPQl9OQU1FXCI6XCJEZXB0IFN0YWZmXCIsXCJKT0JfTkFNRV9LUlwiOlwi67aA7ISc64u064u57J6QXCIsXCJQT1NJVElPTl9OQU1FXCI6XCJTdGFmZlwiLFwiUE9TSVRJT05fTkFNRV9LUlwiOlwi7IKs7JuQXCIsXCJXT1JLX1NISUZfTkFNRVwiOlwiSMOgbmggQ2jDrW5oXCIsXCJXT1JLX1NISUZfTkFNRV9LUlwiOlwi7KCV6recXCIsXCJTVUJERVBUQ09ERVwiOjIsXCJXT1JLX1BPU0lUSU9OX05BTUVcIjpcIlBEXCIsXCJXT1JLX1BPU0lUSU9OX05BTUVfS1JcIjpcIlBEXCIsXCJBVFRfR1JPVVBfQ09ERVwiOjEsXCJNQUlOREVQVENPREVcIjoxLFwiU1VCREVQVE5BTUVcIjpcIlBEXCIsXCJTVUJERVBUTkFNRV9LUlwiOlwi7Ya17JetIChQRClcIixcIk1BSU5ERVBUTkFNRVwiOlwiUUNcIixcIk1BSU5ERVBUTkFNRV9LUlwiOlwi7ZKI7KeIXCJ9XSIsImlhdCI6MTY3NTgyMDEzNCwiZXhwIjoyMDM1ODIwMTM0fQ.5srk9TLx_v2TcedvkpQTnl-KhFsmmAdHcYI3p3OySbc',
      'user': 'nhu1903',
      'pass': 'dauxanhrauma'
    };

    API_Request.api_query('login2', postData).then((value) => {
          setState((() {
            //print(value);
            //print(value['tk_status']);
            //print(value['token_content']);
            log(value['token_content']);
          }))
        });
    API_Request.api_query('checklogin', postData).then((value) => {
          setState((() {
            print(value);
          }))
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
