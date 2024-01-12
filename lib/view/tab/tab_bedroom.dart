import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TabBedRoom extends StatefulWidget {
  const TabBedRoom({super.key});

  @override
  State<TabBedRoom> createState() => _TabBedRoomState();
}

class _TabBedRoomState extends State<TabBedRoom> {
  bool value = false;
  final db = FirebaseDatabase.instance.ref();

  void onUpdate() {
    setState(() {
      value = !value;
    });
  }

  writeData() async {
    db.child('LightState').set({'switch': !value});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0.0,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: value ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  onUpdate();
                  writeData();
                },
                child: Text(value ? 'On' : 'Off'))
          ],
        ));
  }
}
