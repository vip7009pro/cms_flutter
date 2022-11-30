import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            backgroundColor: Color.fromARGB(255, 231, 247, 190),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.

              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Drawer Header'),
                  ),
                  ListTile(
                    title: const Text('R&D'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Kinh Doanh'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('QLSX'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Sản Xuất'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('QC'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Kiểm Tra'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Kho'),
                    onTap: () {
                      Navigator.pop(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
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
