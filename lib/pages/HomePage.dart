import 'package:cms_flutter/components/HomeDrawerHeader.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DangKy.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DiemDanhNhom.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DieuChuyenTeam.dart';
import 'package:cms_flutter/pages/phongban/sx/BarcodeScanner.dart';
import 'package:cms_flutter/pages/phongban/sx/BarcodeScanner2.dart';
import 'package:cms_flutter/pages/phongban/sx/InputLieu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _selectedIndex = 0;
  int _selectedBottomIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final GlobalController c = Get.put(GlobalController());

  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text("Home"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 161, 209, 49),
                    Color.fromARGB(255, 0, 255, 191),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          )),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 242, 243, 245),
        child: SafeArea(
            child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 253, 253, 253),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: HomeDrawerHeader()),
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
                  leading: const FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  ),
                  title: const Text("Điểm danh nhóm"),
                  onTap: () {
                    //action on press
                    Get.to(() => const DiemDanhNhom());
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
                    Get.to(() => const DieuChuyenTeam());
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
                    Get.to(() => const DangKy());
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
                    Get.to(() => const DangKy());
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
                    Get.to(() => const DangKy());
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
                    Get.to(() => const QRViewExample2());
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
                    Get.to(() => const QRViewExample());
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.manage_accounts,
                    color: Color.fromARGB(255, 77, 88, 77),
                  ),
                  title: const Text("Quản lý phòng ban-nhân sự"),
                  onTap: () {
                    //action on press
                    Get.to(() => const InputLieu());
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
            ExpansionTile(
              title: const Text("Sản Xuất"),
              leading: const Icon(
                Icons.precision_manufacturing,
                color: Colors.red,
              ), //add icon
              childrenPadding:
                  const EdgeInsets.only(left: 10), //children padding
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 70, 18, 255),
                  ),
                  title: const Text("Quản lý YCSX"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.info,
                    color: Color.fromARGB(255, 117, 141, 247),
                  ),
                  title: const Text("Thông tin sản phẩm"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const FaIcon(
                    FontAwesomeIcons.database,
                    color: Color.fromARGB(255, 225, 103, 250),
                  ),
                  title: const Text("Data Sản Xuất"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                  ),
                  title: const Text("Data Kiểm tra"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const FaIcon(
                    FontAwesomeIcons.pallet,
                    color: Color.fromARGB(255, 32, 192, 125),
                  ),
                  title: const Text("Plan Status"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.wifi,
                    color: Color.fromARGB(255, 0, 43, 236),
                  ),
                  title: const Text("Trạng thái máy"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const FaIcon(
                    FontAwesomeIcons.warehouse,
                    color: Color.fromARGB(255, 9, 243, 60),
                  ),
                  title: const Text("Kho thật"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const FaIcon(
                    FontAwesomeIcons.warehouse,
                    color: Color.fromARGB(255, 234, 17, 253),
                  ),
                  title: const Text("Kho ảo"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                  title: const Text("Lịch sử bắn lot liệu"),
                  onTap: () {
                    //action on press
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: const Icon(
                    Icons.input,
                    color: Color.fromARGB(255, 7, 166, 172),
                  ),
                  title: const Text("Bắn Lot Liệu Sản Xuất"),
                  onTap: () {
                    Get.to(() => const InputLieu());
                    //action on press
                  },
                ),
                //more child menu
              ],
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              leading: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              title: const Text("Logout"),
              onTap: () {
                GlobalFunction.logout();
                Get.to(const LoginPage());
              },
            ),
          ],
        )),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 241, 241, 241),
            Color.fromARGB(255, 93, 192, 231),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Obx(() => Center(child: Text('${c.count}'))),
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
