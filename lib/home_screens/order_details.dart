import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepFourView.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepOneView.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepThreeView.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepTwoView.dart';
import 'package:bhavani_connect/home_screens/store/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OrderDetails(),
    );
  }
}

class F_OrderDetails extends StatefulWidget {

  F_OrderDetails({Key key}) : super(key: key);

 // F_OrderDetails() : super();

  final String title = "Order Details";
  @override
  _F_OrderDetailsState createState() => _F_OrderDetailsState();
}

class _F_OrderDetailsState extends State<F_OrderDetails> {
  int currStep = 0;

  List<Step> steps() {
    return [
      Step(
        title: const Text( 'Enter Previous PinCode' ),
        isActive: currStep == 0 ? true : false,
        state: StepState.editing,
        content: Text( "vasanth" ),
      ),
      Step(
        title: const Text( 'Enter Previous PinCode' ),
        isActive: currStep == 1 ? true : false,
        state: StepState.indexed,
        content: Text( "vasanth" ),
      ),
      Step(
        title: const Text( 'Enter Previous PinCode' ),
        isActive: currStep == 2 ? true : false,
        state: StepState.indexed,
        content: Text( "vasanth" ),
      ),
      Step(
        title: const Text( 'Enter New PinCode' ),
        isActive: true,
        state: StepState.complete,
        content: Text( "vasanth" ),
      ),

    ];
  }


//  int current_step = 0;
//  List<Step> steps = [
//    Step(
//      title: Text('Step 1'),
//      content: Text('Hello!'),
//      isActive: true,
//    ),
//    Step(
//      title: Text('Step 2'),
//      content: Text('World!'),
//      isActive: true,
//    ),
//    Step(
//      title: Text('Step 3'),
//      content: Text('Hello World!'),
//      state: StepState.complete,
//      isActive: true,
//    ),
//  ];
  @override
  Widget build(BuildContext context) {
    return offlineWidget( context );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0,0,0,0 ),
        child: Scaffold(
          body: _buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color( 0xFF1F4B6E ),
        title: Center(
            child: Text( 'Order Details',style: subTitleStyleLight, ) ),

        leading: IconButton( icon: Icon( Icons.arrow_back ),
          onPressed: () => Navigator.pop( context,false ),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: <Widget>[
          SizedBox( height: 10, ),

          Text( "Order Status",style: descriptionStyle, ),
          SizedBox( height: 10, ),
          Row(
            children: <Widget>[
              SizedBox( width: 40, ),
              CircleAvatar( backgroundColor: Colors.grey,radius: 6, ),
              Text( " ------------ ",style: descriptionStyle, ),
              CircleAvatar( backgroundColor: Colors.yellow,radius: 6, ),
              Text( " ------------ ",style: descriptionStyle, ),
              CircleAvatar( backgroundColor: Colors.green,radius: 6, ),
              Text( " ------------ ",style: descriptionStyle, ),
              CircleAvatar( backgroundColor: Colors.red,radius: 6, ),
              SizedBox( width: 40, ),
            ],
          ),
          SizedBox( height: 10, ),
          Row(
            children: <Widget>[
              SizedBox( width: 10, ),
              Text( "Supervisor",style: statusTracker, ),
              SizedBox( width: 25, ),

              Text( "Manager",style: statusTracker, ),
              SizedBox( width: 10, ),
              Text( "Store Manager",style: statusTracker, ),
              SizedBox( width: 10, ),

              Text( "Accountant",style: statusTracker, ),

            ],
          ),


          SizedBox( height: 20, ),
          Text( "Tap for Order Details",style: descriptionStyleDarkBlur, ),
          SizedBox( height: 20, ),
        ],

      ),

    );
  }

  void _goToPage(BuildContext context,Widget page) {
    Navigator.of( context ).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => page,
      ),
    );
  }
}