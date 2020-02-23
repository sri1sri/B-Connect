import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<String> USERID()async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user.uid;
}