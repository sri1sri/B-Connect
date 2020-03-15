import 'dart:io';
import 'dart:async';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/uploader_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddGoodsEntryPage extends StatelessWidget {
  AddGoodsEntryPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddGoodsEntryPage(database: database,),
    );
  }
}

class F_AddGoodsEntryPage extends StatefulWidget {
  F_AddGoodsEntryPage({@required this.database});
  Database database;

  @override
  _F_AddGoodsEntryPageState createState() => _F_AddGoodsEntryPageState();
}

class _F_AddGoodsEntryPageState extends State<F_AddGoodsEntryPage> {
  File _vehicelImage;
  File _MRRImage;
  final TextEditingController _MRRNumberController = TextEditingController();
  bool vechicelCamera;

  Future<void> _captureImage() async {
    File selected = await ImagePicker.pickImage(source: IMAGE_SOURCE,imageQuality: 25);

    setState(() {
      if (vechicelCamera) {
        _vehicelImage = selected;
      } else {
        _MRRImage = selected;
      }
    });
  }

  void _clear() {
    setState(() {
      _MRRImage = null;
      _vehicelImage = null;
    });
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
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(115),
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
              secondaryText: 'Add Goods',
              tabBarWidget: null,
            ),
          ),
//          new AppBar(
//            backgroundColor: Color(0xFF1F4B6E),
//            title: Center(child:Text('Add Goods',style: subTitleStyleLight,)),
//            leading: IconButton(icon:Icon(Icons.arrow_back),
//              onPressed:() => Navigator.pop(context, false),
//            ),
//            centerTitle: true,
//          ),
          body: _buildContent(context),
          bottomNavigationBar: BottomAppBar(
            child: Uploader(vehiceImage: _vehicelImage, MRRImage: _MRRImage, database: widget.database, MRRNumber: _MRRNumberController.value.text,),
//            ToDoButton(
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(child: _buildCards(context));
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            Column(

              children: <Widget>[
                Column(
                  children: <Widget>[],
                ),
                Column(
                  children: <Widget>[

                    Text('Upload vehicel Photo',style: subTitleStyle,),
                    if (_vehicelImage != null) ...[
                      InkWell(
                        child: Container(
                          width: 200,
                          height: 200,
                          //color: Colors.black12,
                          child: Image.file(_vehicelImage),
                        ),
                        onTap: () {
                          vechicelCamera = true;
                          _captureImage();
                        },
                      ),
                    ],

                    SizedBox(height: 20,),


                    InkWell(
                      child: Container(
                        width: 200,
                        height: 20,
                        child: Center(child: Text('tap to add vehicle photo',style: descriptionStyle)),
                      ),
                      onTap: () {
                        vechicelCamera = true;
                        _captureImage();
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Upload MRR',style: subTitleStyle,),
                    if (_MRRImage != null) ...[
                      InkWell(
                        child: Container(
                          width: 200,
                          height: 200,
                          //color: Colors.black12,
                          child: Image.file(_MRRImage),
                        ),
                        onTap: () {
                          vechicelCamera = false;
                          _captureImage();
                        },
                      ),
                    ],
                    SizedBox(height: 20,),
                    InkWell(
                      child: Container(
                        width: 200,
                        height: 20,
                        //color: Colors.black12,
                        child: Center(child: Text('tap to add MRR photo',style: descriptionStyle)),
                      ),
                      onTap: () {
                        vechicelCamera = false;
                        _captureImage();
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    new TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _MRRNumberController,
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.receipt,
                          color: backgroundColor,
                        ),
                        labelText: "Enter MRR No.",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),

                      validator: (val) {
                        if(val.length==0) {
                          return "MRR No. cannot be empty";
                        }else{
                          return null;
                        }
                      },
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
