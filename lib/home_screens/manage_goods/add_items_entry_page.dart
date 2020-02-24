import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(
                child: Text(
                  'Add items',
                  style: subTitleStyleLight,
                )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Save',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: _submit,
              )
            ],
            centerTitle: true,
          ),
          body: _buildContent(context),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: _buildFormChildren(),
          ),
        ],
      ),
    );
  }

  List<Widget>_buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Company name'),
        initialValue: _companyName,
        onSaved: (value) => _companyName = value,
        validator: (value) => value.isNotEmpty ? null : 'Company name cant\'t be empty.',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Category name'),
        initialValue: _categoryName,
        onSaved: (value) => _categoryName = value,
        validator: (value) => value.isNotEmpty ? null : 'Category name cant\'t be empty.',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Item name'),
        initialValue: _itemName,
        onSaved: (value) => _itemName = value,
        validator: (value) => value.isNotEmpty ? null : 'Item name cant\'t be empty.',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Quantity'),
        initialValue: _quantity.toString(),
        onSaved: (value) => _quantity = int.tryParse(value),
        validator: (value) => value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
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

  Future<void> _submit() async{
    if(_validateAndSaveForm()) {
      try{

        final itemEntry = ItemEntry(itemName: _itemName, companyName: _companyName, categoryName: _categoryName, quantity: _quantity);
        await widget.database.setItemEntry(itemEntry, widget.goodsID);

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