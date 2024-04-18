import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/controller/APIRequest.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sub_dept_screen.dart';
class QuanLyPhongBanNhanSu extends StatefulWidget {
  const QuanLyPhongBanNhanSu({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _QuanLyPhongBanNhanSuState createState() => _QuanLyPhongBanNhanSuState();
}
class _QuanLyPhongBanNhanSuState extends State<QuanLyPhongBanNhanSu> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    print("unmounted");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý phòng ban - nhân sự'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
            isScrollable: true,
            indicatorColor: Colors.greenAccent,
            tabs: [
              Tab(
                  child: Text(
                "Quản lý nhân sự",
                style: TextStyle(color: Color.fromARGB(255, 237, 34, 163)),
              )),
              Tab(
                  child: Text(
                "Quản lý phòng ban",
                style: TextStyle(color: Colors.green),
              )),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            QuanLyNhanSu(),
            QuanLyPhongBan(),
          ],
        ),
      ),
    );
  }
}
class MyList extends StatefulWidget {
  const MyList({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyListState createState() => _MyListState();
}
class _MyListState extends State<MyList> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index]),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(Icons.check, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });
            if (direction == DismissDirection.startToEnd) {
              // Swiped to the right (approve)
            } else {
              // Swiped to the left (delete)
            }
          },
          child: ListTile(
            title: Text(items[index]),
          ),
        );
      },
    );
  }
}
class QuanLyPhongBan extends StatefulWidget {
  const QuanLyPhongBan({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _QuanLyPhongBanState createState() => _QuanLyPhongBanState();
}
class _QuanLyPhongBanState extends State<QuanLyPhongBan> {
  List<MAINDEPTDATA> _mainDeptList = List.empty();
  Future<void> _loadMainDept() async {
    await API_Request.api_query('getmaindept', {}).then((value) {
      if (value['tk_status'] == 'OK') {
        List<dynamic> dynamicList = value['data'];
        /* AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Thông báo',
          desc: 'Đã load ${dynamicList.length} dòng',
          btnOkOnPress: () {},
        ).show(); */
        setState(() {
          _mainDeptList = dynamicList.map((dynamic item) {
            return MAINDEPTDATA.fromJson(item);
          }).toList();
        });
      } else {}
    });
  }
  @override
  void initState() {
    _loadMainDept();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: RefreshIndicator(
                  onRefresh: _loadMainDept,
                  child: Scaffold(
                    body: ListView.builder(
                      itemBuilder: ((BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(2.0),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2.0,
                                blurRadius: 5.0,
                                offset: const Offset(
                                    0, 3), // Changes the position of the shadow
                              )
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 240, 238, 131),
                                  Color.fromARGB(255, 245, 235, 248),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: ListTile(
                            title:
                                Text(_mainDeptList[index].MAINDEPTNAME ?? ""),
                            subtitle: Text(
                                _mainDeptList[index].MAINDEPTNAME_KR ?? ""),
                            iconColor: Colors.black,
                            onTap: () {
                              Get.to(() => SubDeptScreen(
                                    MAINDEPTCODE:
                                        _mainDeptList[index].MAINDEPTCODE ?? 0,
                                  ));
                            },
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 156, 198, 233),
                                    Color.fromARGB(255, 108, 231, 110)
                                  ], // Your gradient colors
                                ),
                                borderRadius: BorderRadius.circular(
                                    25), // Optional: for rounded corners
                              ),
                              child:
                                  const Icon(Icons.house, color: Colors.white),
                            ),
                            /* Icon(Icons.man, color: Colors.red, size: 30,), */
                            trailing: GestureDetector(
                              onTapDown: (TapDownDetails details) {
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    details.globalPosition.dx,
                                    details.globalPosition.dy,
                                    details.globalPosition.dx + 1,
                                    details.globalPosition.dy + 1,
                                  ),
                                  items: <PopupMenuEntry>[
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ).then((value) {
                                  if (value != null) {
                                    // Handle menu item selection here
                                    print('Selected: $value');
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Edit Item'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const TextField(
                                                  decoration:  InputDecoration(
                                                    hintText: 'Enter some text',
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Implement the button functionality here
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const  Text('Submit'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                  }
                                });
                              },
                              child: const Icon(Icons.more_vert),
                            ),
                          ),
                        );
                      }),
                      itemCount: _mainDeptList.length,
                    ),
                    floatingActionButton: Builder(builder: (context) {
                      return FloatingActionButton(                        
                          backgroundColor: const Color.fromARGB(255, 60, 137, 236),
                          child: const Icon(Icons.add),
                          onPressed: () {});
                    }),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
                    
                  ))),
        ],
      ),
    );
  }
}
class QuanLyNhanSu extends StatefulWidget {
  const QuanLyNhanSu({Key? key}) : super(key: key);
  @override
  _QuanLyNhanSuState createState() => _QuanLyNhanSuState();
}
class _QuanLyNhanSuState extends State<QuanLyNhanSu> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Quản lý nhân sự')));
  }
}
