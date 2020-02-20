import 'package:bhavani_connect/authentication_screen/login_screens/login_page_manager.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/phone_number_page.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/home_screens/manage_employees/manage_employees_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  const LoginPage(
      {Key key, @required this.manager, @required this.isLoading})
      : super(key: key);
  final LoginPageManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) =>
            Provider<LoginPageManager>(
              create: (_) =>
                  LoginPageManager(auth: auth, isLoading: isLoading),
              child: Consumer<LoginPageManager>(
                builder: (context, manager, _) =>
                    LoginPage(
                      manager: manager, isLoading: isLoading.value,
                    ),
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context){
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
    return Padding(

      padding: EdgeInsets.all(10.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          Column(
            children: <Widget>[
              SizedBox(height: 50),
              new Image.asset(
                  'images/1.JPG', width: 300, height: 150),
            ],
          ),
          Column(children: <Widget>[
          ],),

          Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              ToDoButton(
                assetName: 'images/google-lodgo.png',
                text: 'Login with phone number',
                textColor: activeButtonTextColor,
                backgroundColor: activeButtonBackgroundColor,
                onPressed: () => _goToPage(context, PhoneNumberPage()),
              ),
              SizedBox(height: 10.0),
              ToDoButton(
                assetName: 'images/google-lodgo.png',
                text: 'Don\'t have an Account? Sign Up',
                textColor: inActiveButtonTextColor,
                backgroundColor: inActiveButtonBackgroundColor,
                onPressed: () => _goToPage(context, ManageEmployeesPage()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => page,
      ),
    );
  }
}