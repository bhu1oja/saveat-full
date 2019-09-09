import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:saveat/boardingScreen/splashScreen.dart';
import 'package:saveat/widgets/locationStuffs/locationPermission.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final _controller = PageController();
  bool reachedEnd = false;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new SplashScreen()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new LocationPermession()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 47.0),
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: PageView(
              controller: _controller,
              onPageChanged: _onPageViewChange,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => new LocationPermession()));
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                        color: Color.fromARGB(0xff, 65, 117, 5), fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              height: MediaQuery.of(context).size.height / 6,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 36.0),
                      child: PageIndicator(
                        layout: PageIndicatorLayout.SCALE,
                        activeColor: Colors.black,
                        color: Color.fromARGB(0xff, 142, 147, 147),
                        size: 10.0,
                        controller: _controller,
                        space: 5.0,
                        count: 3,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      height: 48.0,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new LocationPermession()));
                            },
                            child: reachedEnd
                                ? Row(
                                    children: <Widget>[
                                      Text(
                                        "Skip",
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 25,
                                          color:
                                              Color.fromARGB(0xff, 65, 117, 5),
                                        ),
                                      ),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      _controller.nextPage(
                                          duration: kTabScrollDuration,
                                          curve: Curves.ease);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Next",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 25,
                                            color: Color.fromARGB(
                                                0xff, 65, 117, 5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onPageViewChange(int page) {
    if (page == 2) {
      setState(() {
        reachedEnd = true;
      });
    } else {
      setState(() {
        reachedEnd = false;
      });
    }
  }
}
