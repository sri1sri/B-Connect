import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
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

  double _crossAxisSpacing = 8, _mainAxisSpacing = 10, _aspectRatio = 5;
  int _crossAxisCount = 1;
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: null,
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: _title(),
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
          floatingActionButton: FloatingActionButton(
            elevation: 90,
            backgroundColor: backgroundColor,
            autofocus: true,
            onPressed: () {
              GoToPage(
                  context,
                  EditStock(
                    database: widget.database,
                    title: widget.title,
                  ));
            },
            child: Icon(Icons.add),
            tooltip: 'Add Company',
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  @override
  Widget _buildContent(BuildContext context) {
    return StreamBuilder<CommonVaribles>(
        stream: widget.database.readCommonVariables(),
        builder: (context, snapshot) {
          final commonVariables = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 90.0, left: 10.0, right: 10.0),
            child: new GridView.builder(
              itemCount: _itemCount(commonVariables),
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                crossAxisSpacing: _crossAxisSpacing,
                mainAxisSpacing: _mainAxisSpacing,
                childAspectRatio: _aspectRatio,
              ),
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  child: new FlatButton(
                    color: Colors.white,
                    onPressed: () => print('Company'),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              _displayItems(commonVariables)[index],
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

  int _itemCount(CommonVaribles data){
    switch (widget.title){
      case 'Companies':
        return (data == null ? 0 : data.companies.length);
          //data.companies.length;
        break;

      case 'Categories':
        return (data == null ? 0 : data.categories.length);
        //data.categories.length;
        break;

      case 'Items':
        return (data == null ? 0 : data.itemNames.length);
        //data.itemNames.length;
        break;

      case 'Measures':
        return (data == null ? 0 : data.measures.length);
        //data.itemNames.length;
        break;
    }
  }

    _displayItems(CommonVaribles data){
    switch (widget.title){
      case 'Companies':
        return
          data.companies;
        break;

      case 'Categories':
        return data.categories;
        break;

      case 'Items':
        return data.itemNames;
        break;

      case 'Measures':
        return data.measures;
        break;
    }
  }

  String _title(){
    switch (widget.title){
      case 'Companies':
        return 'Company details';
        break;

      case 'Categories':
        return 'Category details';
        break;

      case 'Items':
        return 'Item details';
        break;

      case 'Measures':
        return 'Measures details';
        break;
    }
  }
}
