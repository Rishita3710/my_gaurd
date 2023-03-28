import 'package:flutter/material.dart';

class VoiceAssistantInstructionScreen extends StatelessWidget {
  const VoiceAssistantInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
        centerTitle: true,
        title: const Text(
          "Instruction",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        width: double.maxFinite,
        height: double.maxFinite,
        child: const Text(
          '\nSay hello to your virtual assistant Aka Molly\n\nHello sir/mam how are yoy? Hope you are having a great day. I am your assistant who will guide you and help you throughout. But first you need to setup something that will let me know when you need my help.\n\nSteps to follow :-\n\n-> Enter the command in the first section that let me know that you are calling me for help.\n\n-> Enter the word that will command me to stop in the second in case you called me by mistake.\n\n -> Just save everything and you are ready to go.\n\n\nDon not forget to call me when you need help',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
