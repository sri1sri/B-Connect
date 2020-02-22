import 'dart:io';
import 'dart:async';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/item_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/camera_screens/Camera_page.dart';
import 'package:bhavani_connect/home_screens/camera_screens/uploader_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  bool vechicelCamera;

  Future<void> _captureImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

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
          appBar: new AppBar(
            title: Text(
              'Add goods',
              style: subTitleStyle,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return _buildCards(context);
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
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
                  Text('Upload vehicel Photo'),
                  if (_vehicelImage != null) ...[
                    InkWell(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.black12,
                        child: Image.file(_vehicelImage),
                      ),
                      onTap: () {
                        vechicelCamera = true;
                        _captureImage();
                      },
                    ),
                  ],

                  InkWell(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.black12,
                      child: Center(child: Text('tap to add vehicel photo')),
                    ),
                    onTap: () {
                      vechicelCamera = true;
                      _captureImage();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Upload MRR'),
                  if (_MRRImage != null) ...[
                    InkWell(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.black12,
                        child: Image.file(_MRRImage),
                      ),
                      onTap: () {
                        vechicelCamera = false;
                        _captureImage();
                      },
                    ),
                  ],
                  InkWell(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.black12,
                      child: Center(child: Text('tap to add MRR photo')),
                    ),
                    onTap: () {
                      vechicelCamera = false;
                      _captureImage();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Uploader(vehiceImage: _vehicelImage, MRRImage: _MRRImage),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}