import 'package:flutter/material.dart';
import 'package:my_guard/screens/emergency_contacts_screen.dart';
import 'package:my_guard/screens/route_tracking_screen.dart';
import 'package:my_guard/screens/voice_assistant_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //region: Overridden Functions
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  //endregion

  //region: Widgets
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Home',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _onLogOutClick();
            },
            tooltip: 'Logout',
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
              semanticLabel: 'Logout',
            ))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildItemWidget(
              context,
              Icons.record_voice_over_outlined,
              'Voice Assistant',
              const VoiceAssistantScreen(),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildItemWidget(
              context,
              Icons.route_outlined,
              'Route Tracking',
              const RouteTrackingScreen(),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildItemWidget(
              context,
              Icons.call_outlined,
              'Emergency Contact',
              const EmergencyContactsScreen(),
            ),
          ],
        ));
  }

  Widget _buildItemWidget(
      BuildContext context, IconData iconData, String text, Widget screen) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          _onItemClick(context, screen);
        },
        child: Card(
          child: Row(
            children: [
              //Icon
              Container(
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    size: 64,
                  )),
              //Margin
              const SizedBox(
                width: 24,
              ),
              //Text
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//endregion

//region: Private Functions
  void _onLogOutClick() {
    //todo add code here
  }

  void _onItemClick(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return screen;
    }));
  }
//endregion
}
