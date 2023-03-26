import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashWidget();
  }

  Widget _buildSplashWidget() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Image.asset(
              'assets/image/img_women_circle.png',
            ),
          ),
        ],
      ),
    );
  }
}
