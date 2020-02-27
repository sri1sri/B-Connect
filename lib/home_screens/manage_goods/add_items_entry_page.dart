import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
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
                child: Text('Clear',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => {print("Clear Fields")},
              )
            ],
            centerTitle: true,
          ),
          body: _buildContent(context),
          bottomNavigationBar: BottomAppBar(
              child:   FlatButton.icon(

                  color: activeButtonTextColor,
//                  onPressed: _submit,
              onPressed: (){},
                  icon: Icon(Icons.save_alt,size: 30,color: backgroundColor,),
                  label: Text('Save',style:titleStyle))


          ),
        ),
      ),
    );
  }

  @override
  Widget _buildContent(BuildContext context) {
    return _buildFormChildren();
  }

  Widget _buildForm() {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.center|,
        children: <Widget>[
          _buildFormChildren(),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//            child: Column(
//              children: _buildFormChildren(),
//            ),
//          ),
        ],
      ),
    );
  }

  ConfigurableExpansionTile _buildFormChildren(){
    return ConfigurableExpansionTile(
      headerExpanded: Flexible(child: Center(child: Text("A Header Changed"))),
      header: Container(child: Center(child: Text("A Header"))),
      children: [
        Row(
          children: <Widget>[Text("CHILD 1")],
        ),
        // + more params, see example !!
      ],
    );




//      ListView.builder(
//      itemBuilder: (BuildContext context, int index) =>
//          EntryItem(data[index]),
//      itemCount: data.length,
//    );
  }

/*
  List<Widget>_buildFormChildren() {
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
      Row(
          children: <Widget>[
            Column(
              children: <Widget>[
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
                    fontFamily: "Poppins",
                  ),
                ),

              ],
            ),
//            Column(
//              children: <Widget>[
//                DropDownFormField(
//                  titleText: 'My workout',
//                  hintText: 'Please choose one',
//                  value: _companyName,
//                  onSaved: (value) => _companyName = value,
//                  validator: (value) => value.isNotEmpty ? null : 'Company name cant\'t be empty.',
//                  onChanged: (value) {
//                    setState(() {
//                      _companyName = value;
//                    });
//                  },
//                  dataSource: [
//                    {
//                      "display": "Running",
//                      "value": "Running",
//                    },
//                    {
//                      "display": "Climbing",
//                      "value": "Climbing",
//                    },
//                    {
//                      "display": "Walking",
//                      "value": "Walking",
//                    },
//                    {
//                      "display": "Swimming",
//                      "value": "Swimming",
//                    },
//                    {
//                      "display": "Soccer Practice",
//                      "value": "Soccer Practice",
//                    },
//                    {
//                      "display": "Baseball Practice",
//                      "value": "Baseball Practice",
//                    },
//                    {
//                      "display": "Football Practice",
//                      "value": "Football Practice",
//                    },
//                  ],
//                  textField: 'display',
//                  valueField: 'value',
//                ),
//              ],
//            ),
          ],
      ),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
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
                  fontFamily: "Poppins",
                ),
              ),

            ],
          ),
//          Column(
//            children: <Widget>[
//              DropDownFormField(
//                titleText: 'Category Name',
//                hintText: 'Please choose one',
//                value: _categoryName,
//                onSaved: (value) => _categoryName = value,
//                validator: (value) => value.isNotEmpty ? null : 'Category name cant\'t be empty.',
//                onChanged: (value) {
//                  setState(() {
//                    _categoryName = value;
//                  });
//                },
//                dataSource: [
//                  {
//                    "display": "Running",
//                    "value": "Running",
//                  },
//                  {
//                    "display": "Climbing",
//                    "value": "Climbing",
//                  },
//                  {
//                    "display": "Walking",
//                    "value": "Walking",
//                  },
//                  {
//                    "display": "Swimming",
//                    "value": "Swimming",
//                  },
//                  {
//                    "display": "Soccer Practice",
//                    "value": "Soccer Practice",
//                  },
//                  {
//                    "display": "Baseball Practice",
//                    "value": "Baseball Practice",
//                  },
//                  {
//                    "display": "Football Practice",
//                    "value": "Football Practice",
//                  },
//                ],
//                textField: 'display',
//                valueField: 'value',
//              ),
//            ],
//          ),
        ],
      ),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
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
                  fontFamily: "Poppins",
                ),
              ),

            ],
          ),
//          Column(
//            children: <Widget>[
//              DropDownFormField(
//                titleText: 'Item Name',
//                hintText: 'Please choose one',
//                value: _itemName,
//                onSaved: (value) => _itemName = value,
//                validator: (value) => value.isNotEmpty ? null : 'Item name cant\'t be empty.',
//                onChanged: (value) {
//                  setState(() {
//                    _itemName = value;
//                  });
//                },
//                dataSource: [
//                  {
//                    "display": "Running",
//                    "value": "Running",
//                  },
//                  {
//                    "display": "Climbing",
//                    "value": "Climbing",
//                  },
//                  {
//                    "display": "Walking",
//                    "value": "Walking",
//                  },
//                  {
//                    "display": "Swimming",
//                    "value": "Swimming",
//                  },
//                  {
//                    "display": "Soccer Practice",
//                    "value": "Soccer Practice",
//                  },
//                  {
//                    "display": "Baseball Practice",
//                    "value": "Baseball Practice",
//                  },
//                  {
//                    "display": "Football Practice",
//                    "value": "Football Practice",
//                  },
//                ],
//                textField: 'display',
//                valueField: 'value',
//              ),
//            ],
//          ),
        ],
      ),
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
//      TextFormField(
//        decoration: InputDecoration(labelText: 'Quantity'),
//        initialValue: _quantity.toString(),
//        onSaved: (value) => _quantity = int.tryParse(value),
//        validator: (value) => value.isNotEmpty ? null : 'Quantity cant\'t be empty.',
//        keyboardType: TextInputType.number,
//      ),
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
 */
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}