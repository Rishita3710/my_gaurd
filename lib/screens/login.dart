import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black,
          child: Column(
            children: [
              //Image widget
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/image/womenlogin.png',
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  width: 310,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 39,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                        decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.person,
                              size: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  fillColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                        decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(children: const <Widget>[
                          Icon(
                            Icons.call,
                            size: 40,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Mobile number',
                                fillColor: Colors.grey,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('Submit',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 25)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
