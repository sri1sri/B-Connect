import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/navigationBar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_HomePage(),
    );
  }
}

class F_HomePage extends StatefulWidget {
  F_HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _F_HomePageState createState() => _F_HomePageState();
}

class _F_HomePageState extends State<F_HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {

    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Scaffold(
          body: _buildContent(context),

        ),
      ),
    );
  }


  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    Widget child;

    switch(currentIndex)
    {
      case 0:
      child = Dashboard(database: database,);
        break;
      case 1:
      //child = GridList();
        break;
      case 2:
      // child = ProfileCard();
        break;
      case 3:
      //child = FlutterLogo(colors: Colors.green,);
        break;
    }
    return Scaffold(

      body: SizedBox.expand(child: child,),


      bottomNavigationBar:
      BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) =>
            setState(() {
              currentIndex = index;
            }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Home'),
            activeColor: Color(0XFF1F4B6E),
            textAlign: TextAlign.center,
          ),
          /*BottomNavyBarItem(
            icon: Icon(Icons.format_align_center),
            title: Text(
              'Get All',
            ),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),*/

          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Color(0XFF1F4B6E),
            textAlign: TextAlign.center,
          ),
          /*BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),*/
        ],
      ),
    );
  }
}


