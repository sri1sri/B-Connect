import 'package:bhavani_connect/bloc_helper/lightweight_bloc.dart';
import 'package:bhavani_connect/config/router.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/list/vehicle_list_bloc.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/list/vehicle_list_state.dart';
import 'package:flutter/material.dart';

class VehicleListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<VehicleListBloc>(
        builder: (context) => VehicleListBloc(),
        child: VehicleListScreen(),
      );

  static Future<dynamic> show({BuildContext context}) {
    return null;
  }

  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleListBloc, VehicleListState>(
      listener: (context, bloc, state) {
        //TODO show dialog, navigate to new screen,... here
      },
      child: BlocWidgetBuilder<VehicleListBloc, VehicleListState>(
          builder: (context, bloc, state) {
            //TODO build widget here

            return Container();
          }),
    );
  }

  @override
    void dispose() {
      //TODO dispose
      super.dispose();
    }
}
