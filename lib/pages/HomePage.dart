import 'package:cms_flutter/components/UserInfo.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final GlobalController c = Get.put(GlobalController());
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
      'Nhân sự',
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
      _selectedBottomIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final logo = Container(
        child: Image.asset(
      'assets/images/cmslogo.jpg',
    ));
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Home")),
      backgroundColor: const Color.fromARGB(255, 222, 250, 253),
      /* drawer: Drawer(
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
                /*  Navigator.pop(context);
                GlobalFunction.logout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())); */
              },
            ),
          ],
        ),
      ), */
      drawer: Drawer(
        child: SafeArea(
            child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: UserInfo()),
            ExpansionTile(
              title: const Text("Nhân Sự"),
              leading: const Icon(
                Icons.person,
                color: Colors.red,
              ), //add icon
              childrenPadding:
                  const EdgeInsets.only(left: 10), //children padding
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  title: const Text("Điểm danh nhóm"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.rotate_90_degrees_ccw,
                    color: Colors.amber,
                  ),
                  title: const Text("Điều chuyển Team"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.app_registration,
                    color: Colors.deepPurple,
                  ),
                  title: const Text("Đăng ký"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.approval,
                    color: Colors.blueAccent,
                  ),
                  title: const Text("Phê duyệt nghỉ"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.history,
                    color: Colors.green,
                  ),
                  title: const Text("Lịch sử đi làm"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.person_2,
                    color: Colors.redAccent,
                  ),
                  title: const Text("Quản lý cấp cao"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.personal_video,
                    color: Colors.blue,
                  ),
                  title: const Text("Báo cáo nhân sự"),
                  onTap: () {
                    //action on press
                  },
                ),
                //more child menu
              ],
            ),
            ExpansionTile(
              title: const Text("Kinh Doanh"),
              leading: const Icon(
                Icons.monetization_on,
                color: Colors.green,
              ), //add icon
              childrenPadding:
                  const EdgeInsets.only(left: 10), //children padding
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.card_travel,
                    color: Color.fromARGB(255, 70, 18, 255),
                  ),
                  title: const Text("Quản lý PO"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.receipt,
                    color: Color.fromARGB(255, 209, 29, 29),
                  ),
                  title: const Text("Quản lý Invoices"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.schedule_send_sharp,
                    color: Colors.deepPurple,
                  ),
                  title: const Text("Quản lý PLAN"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.place_rounded,
                    color: Colors.blueAccent,
                  ),
                  title: const Text("Quản lý FCST"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.leak_add,
                    color: Colors.red,
                  ),
                  title: const Text("Shortage"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 143, 138, 138),
                  ),
                  title: const Text("Quản lý YCSX"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.online_prediction_sharp,
                    color: Colors.orange,
                  ),
                  title: const Text("PO Tích hợp tồn kho"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.info_rounded,
                    color: Colors.blue,
                  ),
                  title: const Text("Thông tin sản phẩm"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.bookmark,
                    color: Colors.black,
                  ),
                  title: const Text("Quản lý code bom"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.person_2,
                    color: Color.fromARGB(255, 7, 165, 55),
                  ),
                  title: const Text("Quản lý Khách hàng"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.mark_chat_read_outlined,
                    color: Colors.red,
                  ),
                  title: const Text("Trạng thái máy"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.check,
                    color: Colors.blue,
                  ),
                  title: const Text("Tình trạng kiểm tra"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.checklist,
                    color: Color.fromARGB(255, 247, 24, 135),
                  ),
                  title: const Text("Báo cáo kinh doanh"),
                  onTap: () {
                    //action on press
                  },
                ),
                //more child menu
              ],
            ),
          ],
        )),
      ),
      body: Center(
          //child: _widgetOptions.elementAt(_selectedIndex),
          child: Obx(() => Text("Clicks: ${c.count}"))),
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
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          heroTag: 'addingbutton',
          onPressed: () {
            c.increment();
          },
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          heroTag: 'substractbutton',
          onPressed: () {
            c.decrement();
          },
          child: const Icon(Icons.delete),
        )
      ]),
    ));
  }
}
