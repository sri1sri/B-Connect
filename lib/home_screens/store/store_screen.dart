import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/store/cart_page.dart';
import 'package:flutter/material.dart';
import 'categories_tab.dart';
import 'items_screen.dart';
import 'no_access_screen.dart';
import 'orders_screen.dart';

class StorePage extends StatelessWidget {
  StorePage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_StorePage(database: database, employee: employee,),
    );
  }
}

class F_StorePage extends StatefulWidget {
  F_StorePage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

  @override
  _F_StorePageState createState() => _F_StorePageState();
}

class _F_StorePageState extends State<F_StorePage> {

      TextStyle selectedLabel = new TextStyle(
        color: Color(0xFF1F4B6E),
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
        fontSize: 25.0);

    TextStyle unselectedLabel = new TextStyle(
        color: Color(0xFF1F4B6E),
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
        fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
        length: categories.length,
        child: new Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(160),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.black38,
                ),
              ),
              leftAction: () {
                Navigator.pop(context, true);
              },
              rightActionBar: Container(
                  child: widget.employee.role != 'Site Manager' ? Container() : IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 40,
                    ),
                    onPressed: () => GoToPage(context, CartPage(database: widget.database,)),
                  ),
                  ),
              rightAction: () {
                print('right action bar is pressed in appbar');
              },
              primaryText: 'Store',
              secondaryText: null,
              tabBarWidget: Center(
                child: new TabBar(
                  labelColor: backgroundColor,
                  labelStyle: selectedLabel,
                  unselectedLabelStyle: unselectedLabel,
                  isScrollable: true,
                  tabs: categories.map((Category choice) {
                    return new Tab(
                      text: choice.name,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          body: new TabBarView(
            children: categories.map((Category choice) {
              if (choice.name == 'Items') {
                return new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: widget.employee.role != 'Security' ? new ItemsPage(choice: choice, database: widget.database,employee: widget.employee,) : NoAccessPage(),
                );
              } else {
                return new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: widget.employee.role != 'Security' ? new OrdersPage(choice: choice, database: widget.database,employee: widget.employee,) : NoAccessPage(),
                );
              }
            }).toList(),
          ),
        ),
        //theme: new ThemeData(primaryColor: Colors.deepOrange),
      ),
    );
  }
}