import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/home_screens/settings_screen.dart';
import 'package:bhavani_connect/profile/profile_extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'profile_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  // Insert into injector file if you use it.
  // injector.map<ProfileBloc>((i) => ProfileBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<ProfileBloc>();

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
    return SealedBlocBuilder4<ProfileBloc, ProfileState, Initial, Loading,
        Success, Failure>(builder: (context, states) {
      return states(
        (Initial initial) => Center(child: CircularProgressIndicator()),
        (Loading loading) => Center(child: CircularProgressIndicator()),
        (Success success) => CustomOfflineWidget(
          onlineChild: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(150),
                child: CustomAppBar(
                  leftActionBar: null,
                  leftAction: () {
                    Navigator.pop(context, true);
                  },
                  rightActionBar: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                        child: SizedBox(
                          width: 56,
                          height: 100,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.more_vert,
                              color: backgroundColor,
                              size: 30,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()),
                          );
                        }),
                  ),
                  rightAction: () {
                    print('right action bar is pressed in appbar');
                  },
                  primaryText: 'Hello!',
                  secondaryText: 'Your Profile',
                  tabBarWidget: null,
                ),
              ),
              body: _buildContent(context, employee: success.data),
            ),
          ),
        ),
        (Failure failure) => Center(
          child: Text('failed to fetch posts'),
        ),
      );
    });
  }

  Widget _buildContent(BuildContext context, {EmployeeDetails employee}) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      height: 400,
                      width: 440,
                      child: Column(children: <Widget>[
                        Stack(children: [
                          Container(
                            height: 400.0,
                          ),
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            top: 120.0,
                            bottom: 20.0,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 0.0,
                                  right: 0.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              height: 20.0,
                              width: 280.0,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white),
                              child: Column(children: <Widget>[
                                SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  (employee == null ? "" : employee.username),
                                  style: titleStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  (employee == null
                                      ? ""
                                      : employee.phoneNumber),
                                  style: descriptionStyleDark,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Role",
                                          style: subTitleStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            (employee == null
                                                ? ""
                                                : employee.role),
                                            style: descriptionStyleDark),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '|',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'OpenSans',
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Project",
                                          style: subTitleStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Bhavani",
                                            style: descriptionStyleDark),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ]),
                            ),
                          ),
                          Positioned(
                            left: 120.0,
                            right: 120.0,
                            top: 30.0,
                            bottom: 230.0,
                            child: employee?.employeeImagePath == null
                                ? CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  )
                                : CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: NetworkImage(
                                        (employee == null
                                            ? ""
                                            : employee.employeeImagePath)),
                                  ),
                          ),
                        ]),
                      ])),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 10.0, bottom: 10.0),
                    height: 260.0,
                    width: 375.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text("Date Of Birth", style: descriptionStyleDark),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${getDate((employee == null ? 0 : employee.dateOfBirth.seconds))}',
                        style: subTitleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Gender", style: descriptionStyleDark),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        (employee == null ? "" : employee.gender),
                        style: subTitleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Joining Date", style: descriptionStyleDark),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${getDate((employee == null ? 0 : employee.joinedDate.seconds))}',
                        style: subTitleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Location", style: descriptionStyleDark),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Not Menttioned${(employee == null ? "" : employee.latitude)}',
                        style: subTitleStyle,
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
