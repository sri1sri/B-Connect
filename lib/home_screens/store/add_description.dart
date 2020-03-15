import 'package:auto_size_text/auto_size_text.dart';
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

class AddDescription extends StatelessWidget {
  AddDescription({@required this.database, @required this.cartID});
  Database database;
  String cartID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddDescription(
        database: database,cartID: cartID,
      ),
    );
  }
}



class F_AddDescription extends StatefulWidget {
  F_AddDescription({@required this.database, @required this.cartID});
  Database database;
  String cartID;


  @override
  _F_AddDescriptionState createState() => _F_AddDescriptionState();
}

class _F_AddDescriptionState extends State<F_AddDescription> {
//  final _formKey = GlobalKey<FormState>();
//  final TextEditingController _enterCompanyController = TextEditingController();
  final FocusNode _enterCompanyFocusNode = FocusNode();

  String _name;

//  bool _validateAndSaveForm(){
//    final form = _formKey.currentState;
//    if(form.validate()){
//      form.save();
//      return true;
//    }
//    return false;
//  }

//  Future<void> _submit() async{
//    if(_validateAndSaveForm()) {
//      try{
//        switch (widget.title){
//          case 'Companies':
//            final addCompany = CommonVaribles(companies: _name);
//            await widget.database.updateCommonVariables(addCompany);
//            break;
//
//          case 'Categories':
//            final addCompany = CommonVaribles(categories: _name);
//            await widget.database.updateCommonVariables(addCompany);
//            break;
//
//          case 'Items':
//            final addCompany = CommonVaribles(itemNames: _name);
//            await widget.database.updateCommonVariables(addCompany);
//            break;
//
//          case 'Measures':
//            final addCompany = CommonVaribles(measures: _name);
//            await widget.database.updateCommonVariables(addCompany);
//            break;
//        }
//
//        Navigator.of(context).pop();
//      }on PlatformException catch (e){
//        PlatformExceptionAlertDialog(
//          title: 'Operation failed',
//          exception: e,
//        ).show(context);
//      }
//    }
//  }

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
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Add item usage',
              tabBarWidget: null,
            ),
          ),
          body: Column(
            children: <Widget>[
              _buildContent(),
              Container(
                child: AnimatedButton(
//                  onTap: _submit,
                  animationDuration: const Duration(milliseconds: 1000)/,
                  initialText: "Add item usage",
                  finalText: "Description Added",
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
//      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }
  List<Widget>_buildFormChildren() {

    return [
      Container(
        child: Padding(
          padding: const EdgeInsets.all(.0),
          child: TextField(
            minLines: 10,
            maxLines: 15,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Please write item usage description.',
              filled: true,
              fillColor: Colors.black12,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),

            ),
            style: descriptionStyleDark,
          ),
        ),
      ),

//      new TextFormField(
////        controller: _enterCompanyController,
//        keyboardType: TextInputType.multiline,
//        initialValue: _name,
//        textInputAction: TextInputAction.done,
//        obscureText: false,
//        validator: (value) => value.isNotEmpty ? null : 'Description cant\'t be empty.',
//        focusNode: _enterCompanyFocusNode,
//        onSaved: (value) => _name = value,
//        decoration: new InputDecoration(
//          prefixIcon: Icon(
//            Icons.store,
//            color: backgroundColor,
//          ),
//          //labelText: 'Enter ${widget.title} name',
//          border: new OutlineInputBorder(
//            borderRadius: new BorderRadius.circular(5.0),
//            borderSide: new BorderSide(),
//          ),
//        ),
//
//        style: new TextStyle(
//          fontFamily: "Poppins",
//        ),
//      ),
    ];
  }
}

