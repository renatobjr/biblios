import 'package:biblios/helpers/customColors.dart';
import 'package:biblios/screens/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 10)).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ghostWhite,
      child: Center(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/img/biblios.png'),
            ),
          ),
        ),
      ),
    );
  }
}
