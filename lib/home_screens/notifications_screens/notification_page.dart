import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_NotificationsPage(),
    );
  }
}

class F_NotificationsPage extends StatefulWidget {
  @override
  _F_NotificationsPageState createState() => _F_NotificationsPageState();
}

class _F_NotificationsPageState extends State<F_NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

