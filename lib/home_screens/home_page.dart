import 'package:bhavani_connect/auth/bloc.dart';
import 'package:bhavani_connect/dashboard/dashboard_bloc.dart';
import 'package:bhavani_connect/dashboard/dashboard_extras.dart';
import 'package:bhavani_connect/dashboard/dashboard_page.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/landing/landing_bloc.dart';
import 'package:bhavani_connect/profile/profile_bloc.dart';
import 'package:bhavani_connect/profile/profile_extras.dart';
import 'package:bhavani_connect/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/navigationBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = this.context.bloc<AuthenticationBloc>();
    super.initState();
  }

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
    Widget child;
//    final database = Provider.of<Database>(context, listen: false);

    switch (currentIndex) {
      case 0:
        child = BlocProvider(
          create: (context) => DashboardBloc(authenticationBloc: this.context.bloc<AuthenticationBloc>()),
          child: DashboardPage(),
        );
        break;
      case 1:
        child = BlocProvider(
          create: (context) => ProfileBloc(authenticationBloc: this.context.bloc<AuthenticationBloc>())..add(ProfileLoadEmployee()),
          child: ProfilePage(),
        );
        break;
    }
    return Scaffold(
      body: SizedBox.expand(
        child: child,
      ),
      bottomNavigationBar: BottomNavyBar(
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
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Color(0XFF1F4B6E),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
