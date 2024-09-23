import 'package:flutter/material.dart';

class DieuChuyenTeam extends StatefulWidget {
  const DieuChuyenTeam({super.key});

  @override
  _DieuChuyenTeamState createState() => _DieuChuyenTeamState();
}

class _DieuChuyenTeamState extends State<DieuChuyenTeam> {

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
        length: 4, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Điều chuyển team'),
            bottom: const TabBar(    
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.0,          
              labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
              isScrollable: true,
              indicatorColor: Colors.greenAccent,
              tabs: [
                Tab(text: 'Tab 1 dai hon'),
                Tab(text: 'Tab 2 dai hon'),
                Tab(text: 'Tab 3 dai hon'),
                Tab(text: 'Tab 3 dai hon'),         
              ],
            ),
          ),
          body: const TabBarView(
            children: [             
              Center(child: Text('Tab 1 Content')),
              Center(child: Text('Tab 2 Content')),
              Center(child: Text('Tab 3 Content')),
              Center(child: Text('Tab 3 Content')),            
            ],
          ),
        ),
      );
      
  }
}
