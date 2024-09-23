import 'package:flutter/material.dart';

import 'quan_ly_nhan_su.dart';
import 'quan_ly_phong_ban.dart';
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
