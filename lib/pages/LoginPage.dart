import 'dart:convert';
import 'dart:developer';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cms_flutter/pages/HomePage.dart';
import 'package:cms_flutter/pages/phongban/sx/InputLieu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalController c = Get.put(GlobalController());
  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text('$message '),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  String _user = '';
  String _pass = '';
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
                  _checklogin(context);
                  /* Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage())); */
                } else {
                  _showToast(
                      context, 'Đăng nhập thất bại, xem lại user or pass');
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
              LocalDataAccess.saveVariable(
                  'userData', jsonEncode(value['data']));
              c.changeLoggedInUser(jsonEncode(value['data']));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const InputLieu()));
              /*  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage())); */
            } else {
              //_showToast(context, 'Đăng nhập thất bại, xem lại user or pass');
              LocalDataAccess.saveVariable('token', 'reset');
              result = 0;
            }
          }))
        });
    return result;
  }

  @override
  void initState() {
    _checklogin(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    final logo = Container(
        child: Image.asset(
      'assets/images/cmslogo.jpg',
    ));
    final username = TextFormField(
      onChanged: (value) => {_user = value},
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Tên đăng nhập.....',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      onChanged: (value) => {_pass = value},
      autofocus: false,
      initialValue: '',
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Icon(
              Icons.login,
              color: Colors.white,
            ),
            const SizedBox(
              height: 100,
              width: 10,
            ),
            const Text(
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                'Đăng nhập'),
          ],
        ),
      ),
    );
    final forgotLabel = TextButton(
      child: const Text('Quên mật khẩu?'),
      onPressed: () {
        //_showToast(context);
      },
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
                  forgotLabel,
                ],
              ),
            )));
  }
}
