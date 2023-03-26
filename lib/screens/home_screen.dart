import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Home',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              //todo Implement logout functionality
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

  Widget _buildBody() {
    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildItemWidget(
                Icons.record_voice_over_outlined, 'Voice Assistant'),
            const SizedBox(
              height: 16,
            ),
            _buildItemWidget(Icons.route_outlined, 'Route Tracking'),
            const SizedBox(
              height: 16,
            ),
            _buildItemWidget(Icons.call_outlined, 'Emergency Contact'),
          ],
        ));
  }

  Widget _buildItemWidget(IconData iconData, String text) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          //todo add click functionality
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
}
