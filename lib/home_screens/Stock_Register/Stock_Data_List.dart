import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_StockDataList(),
    );
  }
}

class F_StockDataList extends StatefulWidget {
  @override
  _F_StockDataList createState() => _F_StockDataList();
}

class _F_StockDataList extends State<F_StockDataList> {
  var dts = DTS();
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
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
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(70),
        child: CustomAppBarDark(
          leftActionBar: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
          leftAction: (){
            Navigator.pop(context,true);
          },
          rightActionBar: Icon(Icons.print,size: 25,color: Colors.white),
          rightAction: (){
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Stock Register',
          tabBarWidget: null,
        ),
      ),
      body:ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0)),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                PaginatedDataTable(
                  header: Column(
                    children: [
                      Text("23 Mar to 29 April",style: subTitleStyleDark1,),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vasanth Steels",style: descriptionStyleDarkBlur2,),
                          Text(" | ",style: descriptionStyleDarkBlur2,),
                          Text("PVC23 Plastics",style: descriptionStyleDarkBlur2,)
                        ],
                      ),
                    ],
                  ),
                  dataRowHeight: 70.0,
                  columns: [
                    DataColumn(label: Text("Date",style: subTitleStyle1,)),
                    DataColumn(label: Text("Item Description",style: subTitleStyle1,),),
                    DataColumn(label: Text("Uom",style: subTitleStyle1,)),
                    DataColumn(label: Text("Supplier Name",style: subTitleStyle1,)),
                    DataColumn(label: Text("Invoice No. & Date",style: subTitleStyle1,)),
                    DataColumn(label: Text("Received Quantity",style: subTitleStyle1,)),
                    DataColumn(label: Text("Issued Quantity",style: subTitleStyle1,)),
                    DataColumn(label: Text("Balance Quantity",style: subTitleStyle1,)),
                    DataColumn(label: Text("Rate",style: subTitleStyle1,)),
                    DataColumn(label: Text("Sub Total",style: subTitleStyle1,)),
                    DataColumn(label: Text("GST",style: subTitleStyle1,)),
                    DataColumn(label: Text("Total Amount (Including GST)",style: subTitleStyle1,)),
                    DataColumn(label: Text("Remarks",style: subTitleStyle1,)),
                  ],
                  source: dts,
                  onRowsPerPageChanged: (r){
                    setState(() {
                      _rowPerPage = r;
                    });
                  },
                  rowsPerPage: _rowPerPage,
                ),
                SizedBox(height: 300,)

              ],
            )
          ),
        ),
      ),
    );
  }
}

class DTS extends DataTableSource{
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(index:index,cells: [
      DataCell(Text("03/01/202$index",style:descriptionStyleDark,)),
      DataCell(Text("PVC pipes & Plasters",style:descriptionStyleDark,)),
      DataCell(Text("Nos",style:descriptionStyleDark,)),
      DataCell(Text("Vasanth Pastics",style:descriptionStyleDark,)),
      DataCell(Text("2424-24/02/2020",style:descriptionStyleDark,)),
      DataCell(Text("800",style:descriptionStyleDark,)),
      DataCell(Text("650",style:descriptionStyleDark,)),
      DataCell(Text("150",style:descriptionStyleDark,)),
      DataCell(Text("₹4,732.00",style:descriptionStyleDark,)),
      DataCell(Text("₹4,722.00",style:descriptionStyleDark,)),
      DataCell(Text("₹732.00",style:descriptionStyleDark,)),
      DataCell(Text("₹24,732.00",style:descriptionStyleDark,)),
      DataCell(Text("Transfer from store to construction site",style:descriptionStyleDark,)),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => 100;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}

