import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddInvoice(),
    );
  }
}

class F_AddInvoice extends StatefulWidget {
  @override
  _F_AddInvoice createState() => _F_AddInvoice();
}

class _F_AddInvoice extends State<F_AddInvoice> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateFocusNode = FocusNode();
  final TextEditingController _itemDescriptionController = TextEditingController();
  final FocusNode _itemDescriptionFocusNode = FocusNode();
  final TextEditingController _uomController = TextEditingController();
  final FocusNode _uomFocusNode = FocusNode();
  final TextEditingController _supplierNameController = TextEditingController();
  final FocusNode _supplierNameFocusNode = FocusNode();
  final TextEditingController _invoiceDateController = TextEditingController();
  final FocusNode _invoiceDateFocusNode = FocusNode();
  final TextEditingController _receivedQuantityController = TextEditingController();
  final FocusNode _receivedQuantityFocusNode = FocusNode();
  final TextEditingController _issuedQuantityController = TextEditingController();
  final FocusNode _issuedQuantityFocusNode = FocusNode();
  final TextEditingController _balanceQuantityController = TextEditingController();
  final FocusNode _balanceQuantityFocusNode = FocusNode();
  final TextEditingController _rateController = TextEditingController();
  final FocusNode _rateFocusNode = FocusNode();
  final TextEditingController _subTotalController = TextEditingController();
  final FocusNode _subTotalFocusNode = FocusNode();
  final TextEditingController _gstAmountController = TextEditingController();
  final FocusNode _gstAmountFocusNode = FocusNode();
  final TextEditingController _totalPriceController = TextEditingController();
  final FocusNode _totalPriceFocusNode = FocusNode();
  final TextEditingController _remarkController = TextEditingController();
  final FocusNode _remarkFocusNode = FocusNode();


  int _n = 0;
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
          rightActionBar: null,
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Add Stock Invoice',
          tabBarWidget: null,
        ),
      ),
      body:SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _dateController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'date cant\'t be empty.',
                        focusNode: _dateFocusNode,
                        // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter date of purchace',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Item Description",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _itemDescriptionController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Item Description cant\'t be empty.',
                        focusNode: _itemDescriptionFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.library_books,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Item Description',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Uom",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _uomController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Uom cant\'t be empty.',
                        focusNode: _uomFocusNode,
                        // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.category,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter the measure',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Supplier Name",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _supplierNameController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Supplier Name cant\'t be empty.',
                        focusNode: _supplierNameFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Supplier Name',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Invoice No. and Date",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _invoiceDateController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Invoice No. and Date cant\'t be empty.',
                        focusNode: _invoiceDateFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.featured_play_list,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Invoice No. and Date',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Received Quantity",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _receivedQuantityController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Received Quantity cant\'t be empty.',
                        focusNode: _receivedQuantityFocusNode,
                        // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.add_shopping_cart,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Received Quantity',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Issued Quantity",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _issuedQuantityController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Issued Quantity cant\'t be empty.',
                        focusNode: _issuedQuantityFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.shopping_cart,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Issued Quantity',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Balance Quantity",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _balanceQuantityController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Balance Quantity cant\'t be empty.',
                        focusNode: _balanceQuantityFocusNode,
                        // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.shopping_basket,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Balance Quantity',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Rate",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _rateController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Rate cant\'t be empty.',
                        focusNode: _rateFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Item Rate',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Sub Total",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _subTotalController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Sub Total cant\'t be empty.',
                        focusNode: _subTotalFocusNode,
                        // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Sub Total',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("GST Amount",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _gstAmountController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'GST Amount cant\'t be empty.',
                        focusNode: _gstAmountFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.euro_symbol,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter GST Amount',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Total Amount (Including GST)",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _totalPriceController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Total Amount (Including GST) cant\'t be empty.',
                        focusNode: _totalPriceFocusNode,
                        // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.dashboard,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Total Amount',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Remarks",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _remarkController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'Remarks cant\'t be empty.',
                        focusNode: _remarkFocusNode,
                        //onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.list,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Remarks',
                          //fillColor: Colors.redAccent,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 20,),


                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 180,
                      child: GestureDetector(
                        onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => LoginPage(),),
//                      );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "Create",
                                  style: activeSubTitleStyle,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

