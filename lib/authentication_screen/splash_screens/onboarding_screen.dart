import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bhavani_connect/utilities/my_navigator.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OnboardingScreen(),
    );
  }
}

class F_OnboardingScreen extends StatefulWidget {
  @override
  _F_OnboardingScreenState createState() => _F_OnboardingScreenState();
}

class _F_OnboardingScreenState extends State<F_OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF1F4B6E) : Color(0xFF1F4B6E).withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
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

  @override
  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => MyNavigator.goToHome(context),
                    child: Text(
                      'Skip',
                      style: subTitleStyle,
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'images/onboarding0.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.15),
                            Text(
                              'Co-operative \nhousing societies',
                              style: titleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Introduce smart, secure, convenient living to your community.',
                              style: descriptionStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'images/onboarding1.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.15),
                            Text(
                              'Developers',
                              style: titleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Enhance the appeal of your project without adding to your overheads.',
                              style: descriptionStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'images/onboarding2.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.15),
                            Text(
                              'Security companies',
                              style: titleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Equip yourself to deliver beyond the expectations of your clients.',
                              style: descriptionStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: subTitleStyle,
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF1F4B6E),
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 50.0,
        width: double.infinity,
        color: Color(0xFF1F4B6E),
        child: GestureDetector(
          onTap: () => MyNavigator.goToHome(context),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Get started',
                style: activeSubTitleStyle,
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}
