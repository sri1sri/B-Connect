import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/approval_status.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:bhavani_connect/notification/notification_extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'notification_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationPageState();
  }
}

class NotificationPageState extends State<NotificationPage> {
  // Insert into injector file if you use it.
  // injector.map<NotificationBloc>((i) => NotificationBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<NotificationBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
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
          preferredSize: Size.fromHeight(70),
          child: CustomAppBarDark(
            leftActionBar: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
            leftAction: () {
              Navigator.pop(context, true);
            },
            //rightActionBar: Icon(Icons.clear,size: 25,color: Colors.white),
            rightAction: () {
              print('right action bar is pressed in appbar');
            },
            primaryText: 'Notifications',
            tabBarWidget: null,
          ),
        ),
        body: SealedBlocBuilder4<NotificationBloc, NotificationState, Initial,
            Loading, Success, Failure>(builder: (context, states) {
          return states(
            (Initial initial) => Center(child: CircularProgressIndicator()),
            (Loading loading) => Center(child: CircularProgressIndicator()),
            (Success success) => _bodySuccess(context, data: success.data),
            (Failure failure) => Center(),
          );
        }));
  }

  _bodySuccess(BuildContext context, {List<NotificationModel> data}) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ...?generateNotification(data),
            SizedBox(
              height: 700,
            )
          ],
        )),
      ),
    );
  }

  Widget _recentActivities(NotificationModel notificationModel) {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                width: 220,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notificationModel.notificationTitle,
                        style: descriptionStyleDark1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        notificationModel.notificationDescription,
                        style: descriptionStyleDarkBlur3,
                      ),
                    ]),
              ),
            ),
            //(employee == null ? "Not updated" : employee.username)
            notificationModel.status == ApprovalStatus.approvalPending
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.bloc<NotificationBloc>().add(ApproveEvent(
                              notificationModel: notificationModel));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green.withOpacity(0.8),
                          ),
                          height: 30,
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Accept",
                                style: descriptionStyleLite1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.bloc<NotificationBloc>().add(DeclineEvent(
                              notificationModel: notificationModel));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red.withOpacity(0.8),
                          ),
                          height: 30,
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Decline",
                                style: descriptionStyleLite1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: backgroundColor.withOpacity(0.8),
                      ),
                      height: 30,
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _parseStringApproval(notificationModel.status),
                            style: descriptionStyleLite1,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateNotification(List<NotificationModel> data) {
    return data.map((element) => _recentActivities(element)).toList();
  }

  String _parseStringApproval(int approvalStatus) {
    switch (approvalStatus) {
      case ApprovalStatus.approvalPending:
        return 'Pending';
        break;
      case ApprovalStatus.approvalApproved:
        return 'Approved';
        break;
      case ApprovalStatus.approvalDecline:
        return 'Decline';
        break;
    }
    return 'Pending';
  }
}
