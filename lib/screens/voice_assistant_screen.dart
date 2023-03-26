import 'package:flutter/material.dart';

class VoiceAssistantScreen extends StatelessWidget {
  const VoiceAssistantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          //margin: EdgeInsets.all(11),
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Instruction',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text('Say hello to'),
            ],
          )),
    );
  }
}
