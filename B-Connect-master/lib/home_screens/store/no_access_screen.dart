import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoAccessPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_NoAccessPage(),
    );
  }
}

class F_NoAccessPage extends StatefulWidget {
  @override
  _F_NoAccessPageState createState() => _F_NoAccessPageState();
}

class _F_NoAccessPageState extends State<F_NoAccessPage> {
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
    return Center(
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(
              'images/no_internet.png',
            ),
            height: 300.0,
            width: 300.0,
          ),
          SizedBox(height: 30.0,),
          Text('You dont have access to this page!!!', style: titleStyle,)
        ],
      ),
    );
  }
}
