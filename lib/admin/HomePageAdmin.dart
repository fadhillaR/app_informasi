import 'package:app_informasi/admin/PageUtamaAdmin.dart';
import 'package:app_informasi/admin/SidePageAdmin.dart';
import 'package:app_informasi/screen_page/SidePage.dart';
import 'package:flutter/material.dart';

class NavigationAdmin extends StatefulWidget {
  const NavigationAdmin({super.key});
  @override
  State<NavigationAdmin> createState() => _NavigationAdminState();
}

class _NavigationAdminState extends State<NavigationAdmin>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: tabController,
          children: const [PageAdmin(), PageSideAdmin()]),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(5), bottom: Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TabBar(
                isScrollable: true,
                labelColor: 
                          Color.fromARGB(255, 85, 77, 181),
                unselectedLabelColor: Color.fromARGB(255, 110, 97, 255),
                controller: tabController,
                tabs: [
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust spacing here
                      child: Icon(Icons.home_outlined),
                    ),
                  ),
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust spacing here
                      child: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 0),
            ],
          ),
        ),
      ),
    );
  }
}


