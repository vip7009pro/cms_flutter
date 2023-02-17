import 'dart:convert';
import 'dart:developer';
import 'package:cms_flutter/HomePage.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/network_request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> _getToken() async {
    print('vao get token');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final savedToken = _prefs.getString('token') ?? 'reset';
    log(savedToken);
    return savedToken;
  }

  Future _saveToken(String token_string) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token_string);
  }

  void _login(BuildContext context) {
    API_Request.api_query('login2', {
      'user': _user,
      'pass': _pass
    }).then((value) => {
          setState((() {
            if (value['tk_status'] == 'ok') {
              print('dang nhap thanh cong');
              _saveToken(value['token_content']);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else {
              _showToast(context, 'Đăng nhập thất bại, xem lại user or pass');
              print('dang nhap that bai');
              _saveToken('reset');
            }
          }))
        });
  }

  void _checklogin(BuildContext context) async {
    String savedTokenString = '';
    await _getToken().then((value) => {savedTokenString = value});

    API_Request.api_query('checklogin', {
      'token_string': savedTokenString,
      'user': _user,
      'pass': _pass
    }).then((value) => {
          setState((() {
            if (value['tk_status'] == 'ok') {
              print('dang nhap thanh cong');
              _saveToken(value['token_content']);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else {
              _showToast(context, 'Đăng nhập thất bại, xem lại user or pass');
              print('dang nhap that bai');
              _saveToken('reset');
            }
          }))
        });
  }

  void _logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', 'reset');
  }

  @override
  void initState() {
    print('bat dau render');
    //_checklogin(context);
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
    final loginButton = TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 245, 242, 59)),
      onPressed: () {
        _login(context);
        //_logout();
        //_showToast(context);
        /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage())); */
      },
      child: const Text(style: TextStyle(color: Colors.red), 'Đăng nhập'),
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
