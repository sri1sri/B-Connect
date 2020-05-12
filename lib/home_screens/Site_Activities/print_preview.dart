import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrintPreview extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Container(
    child: F_PrintPreview(),
  );
}
}

class F_PrintPreview extends StatefulWidget {
  @override
  _F_PrintPreview createState() => _F_PrintPreview();
}

class _F_PrintPreview extends State<F_PrintPreview> {
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
          primaryText: 'Print Preview',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Column(
                  children: [
                    Text("Bhavani Vivan (Block-1)",style: subTitleStyleDark1,),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Plastics",style: descriptionStyleDarkBlur2,),
                        Text(" | ",style: descriptionStyleDarkBlur2,),
                        Text("PVC23 Plastics",style: descriptionStyleDarkBlur2,),
                        Text(" | ",style: descriptionStyleDarkBlur2,),
                        Text("20 Nos",style: descriptionStyleDarkBlur2,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    onSelectAll: (b) {},
                    sortAscending: true,
                    showCheckboxColumn: false,
                    dataRowHeight: 70.0,
                    columns: <DataColumn>[
                      DataColumn(label: Text("S.No.",style: subTitleStyle1,)),
                      DataColumn(label: Text("Date",style: subTitleStyle1,)),
                      DataColumn(label: Text("Yesterday’s\nProgress",style: subTitleStyle1,)),
                      DataColumn(label: Text("Total\nProgress",style: subTitleStyle1,)),
                      DataColumn(label: Text("Added By",style: subTitleStyle1,)),
                      DataColumn(label: Text("Remarks",style: subTitleStyle1,)),
                    ],
                    rows: items
                        .map(
                          (itemRow) => DataRow(onSelectChanged: (b) {},
                        cells: [
                          DataCell(
                            Text(itemRow.slNo,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.date,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.yestProg,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.totalprog,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.addedBy,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.remarks,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
                SizedBox(height: 500,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemInfo {
  String slNo;
  String date;
  String yestProg;
  String totalprog;
  String addedBy;
  String remarks;

  ItemInfo({
    this.slNo,
    this.date,
    this.yestProg,
    this.totalprog,
    this.addedBy,
    this.remarks,
  });
}

var items = <ItemInfo>[
  ItemInfo(
      slNo: '1',
      date: '29/Oct/2020',
      yestProg: "30",
      totalprog: "220",
      addedBy: "Manager",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '2',
      date: '29/Oct/2020',
      yestProg: "30",
      totalprog: "220",
      addedBy: "Manager",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      yestProg: "30",
      totalprog: "220",
      addedBy: "Manager",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '4',
      date: '29/Oct/2020',
      yestProg: "30",
      totalprog: "220",
      addedBy: "Manager",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '5',
      date: '29/Oct/2020',
      yestProg: "30",
      totalprog: "220",
      addedBy: "Manager",
      remarks: 'Transfer from store to cnstruction Site'

  ),
];


