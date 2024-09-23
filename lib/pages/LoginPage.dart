import 'dart:convert';
import 'dart:developer';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:cms_flutter/pages/HomePage.dart';
import 'package:cms_flutter/pages/phongban/sx/NHATKYKT.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
const List<String> serverList = <String>[
  'MAIN_SERVER',
  'SUB_SERVER',
  'TEST_SERVER'
];
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool _saveAccount = true;
  String userPosition = '';
  String selectedServer = 'MAIN_SERVER';
  final GlobalController c = Get.put(GlobalController());  
  String _user = '';
  String _pass = '';
final TextEditingController _textFieldUserController = TextEditingController();
final TextEditingController _textFieldPassController = TextEditingController();

Future<void> _loadAccount() async{
  String savedUser = await LocalDataAccess.getVariable("user");
  String savedPass = await LocalDataAccess.getVariable("pass");  
  setState(() {
    _user = savedUser;
    _pass = savedPass;
    _textFieldUserController.text = savedUser;
    _textFieldPassController.text = savedPass;
  });

}
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? 'reset';
    log(savedToken);
    return savedToken;
  }
  void _login(BuildContext context) {
    API_Request.api_query('login2', {'user': _user, 'pass': _pass})
        .then((value) => {
              setState((() {
                if (value['tk_status'] == 'ok') {
                  LocalDataAccess.saveVariable('token', value['token_content']);
                  if (_saveAccount) {
                    LocalDataAccess.saveVariable('user', _user);
                    LocalDataAccess.saveVariable('pass', _pass);
                  } else {
                    LocalDataAccess.saveVariable('user', '');
                    LocalDataAccess.saveVariable('pass', '');
                  }
                  _checklogin(context);
                } else {
                  GlobalFunction.showToast(
                      context, 'Đăng nhập thất bại,  ${value['message']}');
                  LocalDataAccess.saveVariable('token', 'reset');
                }
              }))
            });
  }
  Future<int> _checklogin(BuildContext context) async {
    String savedTokenString = '';
    int result = 0;
    await _getToken().then((value) => {savedTokenString = value});
    await API_Request.api_query('checklogin', {
      'token_string': savedTokenString,
      'user': _user,
      'pass': _pass
    }).then((value) => {
          setState((() {
            if (value['tk_status'] == 'ok') {
              result = 1;
              LocalDataAccess.saveVariable('userData', jsonEncode(value['data']));
              c.changeLoggedInUser(jsonEncode(value['data']));
              LocalDataAccess.getVariable('userData').then(
                (value) {
                  setState(() {
                    Map<String, dynamic> rawJson = jsonDecode(value);
                    c.updateUserData(UserData.fromJson(rawJson));
                    userPosition = rawJson['POSITION_CODE'].toString();
                    if (userPosition == '4' || userPosition == '') {                     
                      Get.off(() => const HomePage());
                    } else {                      
                      Get.off(() => const HomePage());
                    }
                  });
                },
              );              
            } else {
              GlobalFunction.showToast(
                  context, 'Đăng nhập thất bại, xem lại user or pass');
              LocalDataAccess.saveVariable('token', 'reset');
              result = 0;
            }
          }))
        });
    return result;
  }
  @override
  void initState() {
    _loadAccount();
    _checklogin(context);    
    LocalDataAccess.getVariable('serverIP').then((value) {
      if (value != '') {
        selectedServer = value;
      } else {
        selectedServer = 'MAIN_SERVER';
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/images/cmslogo.jpg',
    );
    final username = TextFormField(
      controller: _textFieldUserController,
      textInputAction: TextInputAction.next,
      onChanged: (value) => {_user = value},
      keyboardType: TextInputType.emailAddress,
      autofocus: false,      
      decoration: InputDecoration(
        hintText: 'Tên đăng nhập.....',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      controller: _textFieldPassController,
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (term) {
        _login(context);
      },
      onChanged: (value) => {_pass = value},
      autofocus: false,      
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Mật khẩu',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final loginButton = SizedBox(
      height: 50,
      width: 150,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 10, 97, 179)),
        onPressed: () {          
          _login(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Icon(
              Icons.login,
              color: Colors.white,
            ),
            SizedBox(
              height: 100,
              width: 10,
            ),
            Text(
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                'Đăng nhập'),
          ],
        ),
      ),
    );
    final saveID = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(value: _saveAccount, onChanged: (value) {
          setState(() {
            _saveAccount = value!;
          });

        }),
        const Text("Nhớ tài khoản")
      ],
    );
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                children: [
                  logo,
                  const SizedBox(height: 45.0),
                  username,
                  const SizedBox(height: 10.0),
                  password,
                  const SizedBox(height: 15.0),
                  loginButton,
                  saveID,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Chọn Server:  '),
                      DropdownButton<String>(
                        hint: const Text('Chọn Server'),
                        iconSize: 30,
                        value: selectedServer,
                        icon: const Icon(Icons.computer),
                        elevation: 16,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        underline: Container(
                          height: 2,
                          color: const Color.fromARGB(255, 2, 218, 2),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            selectedServer = value!;
                            LocalDataAccess.saveVariable(
                                'serverIP', selectedServer);
                          });
                        },
                        items: serverList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
