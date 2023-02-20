import 'package:cms_flutter/components/UserInfo.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:cms_flutter/pages/phongban/KinhDoanh.dart';
import 'package:cms_flutter/pages/phongban/NhanSu.dart';
import 'package:cms_flutter/pages/phongban/RnD.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _selectedIndex = 0;
  int _selectedBottomIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _bottomWidgets = <Widget>[
    Text(
      'Bottom1',
      style: optionStyle,
    ),
    Text(
      'Bottom2',
      style: optionStyle,
    ),
    Text(
      'Bottom3',
      style: optionStyle,
    ),
    Text(
      'Bottom4',
      style: optionStyle,
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Nhân Sự',
      style: optionStyle,
    ),
    Text(
      'R&D',
      style: optionStyle,
    ),
    Text(
      'Kinh Doanh',
      style: optionStyle,
    ),
    Text(
      'QLSX',
      style: optionStyle,
    ),
    Text(
      'Sản Xuất',
      style: optionStyle,
    ),
    Text(
      'QC',
      style: optionStyle,
    ),
    Text(
      'Kiểm Tra',
      style: optionStyle,
    ),
    Text(
      'Kho',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final logo = Container(
        child: Image.asset(
      'assets/images/cmslogo.jpg',
    ));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 250, 253),
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
                child: UserInfo()),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.person,
                color: Colors.green,
              ),
              title: const Text('Nhân sự'),
              iconColor: Colors.red,
              onTap: () {
                _onItemTapped(0);
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NhanSu()));
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.run_circle,
                color: Colors.orangeAccent,
              ),
              title: const Text('R&D'),
              onTap: () {
                _onItemTapped(1);
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RnD()));
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.business,
                color: Colors.blueAccent,
              ),
              title: const Text('Kinh Doanh'),
              onTap: () {
                _onItemTapped(2);
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const KinhDoanh()));
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.settings_display,
                color: Colors.redAccent,
              ),
              title: const Text('QLSX'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.settings,
                color: Colors.pinkAccent,
              ),
              title: const Text('Sản Xuất'),
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.high_quality,
                color: Colors.greenAccent,
              ),
              title: const Text('QC'),
              onTap: () {
                _onItemTapped(5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.check,
                color: Colors.orangeAccent,
              ),
              title: const Text('Kiểm Tra'),
              onTap: () {
                _onItemTapped(6);
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.warehouse,
                color: Colors.purpleAccent,
              ),
              title: const Text('Kho'),
              onTap: () {
                _onItemTapped(7);
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                GlobalFunction.logout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedBottomIndex,
        selectedItemColor: Colors.amber[400],
        onTap: _onBottomItemTapped,
      ),
    ));
  }
}
