import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/common_variables.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditStock extends StatelessWidget {
  EditStock({@required this.database, @required this.title});
  Database database;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_EditStock(database: database,title: title,),
    );
  }
}

class F_EditStock extends StatefulWidget {
  F_EditStock({@required this.database, @required this.title});
  Database database;
  String title;
  String labelText;

  @override
  _F_EditStockState createState() => _F_EditStockState();
}

class _F_EditStockState extends State<F_EditStock> {
  final _formKey = GlobalKey<FormState>();

  String _name;

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

        switch (widget.title){
          case 'Companies':
            final addCompany = CommonVaribles(companies: _name);
            await widget.database.updateCommonVariables(addCompany);
            break;

          case 'Categories':
            final addCompany = CommonVaribles(categories: _name);
            await widget.database.updateCommonVariables(addCompany);
            break;

          case 'Items':
            final addCompany = CommonVaribles(itemNames: _name);
            await widget.database.updateCommonVariables(addCompany);
            break;
        }

      Navigator.of(context).pop();
      }on PlatformException catch (e){
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

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
                  'Add ${widget.title}',
                  style: subTitleStyleLight,
                )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Text('Add',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: _submit,
              )
            ],
          ),
          body: _buildContent(),
        ),
      ),
    );
  }
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }
  List<Widget>_buildFormChildren() {

    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Enter ${widget.title} name'),
        initialValue: _name,
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? null : 'company name cant\'t be empty.',
      ),
    ];
  }
}

