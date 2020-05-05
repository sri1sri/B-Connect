import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/AddNewInvoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DetailDescription(),
    );
  }
}

class F_DetailDescription extends StatefulWidget {
  @override
  _F_DetailDescription createState() => _F_DetailDescription();
}

class _F_DetailDescription extends State<F_DetailDescription> {
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        //preferredSize : Size(double.infinity, 100),
        child: CustomAppBar(
          leftActionBar: Container(
            child: Icon(
              Icons.arrow_back,
              size: 40,
              color: Colors.black38,
            ),
          ),
          leftAction: () {
            Navigator.pop(context, true);
          },
          rightActionBar: Text("Edit",style: subTitleStyle,),
          rightAction: () {
            GoToPage(
                context,
                AddInvoice(
                ));
          },
          primaryText: null,
          secondaryText: 'Stock Detail',
          tabBarWidget: null,
        ),
      ),
      body:Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subtext("Date", "29/Oct/2020"),
                    subtext("Item\nDescription", "28 Tons of TMT rods"),
                    subtext("Uom", "tons"),
                    subtext("Supplier name", "Vasanth Steels"),
                    subtext("Invoice No.\n& Date", "63746 - 29/Oct/2020"),
                    subtext("Received Quantity", "440"),
                    subtext("Issued Quantity", "340"),
                    subtext("Balance Quantity", "100"),
                    subtext("Rate", "₹4732.00"),
                    subtext("Sub Total", "₹4732.00"),
                    subtext("GST Amount", "₹222.00"),
                    Divider(
                      thickness: 1,
                      color: Colors.black54,
                    ),
                    totalsubtext("Total Amount","₹33,732.00"),
                    Divider(
                      thickness: 1,
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Remarks:",style: subTitleStyle ,),
                          SizedBox(height: 5,),
                          Text("Transfer from store to construction site",style: descriptionStyleDarkBlur1,)
                        ],
                      ),
                    ),
            ],
          ),
    ),
    ]
    )
    ))
    );
  }
}

Widget subtext(String _left, String _right) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
            '$_left :',
            style: subTitleStyle
        ),
        Text(
            '$_right',
            style: descriptionStyleDarkBlur1
        ),
      ],
    ),
  );
}

Widget totalsubtext(String _left, String _right) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
            '$_left :',
            style: titleStyle
        ),
        Text(
            '$_right',
            style: highlight
        ),
      ],
    ),
  );
}


