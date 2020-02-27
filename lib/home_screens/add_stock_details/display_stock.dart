import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/common_variables.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/add_stock_details/edit_stock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisplayStock extends StatelessWidget {
  DisplayStock({@required this.database, @required this.title});
  Database database;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DisplayStock(
        database: database,
        title: title,
      ),
    );
  }
}

class F_DisplayStock extends StatefulWidget {
  F_DisplayStock({@required this.database, @required this.title});
  Database database;
  String title;

  @override
  _F_DisplayStockState createState() => _F_DisplayStockState();
}

class _F_DisplayStockState extends State<F_DisplayStock> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(
                child: Text(
              widget.title,
              style: subTitleStyleLight,
            )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    GoToPage(
                        context,
                        EditStock(
                          database: widget.database,
                          title: widget.title,
                        ));
                  }),
            ],
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<CommonVaribles>(
      stream: widget.database.readCommonVariables(),
      builder: (context, snapshot) {
        final commonVariables = snapshot.data;
      },
    );
  }
}
