import 'package:flutter/material.dart';
import 'LoginPage.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});
  @override
  _LoginPageState2 createState() => new _LoginPageState2();
}

class _LoginPageState2 extends State<LoginPage2> {
  @override
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text('Đăng nhập thành công !'),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  Widget build(BuildContext context) {
    final logo = Container(
        child: Image.asset(
      'assets/images/cmslogo.jpg',
    ));

    final username = TextFormField(
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
      child: const Text('Đăng xuất'),
      style: TextButton.styleFrom(
          primary: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 70, 139, 241)),
      onPressed: () {
        //_showToast(context);
        Navigator.pop(context);
      },
    );
    final forgotLabel = TextButton(
      child: const Text('Quên mật khẩu?'),
      onPressed: () {
        //_showToast(context);
      },
    );

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Main'),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: [
                  SizedBox(height: 45.0),
                  username,
                  SizedBox(height: 10.0),
                  password,
                  SizedBox(height: 15.0),
                  loginButton,
                  forgotLabel,
                ],
              ),
            )));
  }
}
