import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
//import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:dropdownfield/dropdownfield.dart';
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

//class Company {
//  int id;
//  String name;
//
//  Company(this.id, this.name);
//
//  static List<Company> getCompanies() {
//    return <Company>[
//      Company(1, 'Apple'),
//      Company(2, 'Google'),
//      Company(3, 'Samsung'),
//      Company(4, 'Sony'),
//      Company(5, 'LG'),
//    ];
//  }
//}

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

  @override
  Widget build(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            //preferredSize : Size(double.infinity, 100),
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
                      'Clear',
                      style: subTitleStyle,
                    ),
                    onTap: () {
                      print('pressed clear in Add items');
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center|,
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
      DropDownFormField(
        titleText: 'Company name',
        hintText: 'Please choose Company',
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

        dataSource: displayDropDownValues(data.companies),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
            value.isNotEmpty ? null : 'Company name cant\'t be empty.',
      ),
//      TextFormField(
//        decoration: new InputDecoration(
//          labelText: "Company name",
//          fillColor: Colors.white,
//          border: new OutlineInputBorder(
//            borderRadius: new BorderRadius.circular(15.0),
//            borderSide: new BorderSide(
//            ),
//          ),
//          //fillColor: Colors.green
//        ),
//        initialValue: _companyName,
//        onSaved: (value) => _companyName = value,
//        validator: (value) => value.isNotEmpty ? null : 'Company name cant\'t be empty.',
//        keyboardType: TextInputType.text,
//        style: new TextStyle(
//          fontFamily: "Quicksand",
//        ),
//      ),
      SizedBox(
        height: 20,
      ),
      DropDownFormField(
        titleText: 'Category Name',
        hintText: 'Please choose Category',
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
        dataSource: displayDropDownValues(data.categories),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
            value.isNotEmpty ? null : 'Category name cant\'t be empty.',
      ),
//      TextFormField(
//        decoration: new InputDecoration(
//          labelText: "Category Name",
//          fillColor: Colors.white,
//          border: new OutlineInputBorder(
//            borderRadius: new BorderRadius.circular(15.0),
//            borderSide: new BorderSide(
//            ),
//          ),
//          //fillColor: Colors.green
//        ),
//        initialValue:  _categoryName,
//        onSaved: (value) =>  _categoryName = value,
//        validator: (value) => value.isNotEmpty ? null : 'Category Name cant\'t be empty.',
//        keyboardType: TextInputType.text,
//        style: new TextStyle(
//          fontFamily: "Quicksand",
//        ),
//      ),
      SizedBox(
        height: 20,
      ),
      DropDownFormField(
        titleText: 'Item Name',
        hintText: 'Please choose Item',
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
        dataSource: displayDropDownValues(data.itemNames),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
            value.isNotEmpty ? null : 'Item name cant\'t be empty.',
      ),
//      TextFormField(
//        decoration: new InputDecoration(
//          labelText: "Item Name",
//          fillColor: Colors.white,
//          border: new OutlineInputBorder(
//            borderRadius: new BorderRadius.circular(15.0),
//            borderSide: new BorderSide(
//            ),
//          ),
//          //fillColor: Colors.green
//        ),
//        initialValue:  _itemName,
//        onSaved: (value) =>  _itemName = value,
//        validator: (value) => value.isNotEmpty ? null : 'Item Name cant\'t be empty.',
//        keyboardType: TextInputType.text,
//        style: new TextStyle(
//          fontFamily: "Quicksand",
//        ),
//      ),

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

      SizedBox(
        height: 20,
      ),
//      DropDownFormField(
//        titleText: 'Quantity',
//        hintText: 'Please choose Quantity',
//        value: _quantity,
//        onSaved: (value) {
//          setState(() {
//            _quantity = value;
//          });
//        },
//        onChanged: (value) {
//          setState(() {
//            _quantity = value;
//          });
//        },
//        dataSource: displayDropDownValues(data.companies),
//        textField: 'display',
//        valueField: 'value',
//        validator: (value) =>
//            value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
//      ),
            TextFormField(
        decoration: new InputDecoration(
          labelText: "Quantity",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(
            ),
          ),
          //fillColor: Colors.green
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

      DropDownFormField(
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
        dataSource: displayDropDownValues(data.measures),
        textField: 'display',
        valueField: 'value',
        validator: (value) =>
            value.isNotEmpty ? null : 'Item name cant\'t be empty.',
      ),
//      TextFormField(
//        decoration: new InputDecoration(
//          labelText: "Measure",
//          fillColor: Colors.white,
//          border: new OutlineInputBorder(
//            borderRadius: new BorderRadius.circular(15.0),
//            borderSide: new BorderSide(
//            ),
//          ),
//          //fillColor: Colors.green
//        ),
//        initialValue: _measure,
//        onSaved: (value) => _measure = value,
//        validator: (value) => value.isNotEmpty ? null : 'Company name cant\'t be empty.',
//        keyboardType: TextInputType.text,
//        style: new TextStyle(
//          fontFamily: "Quicksand",
//        ),
//      ),

//      TextFormField(
//        decoration: new InputDecoration(
//            labelText: "Quantity",
//            //fillColor: Colors.grey,
//            border: new OutlineInputBorder(
//              borderRadius: new BorderRadius.circular(0.0),
//              borderSide: new BorderSide(
//              ),
//            ),
//            fillColor: Colors.green
//        ),
//        initialValue:  _quantity.toString(),
//        onSaved: (value) =>  _quantity = int.tryParse(value),
//        validator: (value) => value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
//        keyboardType: TextInputType.number,
//        style: new TextStyle(
//          fontFamily: "Quicksand",
//        ),
//      ),
      SizedBox(
        height: 25,
      ),
      TextFormField(
        decoration: new InputDecoration(
          labelText: "Description",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(0.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
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
            quantity: 10,
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
