import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/cart_model.dart';
import 'package:bhavani_connect/database_model/item_inventry_model.dart';
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
  final _formKey = GlobalKey<FormState>();

  String _itemUsageDescription;

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
        final _cartEntry = Cart(itemDescription : _itemUsageDescription);
        final _inventryEntry = ItemInventry(itemDescription : _itemUsageDescription);
        widget.database.updateCartDetails(_cartEntry, widget.cartID);
        widget.database.updateInventryDetails(_inventryEntry, widget.cartID);

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
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              primaryText: null,
              secondaryText: 'Add item usage',
              tabBarWidget: null,
            ),
          ),
          body: Container(
              color: Colors.blue,
              child: _buildContent()),
        ),
      ),
    );
  }
  Widget _buildContent() {
    return SingleChildScrollView(
      child: _buildForm(),
    );
  }
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.orangeAccent,
          child: _buildCards()),
    );
  }



  Widget _buildCards() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              Column(

                children: <Widget>[

                  TextField(
                    onChanged: (value) => _itemUsageDescription = value,
                    minLines: 2,
                    maxLines: 5,
                    autocorrect: true,
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
                    keyboardType: TextInputType.text,
                    keyboardAppearance: Brightness.dark,
                  ),

                  SizedBox(height: 10,),
                  AnimatedButton(
                    onTap: _submit,
                    animationDuration: const Duration(milliseconds: 1000),
                    initialText: "Save item usage",
                    finalText: "Saved",
                    iconData: Icons.check,
                    iconSize: 22.0,
                    buttonStyle: ButtonStyle(
                      primaryColor: activeButtonBackgroundColor,
                      secondaryColor: Colors.white,
                      elevation: 10.0,
                      initialTextStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      finalTextStyle: TextStyle(
                        fontSize: 18.0,
                        color: backgroundColor,
                      ),
                      borderRadius: 10.0,
                    ),

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

