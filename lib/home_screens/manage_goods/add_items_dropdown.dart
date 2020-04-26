import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemsEntry extends StatelessWidget {
  ItemsEntry({@required this.database, @required this.goodsID});
  Database database;
  String goodsID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ItemsEntry(
        database: database,
        goodsID: goodsID,
      ),
    );
  }
}

class F_ItemsEntry extends StatefulWidget {
  F_ItemsEntry({@required this.database, @required this.goodsID});
  String goodsID;
  Database database;

  @override
  _F_ItemsEntryState createState() => _F_ItemsEntryState();
}

class _F_ItemsEntryState extends State<F_ItemsEntry> {
  final _formKey = GlobalKey<FormState>();
  String _companyName;
  String _categoryName;
  String _itemName;
  int _quantity = 0;
  String _measure;
  String _description = 'No description entered.';

  var dropDownValues = [];

  bool _isCompanyNameManual = false;
  bool _isCategoryNameManual = false;
  bool _isItemNameManual = false;
  bool _isMeasureNameManual = false;

  String _manualCompanyBtnTitle = 'Add manually';
  String _manualItemBtnTitle = 'Add manually';
  String _manualCategoryBtnTitle = 'Add manually';
  String _manualMeasureBtnTitle = 'Add manually';

  @override
  Widget build(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
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
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                    child: Text(
                      'Clear all',
                      style: subTitleStyle,
                    ),
                    onTap: () {
                      setState(() {
                        _companyName = null;
                        _itemName = null;
                        _categoryName = null;
                        _quantity = 0;
                        _measure = null;
                        _description = 'No description entered';

                      });
                    }),
              ),
              rightAction: () {
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Add items',
              tabBarWidget: null,
            ),
          ),
          body: SingleChildScrollView(child: _buildContent(context)),
          bottomNavigationBar: BottomAppBar(
            child: FlatButton.icon(
                color: activeButtonTextColor,
                onPressed: () {
                  _submit();
                },
                icon: Icon(
                  Icons.save_alt,
                  size: 30,
                  color: backgroundColor,
                ),
                label: Text('Save', style: titleStyle)),
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
    return StreamBuilder<CommonVaribles>(
        stream: widget.database.readCommonVariables(),
        builder: (context, snapshot) {
          final commonVariables = snapshot.data;
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: _buildFormChildren(commonVariables),
              ),
            ),
          );
        },);

  }

  displayDropDownValues(values){
    try{
      values.forEach((element) {
        var x = {
          "display": element,
          "value": element,
        };
        dropDownValues.add(x);
      }) ;
      return(dropDownValues.take([values][0].length).toList());
    }finally{
      dropDownValues.clear();
    }
  }


  List<Widget> _buildFormChildren(CommonVaribles data) {
    return [

      _isCompanyNameManual != true ? DropDownFormField(
        titleText: 'Company',
        hintText: 'Please choose company',
        value: _companyName,
        onSaved: (value) {
          setState(() {
            _companyName = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _companyName = value;
          });
        },
        dataSource: displayDropDownValues((data == null ? [] : data.companies)),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
        value.isNotEmpty ? null : 'company name cant\'t be empty.',
      ) : TextFormField(
        decoration: new InputDecoration(
          labelText: 'Company',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        initialValue: _companyName,
        onSaved: (value) => _companyName = value,
        validator: (value) => value.isNotEmpty ? null : 'Company cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),

      RaisedButton(
        onPressed: (){
          setState(() {
            if(_isCompanyNameManual){
              _isCompanyNameManual = false;
              _manualCompanyBtnTitle =  'Add manually';
            }else{
              _isCompanyNameManual = true;
              _manualCompanyBtnTitle =  'Select from list';
            }
          });
        },
        child: Text(
            _manualCompanyBtnTitle,
            style: TextStyle(fontSize: 20)
        ),
      ),
      SizedBox(
        height: 25,
      ),

      _isItemNameManual != true ? DropDownFormField(
        titleText: 'Item',
        hintText: 'Please choose item',
        value: _itemName,
        onSaved: (value) {
          setState(() {
            _itemName = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _itemName = value;
          });
        },
        dataSource: displayDropDownValues((data == null ? [] : data.itemNames)),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
        value.isNotEmpty ? null : 'item name cant\'t be empty.',
      ) : TextFormField(
        decoration: new InputDecoration(
          labelText: 'Item',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        initialValue: _itemName,
        onSaved: (value) => _itemName = value,
        validator: (value) => value.isNotEmpty ? null : 'Item cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),

      RaisedButton(
        onPressed: (){
          setState(() {
            if(_isItemNameManual){
              _isItemNameManual = false;
              _manualItemBtnTitle =  'Add manually';
            }else{
              _isItemNameManual = true;
              _manualItemBtnTitle =  'Select from list';
            }
          });
        },
        child: Text(
            _manualItemBtnTitle,
            style: TextStyle(fontSize: 20)
        ),
      ),
      SizedBox(
        height: 25,
      ),



      _isCategoryNameManual != true ? DropDownFormField(
        titleText: 'Category',
        hintText: 'Please choose category',
        value: _categoryName,
        onSaved: (value) {
          setState(() {
            _categoryName = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _categoryName = value;
          });
        },
        dataSource: displayDropDownValues((data == null ? [] : data.categories)),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
        value.isNotEmpty ? null : 'category name cant\'t be empty.',
      ) : TextFormField(
        decoration: new InputDecoration(
          labelText: 'Category',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        initialValue: _categoryName,
        onSaved: (value) => _categoryName = value,
        validator: (value) => value.isNotEmpty ? null : 'Category cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),

      RaisedButton(
        onPressed: (){
          setState(() {
            if(_isCategoryNameManual){
              _isCategoryNameManual = false;
              _manualCategoryBtnTitle =  'Add manually';
            }else{
              _isCategoryNameManual = true;
              _manualCategoryBtnTitle =  'Select from list';
            }
          });
        },
        child: Text(
            _manualCategoryBtnTitle,
            style: TextStyle(fontSize: 20)
        ),
      ),
      SizedBox(
        height: 25,
      ),

      TextFormField(
        decoration: new InputDecoration(
          labelText: "Quantity",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        initialValue:  _quantity.toString(),
        onSaved: (value) =>  _quantity = int.tryParse(value),
        validator: (value) => value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
        keyboardType: TextInputType.number,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),
      SizedBox(
        height: 20,
      ),

      _isMeasureNameManual != true ? DropDownFormField(
        titleText: 'Measure',
        hintText: 'Please choose Measure',
        value: _measure,
        onSaved: (value) {
          setState(() {
            _measure = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _measure = value;
          });
        },
        dataSource: displayDropDownValues((data == null ? [] : data.measures)),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
            value.isNotEmpty ? null : 'Item name cant\'t be empty.',
      ) : TextFormField(
        decoration: new InputDecoration(
          labelText: 'Measure',
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        initialValue: _measure,
        onSaved: (value) => _measure = value,
        validator: (value) => value.isNotEmpty ? null : 'Measure cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),

      RaisedButton(
        onPressed: (){
          setState(() {
            if(_isMeasureNameManual){
              _isMeasureNameManual = false;
              _manualMeasureBtnTitle =  'Add manually';
            }else{
              _isMeasureNameManual = true;
              _manualMeasureBtnTitle =  'Select from list';
            }
          });
        },
        child: Text(
            _manualCompanyBtnTitle,
            style: TextStyle(fontSize: 20)
        ),
      ),
      SizedBox(
        height: 25,
      ),
      TextFormField(
        decoration: new InputDecoration(
          labelText: "Description",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(),
          ),
        ),
        initialValue: _description,
        onSaved: (value) => _description = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Description cant\'t be empty.',
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Quicksand",
        ),
      ),
    ];
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final itemEntry = ItemEntry(
            itemName: _itemName,
            companyName: _companyName,
            categoryName: _categoryName,
            quantityAvailable: _quantity,
            totalQuantity: _quantity,
            goodsID: widget.goodsID,
            measure: _measure,
            item_id: DateTime.now().toString());
        await widget.database.setItemEntry(itemEntry);

        final _itemEntry = GoodsEntry(itemsAdded: true);
        widget.database.updateGoodsEntry(_itemEntry, widget.goodsID);

        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }
}
