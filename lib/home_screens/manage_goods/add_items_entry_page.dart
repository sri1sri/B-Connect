import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemsEntryPage extends StatelessWidget {
  ItemsEntryPage({@required this.database, @required this.goodsID});
  Database database;
  String goodsID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ItemsEntryPage(database: database,goodsID: goodsID,),
    );
  }
}

class F_ItemsEntryPage extends StatefulWidget {
  F_ItemsEntryPage({@required this.database, @required this.goodsID});
  String goodsID;
  Database database;

  @override
  _F_ItemsEntryPageState createState() => _F_ItemsEntryPageState();
}

class _F_ItemsEntryPageState extends State<F_ItemsEntryPage> {

  final _formKey = GlobalKey<FormState>();
  String _companyName;
  String _categoryName;
  String _itemName;
  int _quantity = 0;
  String _description = 'No description entered.';

  @override
  Widget build(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar:
          PreferredSize(
            preferredSize: Size.fromHeight(120),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
                child: FlatButton(onPressed: (){print('pressed clear in Add items');},
                    child: Text('Clear',
                style: subTitleStyle,
                ),
                ),
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Add items',
              tabBarWidget: null,
            ),
          ),

//          new AppBar(
//            backgroundColor: Color(0xFF1F4B6E),
//            title: Center(
//                child: Text(
//                  'Add items',
//                  style: subTitleStyleLight,
//                )),
//            leading: IconButton(
//              icon: Icon(Icons.arrow_back),
//              onPressed: () => Navigator.pop(context, false),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Clear',
//                  style: TextStyle(
//                    fontSize: 18,
//                    color: Colors.white,
//                  ),
//                ),
//                onPressed: () => {print("Clear Fields")},
//              )
//            ],
//            centerTitle: true,
//          ),
          body: _buildContent(context),
          bottomNavigationBar: BottomAppBar(
              child: ToDoButton(
                assetName: 'images/googe-logo.png',
                text: 'Save',
                textColor: Colors.white,
                backgroundColor: activeButtonBackgroundColor,
                onPressed: () {_submit();},
              ),





//              FlatButton.icon(
//
//                  color: activeButtonTextColor,
////                  onPressed: _submit,
//              onPressed: (){},
//                  icon: Icon(Icons.save_alt,size: 30,color: backgroundColor,),
//                  label: Text('Save',style:titleStyle))


          ),
        ),
      ),
    );
  }

  @override
  Widget _buildContent(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {

    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center|,
        children: _buildFormChildren(),
      ),
    );
  }


  List<Widget> _buildFormChildren() {
    return [

      TextFormField(
        decoration: new InputDecoration(
          labelText: "Company name",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(
            ),
          ),
          //fillColor: Colors.green
        ),
        initialValue: _companyName,
        onSaved: (value) => _companyName = value,
        validator: (value) => value.isNotEmpty ? null : 'Company name cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),
      SizedBox(height: 20,),
      TextFormField(
        decoration: new InputDecoration(
          labelText: "Category Name",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(
            ),
          ),
          //fillColor: Colors.green
        ),
        initialValue:  _categoryName,
        onSaved: (value) =>  _categoryName = value,
        validator: (value) => value.isNotEmpty ? null : 'Category Name cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),
      SizedBox(height: 20,),
      TextFormField(
        decoration: new InputDecoration(
          labelText: "Item Name",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(
            ),
          ),
          //fillColor: Colors.green
        ),
        initialValue:  _itemName,
        onSaved: (value) =>  _itemName = value,
        validator: (value) => value.isNotEmpty ? null : 'Item Name cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),
      SizedBox(height: 20,),
//      Row(
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              TextFormField(
//                decoration: new InputDecoration(
//                  labelText: "Company name",
//                  fillColor: Colors.white,
//                  border: new OutlineInputBorder(
//                    borderRadius: new BorderRadius.circular(15.0),
//                    borderSide: new BorderSide(
//                    ),
//                  ),
//                  //fillColor: Colors.green
//                ),
//                initialValue: _companyName,
//                onSaved: (value) => _companyName = value,
//                validator: (value) => value.isNotEmpty ? null : 'Company name cant\'t be empty.',
//                keyboardType: TextInputType.text,
//                style: new TextStyle(
//                  fontFamily: "Poppins",
//                ),
//              ),
//
//            ],
//          ),
//        ],
//      ),
//      Row(
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              TextFormField(
//                decoration: new InputDecoration(
//                  labelText: "Category Name",
//                  fillColor: Colors.white,
//                  border: new OutlineInputBorder(
//                    borderRadius: new BorderRadius.circular(15.0),
//                    borderSide: new BorderSide(
//                    ),
//                  ),
//                  //fillColor: Colors.green
//                ),
//                initialValue:  _categoryName,
//                onSaved: (value) =>  _categoryName = value,
//                validator: (value) => value.isNotEmpty ? null : 'Category Name cant\'t be empty.',
//                keyboardType: TextInputType.text,
//                style: new TextStyle(
//                  fontFamily: "Poppins",
//                ),
//              ),
//
//            ],
//          ),
//        ],
//      ),
//      Row(
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              TextFormField(
//                decoration: new InputDecoration(
//                  labelText: "Item Name",
//                  fillColor: Colors.white,
//                  border: new OutlineInputBorder(
//                    borderRadius: new BorderRadius.circular(15.0),
//                    borderSide: new BorderSide(
//                    ),
//                  ),
//                  //fillColor: Colors.green
//                ),
//                initialValue:  _itemName,
//                onSaved: (value) =>  _itemName = value,
//                validator: (value) => value.isNotEmpty ? null : 'Item Name cant\'t be empty.',
//                keyboardType: TextInputType.text,
//                style: new TextStyle(
//                  fontFamily: "Poppins",
//                ),
//              ),
//
//            ],
//          ),
//        ],
//      ),
//      TextFormField(
//        decoration: new InputDecoration(
//          labelText: "Quantity",
//          fillColor: Colors.white,
//          border: new OutlineInputBorder(
//            borderRadius: new BorderRadius.circular(15.0),
//            borderSide: new BorderSide(
//            ),
//          ),
//          //fillColor: Colors.green
//        ),
//        initialValue:  _quantity.toString(),
//        onSaved: (value) =>  _quantity = int.tryParse(value),
//        validator: (value) => value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
//        keyboardType: TextInputType.number,
//        style: new TextStyle(
//          fontFamily: "Quicksand",
//        ),
//      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Quantity'),
        initialValue: _quantity.toString(),
        onSaved: (value) => _quantity = int.tryParse(value),
        validator: (value) => value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
        keyboardType: TextInputType.number,
      ),

      TextFormField(
        decoration: InputDecoration(labelText: 'Description'),
        initialValue: _description.toString(),
        onSaved: (value) => _description = value,
        validator: (value) => value.isNotEmpty ? null : 'Description cant\'t be empty.',
        keyboardType: TextInputType.number,
      ),
    ];
  }

  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  @override
  Future<void> _submit() async{
    if(_validateAndSaveForm()) {
      try{

        final itemEntry = ItemEntry(itemName: _itemName, companyName: _companyName, categoryName: _categoryName, quantity: _quantity, goodsID: widget.goodsID);
        await widget.database.setItemEntry(itemEntry);

        Navigator.of(context).pop();
      }on PlatformException catch (e){
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }
}