import 'package:flutter/material.dart';

class QuanLyPhongBanNhanSu extends StatefulWidget {
  const QuanLyPhongBanNhanSu({Key? key}) : super(key: key);

  @override
  _QuanLyPhongBanNhanSuState createState() => _QuanLyPhongBanNhanSuState();
}

class _QuanLyPhongBanNhanSuState extends State<QuanLyPhongBanNhanSu> {

  @override
  void initState () {
    print("mounted");
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
            bottom:  const TabBar(    
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.0,          
              labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
              isScrollable: true,
              indicatorColor: Colors.greenAccent,
              tabs: [
                Tab(child: Text("Quản lý phòng ban", style: TextStyle(color: Colors.green),) ),
                Tab(child: Text("Quản lý nhân sự", style: TextStyle(color: Color.fromARGB(255, 237, 34, 163)),) ),                                  
              ],
            ),
          ),
          body: const TabBarView(
            children: [             
              QuanLyPhongBan(),
              QuanLyNhanSu()              
            ],
          ),
        ),
      );
      
  }
}




class MyList extends StatefulWidget {
  @override
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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.check, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
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
  const QuanLyPhongBan({ Key? key }) : super(key: key);

  @override
  _QuanLyPhongBanState createState() => _QuanLyPhongBanState();
}

class _QuanLyPhongBanState extends State<QuanLyPhongBan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Quản lý phòng ban'))      
    );
  }
}


class QuanLyNhanSu extends StatefulWidget {
  const QuanLyNhanSu({ Key? key }) : super(key: key);

  @override
  _QuanLyNhanSuState createState() => _QuanLyNhanSuState();
}

class _QuanLyNhanSuState extends State<QuanLyNhanSu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Quản lý nhân sự'))
      
    );
  }
}