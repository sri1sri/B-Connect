import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
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
  final TextEditingController _enterCompanyController = TextEditingController();
  final FocusNode _enterCompanyFocusNode = FocusNode();

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

          case 'Measures':
            final addCompany = CommonVaribles(measures: _name);
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
                //child: Icon(Icons.notifications, size: 40,),
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Add Details',
              tabBarWidget: null,
            ),
          ),

//          new AppBar(
//            backgroundColor: Color(0xFF1F4B6E),
//            title: Center(
//                child: Text(
//                  'Add ${widget.title}',
//                  style: subTitleStyleLight,
//                )),
//            leading: IconButton(
//              icon: Icon(Icons.arrow_back),
//              onPressed: () => Navigator.pop(context, false),
//            ),
//            centerTitle: true,
//            actions: <Widget>[
//              FlatButton(
//                child: Text('',
//                  style: TextStyle(
//                    fontSize: 18,
//                    color: Colors.white,
//                  ),
//                ),
//                onPressed: ()=> print(''),
//              )
//            ],
//          ),
          body: Column(
            children: <Widget>[
              _buildContent(),
              Container(
                child: AnimatedButton(
                  onTap: _submit,
                  animationDuration: const Duration(milliseconds: 1000),
                  initialText: "Add details",
                  finalText: "Details added",
                  iconData: Icons.check,
                  iconSize: 32.0,
                  buttonStyle: ButtonStyle(
                    primaryColor: activeButtonBackgroundColor,
                    secondaryColor: Colors.white,
                    elevation: 10.0,
                    initialTextStyle: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                    finalTextStyle: TextStyle(
                      fontSize: 22.0,
                      color: backgroundColor,
                    ),
                    borderRadius: 10.0,
                  ),
                ),
              ),
            ],
          ),

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
      new TextFormField(
        controller: _enterCompanyController,
        initialValue: _name,
        textInputAction: TextInputAction.done,
        obscureText: false,
        validator: (value) => value.isNotEmpty ? null : 'company name cant\'t be empty.',
        focusNode: _enterCompanyFocusNode,
        onSaved: (value) => _name = value,
        decoration: new InputDecoration(
          prefixIcon: Icon(
            Icons.store,
            color: backgroundColor,
          ),
          labelText: 'Enter ${widget.title} name',
          //fillColor: Colors.redAccent,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(),
          ),
        ),

        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    ];
  }
}

