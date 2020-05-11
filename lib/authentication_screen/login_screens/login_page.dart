import 'package:bhavani_connect/authentication_screen/login_screens/login_page_manager.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/phone_number_page.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  const LoginPage(
      {Key key, this.manager, this.isLoading})
      : super(key: key);
  final LoginPageManager manager;
  final bool isLoading;

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
                onPressed: () => GoToPage(context, PhoneNumberPage()),
              ),
              SizedBox(height: 10.0),
              ToDoButton(
                assetName: 'images/google-lodgo.png',
                text: 'Don\'t have an Account? Sign Up',
                textColor: inActiveButtonTextColor,
                backgroundColor: inActiveButtonBackgroundColor,
                onPressed: () => GoToPage(context, PhoneNumberPage()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}