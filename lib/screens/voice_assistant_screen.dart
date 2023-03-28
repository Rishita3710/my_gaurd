import 'package:flutter/material.dart';
import 'package:my_guard/screens/voice_assistant_instruction_screen.dart';

class VoiceAssistantScreen extends StatelessWidget {
  const VoiceAssistantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.chevron_left, color: Colors.black,)),
        centerTitle: true,
        title: const Text(
          'Voice Assistant',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return VoiceAssistantInstructionScreen();
                }));
              },
              tooltip: 'Info',
              icon: const Icon(
                Icons.info_outline,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
