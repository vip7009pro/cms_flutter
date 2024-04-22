import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/components/HomeDrawerHeader.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/GlobalFunction.dart';
import 'package:cms_flutter/pages/HomeWidget.dart';
import 'package:cms_flutter/pages/LoginPage.dart';
import 'package:cms_flutter/pages/phongban/nhansu/BaoCaoNhanSu.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DangKy.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DiemDanhNhom.dart';
import 'package:cms_flutter/pages/phongban/nhansu/DieuChuyenTeam.dart';
import 'package:cms_flutter/pages/phongban/nhansu/LichSuDiLamList.dart';
import 'package:cms_flutter/pages/phongban/nhansu/PheDuyetNghi.dart';
import 'package:cms_flutter/pages/phongban/nhansu/QuanLyPhongBanNhanSu.dart';
import 'package:cms_flutter/pages/phongban/sx/BarcodeScanner.dart';
import 'package:cms_flutter/pages/phongban/sx/BarcodeScanner2.dart';
import 'package:cms_flutter/pages/phongban/sx/InputLieu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:ota_update/ota_update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  OtaEvent? currentEvent;

Future<void> tryOtaUpdate() async {
    try {
      print('ABI Platform: ${await OtaUpdate().getAbi()}');
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute(
        'https://cms.ddns.net/update/app-release.apk',
        destinationFilename: 'app-release.apk',
        //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        //sha256checksum: 'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478',
      )
          .listen(
        (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  int _selectedBottomIndex = 0;

  final GlobalController c = Get.put(GlobalController());
  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
      switch(index) {
        case 1: 
        Get.to(() =>  LichSuDiLamTable());
        break;
        case 2:
        Get.to(()=> const DangKy());
        break;

        case 3:

        break;

        case 4:

        break;
      }
    });
  }
  final logo = Image.asset('assets/images/cmslogo.jpg', width: 120, fit: BoxFit.cover);

  int mobileVer =8; 
  late Timer _timer;

 Future<bool> _checkMobileVer() async {
    bool check = true;
    await API_Request.api_query('checkWebVer', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        check = true;
        var response = value['data'][0];      
        print(response);  
          int serverMobileVer = response['VERMOBILE'];
          if(mobileVer < serverMobileVer) {
            _timer.cancel();
             AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Thông báo',
                  desc: 'Có phiên bản mới, update nhé !',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {                  
                   tryOtaUpdate();
                  },
                ).show();            
          }
      } else {
        check = false;
      }
    });
    return check;
  }


@override
void initState() {
   //_checkMobileVer();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _checkMobileVer();
    });
  super.initState();}
  
  
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Row(
            children: [
              const Text(
                "Home",
              ),
              logo,
              Text("Ver: ${mobileVer}", style: TextStyle(fontSize: 10),)
            ],
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
              /*  decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(0, 133, 196, 248),
                    Color.fromARGB(0, 0, 140, 255),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ), */
              )),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 193, 228, 244),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
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
                  title: const Text("Điểm danh-điều chuyển"),
                  onTap: () {
                    //action on press
                    Get.to(() => const DiemDanhNhom());
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
                    Get.to(() => const PheDuyetNghi());
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
                    Get.to(() =>  LichSuDiLamTable());
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
                    Get.to(() => const BaoCaoNhanSu());
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
                    Get.to(() => const QuanLyPhongBanNhanSu());
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
                //more child menue
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
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.rightSlide,
                  title: 'Cảnh báo',
                  desc: 'Bạn muốn logout? / Logout 하시겠습니까?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    GlobalFunction.logout();
                    Get.off(() => const LoginPage());
                  },
                ).show();
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 93, 192, 231),
            Color.fromARGB(255, 241, 241, 241),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: HomeWidget(),
        /* child: Obx(() =>  Container(
          height: double.infinity,
          width: double.infinity,
          child: HomeWidget())
          ), */
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 100, 167, 191),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Work History',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Leave Reg',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedBottomIndex,
        selectedItemColor: Color.fromARGB(255, 252, 238, 34),
        onTap: _onBottomItemTapped,
      ),
      /* floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 207, 217, 236),
          child: Icon(Icons.menu),
          onPressed: () {
             //tryOtaUpdate();
            Scaffold.of(context).openDrawer(); // <-- Opens drawer.
          }
        );
      }), */
    );
  }
}
