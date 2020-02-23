import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepFourView.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepOneView.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepThreeView.dart';
import 'package:bhavani_connect/home_screens/stepper_screens/StepTwoView.dart';
import 'package:bhavani_connect/home_screens/store_screen.dart';
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
        title: const Text('Enter Previous PinCode'),
        isActive: currStep == 0 ? true : false,
        state: StepState.editing,
        content: Text("vasanth"),
      ),
      Step(
        title: const Text('Enter Previous PinCode'),
        isActive: currStep == 1 ? true : false,
        state: StepState.indexed,
        content: Text("vasanth"),
      ),
      Step(
        title: const Text('Enter Previous PinCode'),
        isActive: currStep == 2 ? true : false,
        state: StepState.indexed,
        content: Text("vasanth"),
      ),
      Step(
        title: const Text('Enter New PinCode'),
        isActive: true,
        state: StepState.complete,
        content: Text("vasanth"),
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
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context){
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4B6E),
        title: Center(child:Text('Order Details',style: subTitleStyleLight,)),

        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body:  _typeStep(),
//      Container(
//        child: Stepper(
//          steps: steps(),
//          currentStep: currStep,
//          onStepContinue: () {
//            setState(() {
//
//                if (currStep < steps().length - 1) {
//                  currStep += 1;
//                } else if (steps().length == 2) {
//                  print('Done');
//                } else {
//                  currStep = 0;
//                }
//
//            });
//          },
//          onStepTapped: (step) {
//            setState(() {
//              currStep = step;
//              print(step);
//            });
//          },
//        ),
//      ),
    );

  }

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => page,
      ),
    );
  }
  int currentStep = 0;
  List<Step> spr = <Step>[];
  List<Step> _getSteps() {
    spr = <Step>[
      Step(
          state: _getState(1),
          title: Text("Step 1"),
          content: new Wrap(
            children:<Widget>[
              StepOneView()
            ],
          ),
          isActive: (currentStep == 0 ? true : false)
      ),
      Step(
        title: Text("Step 2"),
        state: _getState(2),

        content: new Wrap(
          children:<Widget>[
            StepTwoView()
          ],
        ),
        isActive: (currentStep == 1 ? true : false),

      ),
      Step(
        title: Text("Step 3"),
        state: _getState(3),
        content: new Wrap(
          children:<Widget>[
            StepThreeView()
          ],
        ),
        isActive: (currentStep == 1 ? true : false),

      ),
      Step(
        title: Text("Step 4"),
        content: new Wrap(
          children:<Widget>[
            StepFourView()
          ],
        ),
        isActive: (currentStep == 1 ? true : false),
        state: _getState(4),
      )
    ];
    return spr;
  }

  StepState _getState(int i) {
    if (currentStep >= i)
      return StepState.complete;
    else
      return StepState.indexed;
  }

  Widget _typeStep() => Container(
    child: Stepper(

      controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                currentStep < spr.length - 1 ? currentStep += 1 : currentStep = 0;
              });
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Next'),
          ),
        );
      },

      steps: _getSteps(),
      currentStep: currentStep,
      //type: StepperType.horizontal,
      onStepTapped: (step) {
        setState(() {
          currentStep = step;
          print(step);
        });
      },
      onStepCancel: () {
        setState(() {
          currentStep > 0 ? currentStep -= 1 : currentStep = 0;
        });
      },
      onStepContinue: () {
        setState(() {
          currentStep < spr.length - 1 ? currentStep += 1 : currentStep = 0;
        });
      },
    ),
  );

}


//Form(
//key: _formKey,
//child: Stepper(
//steps: steps(),
//currentStep: currStep,
//onStepContinue: () {
//setState(() {
//if (formKeys[currStep].currentState.validate()) {
//if (currStep < steps().length - 1) {
//currStep += 1;
//} else if (steps().length == 2) {
//print('Done');
//} else {
//currStep = 0;
//}
//}
//});
//},
//onStepTapped: (step) {
//setState(() {
//currStep = step;
//print(step);
//});
//},
//),
//),
//List<Step> steps() {
//  return [
//    Step(
//      title: const Text('Enter Previous PinCode'),
//      isActive: currStep == 0 ? true : false,
//      state: StepState.indexed,
//      content: Form(
//        key: formKeys[0],
//        child: TextFormField(
//          autofocus: true,
//          keyboardType: TextInputType.number,
//          validator: (value) {
//            if (value.isEmpty || value != userModelHive.pinCodeNumber) {
//              return 'PinCode Invalid';
//            }
//            return null;
//          },
//        ),
//      ),
//    ),
//    Step(
//      title: const Text('Enter New PinCode'),
//      isActive: true,
//      state: StepState.indexed,
//      content: Form(
//        key: formKeys[1],
//        child: TextFormField(
//          autofocus: true,
//          keyboardType: TextInputType.number,
//          validator: (value) {
//            if (value.isEmpty) {
//              return 'Provided PinCode';
//            } else if (value.length < 4 || value.length > 6) {
//              return "More than 4 Less than 6";
//            }
//            return null;
//          },
//        ),
//      ),
//    ),
//  ];
//}