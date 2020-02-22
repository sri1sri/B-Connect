import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class ItemEntry{
  ItemEntry({ @required this.vehicelImagePath, @required this.mrrImagePath});

  final String vehicelImagePath;
  final String mrrImagePath;

  factory ItemEntry.fromMap(Map<String, dynamic> data){
    if(data == null){
      return null;
    }
    final String vehicelImagePath = data['vehicel_image_path'];
    final String mrrImagePath = data['mrr_image_path'];
    return ItemEntry(
      vehicelImagePath: vehicelImagePath,
      mrrImagePath: mrrImagePath,
    );
  }

  Map<String, dynamic> toMap(){
    print(vehicelImagePath);
    print(mrrImagePath);

    return {
      'vehicel_image_path': vehicelImagePath,
      'mrr_image_path': mrrImagePath,
    };
  }

}