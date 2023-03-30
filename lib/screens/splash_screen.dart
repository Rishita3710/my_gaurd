import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_guard/screens/home_screen.dart';
import 'package:my_guard/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _isLoginStateRetrieved;

  User? _user;

  //region: Overridden Functions

  @override
  void initState() {
    super.initState();
    _initScreenVariables();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoginStateRetrieved == false) {
      return _buildSplashWidget();
    }

    return _user == null ? const LoginScreen() : const HomeScreen();
  }

//endregion

  //region: Widgets
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

  //endregion

  //region: Private Functions

  void _initScreenVariables() {
    _isLoginStateRetrieved = false;
    _user = FirebaseAuth.instance.currentUser;

    Future<dynamic>.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoginStateRetrieved = true;
      });
    });

    _onAuthStateChange();
  }

  void _onAuthStateChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

//endregion
}
