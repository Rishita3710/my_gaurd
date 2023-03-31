import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:my_guard/helpers/toast_helper.dart';
import 'package:my_guard/models/emergency_contact.dart';
import 'package:my_guard/networking/contact_service.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  //Flat to maintain data loading status. True by default.
  late bool _isDataLoading;

  late List<EmergencyContact> _dataList;

  //region: Overridden Functions
  @override
  void initState() {
    super.initState();
    _initScreenResources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectContact();
        },
        child: const Icon(Icons.add_circle_outline_outlined),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  //endregion

  //region: Widgets
  PreferredSizeWidget _buildAppbar() {
    return AppBar(
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
        "Emergency Contacts",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    if (_isDataLoading) {
      return const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      );
    }

    if (_dataList.isEmpty) {
      return const Center(
        child: Text('Click on + to add emergency contacts.'),
      );
    }

    return ListView.separated(
        itemCount: _dataList.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(_dataList.elementAt(index).name.substring(0, 1)),
            ),
            title: Text(_dataList.elementAt(index).name),
            trailing: IconButton(
              onPressed: () {
                _showDeleteContactDialog(context, index);
              },
              icon: const Icon(Icons.delete_outline_outlined),
            ),
          );
        });
  }

  Future<dynamic> _showDeleteContactDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove'),
            content:
                const Text('Are you sure you want to remove this contact ?'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Remove'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _removeContact(index);
                },
              ),
            ],
          );
        });
  }

//endregion

  //region: Private Functions
  void _initScreenResources() {
    _isDataLoading = true;
    _dataList = <EmergencyContact>[];
    _getContactsData();
  }

  Future<void> _getContactsData() async {
    try {
      _dataList.clear();
      DataSnapshot dataSnapshot = await ContactService()
          .getEmergencyContacts(FirebaseAuth.instance.currentUser!.uid);
      if (dataSnapshot.exists) {
        dynamic data = dataSnapshot.value ?? {};
        data.forEach((key, value) {
          debugPrint('_getContactsData key: $key');
          debugPrint('_getContactsData value: $value');
          EmergencyContact emergencyContact = EmergencyContact.fromJson(
              Map<String, dynamic>.from(value as Map<Object?, Object?>));
          _dataList.add(emergencyContact);
        });
      }
    } catch (e) {
      debugPrint('_getContactsData: $e');
    }

    setState(() {
      _isDataLoading = false;
    });
  }

  Future<void> _selectContact() async {
    try {
      if (_dataList.length == 3) {
        ToastHelper.showLongToast('You can not add more than 3 contacts.');
        return;
      }

      //Get contact
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String phone = contact.phoneNumber!.number!.replaceAll(' ', '');
      String name = contact.fullName!;
      Map<String, dynamic> data = <String, dynamic>{
        'phone': phone,
        'name': name,
        'uid': uid,
      };

      //Save data in DB
      await ContactService().saveEmergencyContact(uid, phone, data);

      //Load data again
      _getContactsData();
    } catch (e) {
      debugPrint('_selectContact: $e');
    }
  }

  Future<void> _removeContact(int index) async {
    try {
      await ContactService().deleteEmergencyContact(
          FirebaseAuth.instance.currentUser!.uid,
          _dataList.elementAt(index).phone);
      setState(() {
        _dataList.removeAt(index);
      });
    } catch (e) {
      debugPrint('_removeContact: $e');
    }
  }

//endregion
}
