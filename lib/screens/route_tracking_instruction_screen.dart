import 'package:flutter/material.dart';

class RouteTrackingInstructionScreen extends StatelessWidget {
  const RouteTrackingInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
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
      child: const Text('\nIt is just a guide that will make sure that you never get stuck with anything. Let me help you to understand route tracking will work.\n\n\n\n -> First enter the destination where you wants to go.\n\n-> Enter the location where you are or you can update it to your location.\n\n -> After doing that you wil see the elimination time that will be needed to cover the distance.\n\n\n Enjoy the ride and do not forget to set up your voice assistant. Ride safe stay save. ',
      style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    )
    );
  }
}
