import 'package:cms_flutter/components/UserInfo.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:cms_flutter/pages/phongban/KinhDoanh.dart';
import 'package:cms_flutter/pages/phongban/RnD.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NhanSu extends StatefulWidget {
  const NhanSu({Key? key}) : super(key: key);

  @override
  _NhanSuState createState() => _NhanSuState();
}

class _NhanSuState extends State<NhanSu> {
  int _selectedBottomIndex = 0;
  int _selectedIndex = 0;
  final GlobalController c = Get.put(GlobalController());
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
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

  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhân Sự'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedBottomIndex),
      ),
      drawer: Drawer(
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
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Bạn thực sự muốn Logout'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          GlobalFunction.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Điểm danh nhóm',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Điều chuyển team',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Đăng ký',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Phê duyệt nghỉ',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedBottomIndex,
        showUnselectedLabels: true,
        selectedItemColor: const Color.fromARGB(255, 210, 255, 85),
        onTap: _onBottomItemTapped,
      ),
    );
  }
}
