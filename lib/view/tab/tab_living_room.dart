import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TabLivingRoom extends StatefulWidget {
  const TabLivingRoom({super.key});

  @override
  State<TabLivingRoom> createState() => _TabLivingRoomState();
}

class _TabLivingRoomState extends State<TabLivingRoom> {
  bool enabledLigthStatus = true;
  bool enabledTempStatus = false;
  bool enabledhumdStatus = false;
  bool statusTurnOnLight = false;

  //Web-Socket-Chanel
  bool ledStatus = false;
  bool connected = false;
  // IOWebSocketChannel channel = IOWebSocketChannel;

  final _channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.1:8080'));

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      return connectChanel(); //connect to WebSocket wth NodeMCU
    });
    super.initState();
  }

  void connectChanel() {
    try {
      _channel.stream.listen((mesage) {
        print('has.event :$mesage');
        setState(() {
          if (mesage == "connected") {
            connected = true;
          } else if (mesage == "poweron:success") {
            ledStatus = true;
          } else if (mesage == "poweroff:success") {
            ledStatus = false;
          }
        });
      }, onDone: () {
        //if WebSocket is disconnected
        print("has.Web socket is closed");
        setState(() {
          connected = false;
        });
      }, onError: (e) {
        print("has.error :$e");
      });
    } catch (e) {
      print('has.Error :$e');
    }
  }

  sendCmd(String cmd) {
    if (connected) {
      print('has.sendCmd : Connected');
      if (ledStatus == false && cmd != "poweron" && cmd != "poweroff") {
        // _channel.sink.add(cmd);
        print("has.Send the valid command");
      } else {
        print('has.sendCmd ${cmd.toString()}');
        _channel.sink.add(cmd); //sending Command to NodeMCU
      }
    } else {
      connectChanel();
      print('has.Web Socket is not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        toolbarHeight: 90,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        centerTitle: true,
        title: const Text('Live Room', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(height: 20),
        Row(
          children: [
            _buildButtonLightInLivingRoom(),
            _buildButtonTempInLivingRoom(),
            _buildButtonHumdtInLivingRoom()
          ],
        ),
        enabledLigthStatus ? _buildBodyLightInRoom() : Container(),
        enabledTempStatus ? _buildTempBody() : Container(),
        enabledhumdStatus ? _buildHumdBody() : Container()
      ]),
    );
  }

  Widget _buildButtonLightInLivingRoom() {
    return InkWell(
      onTap: () {
        if (enabledLigthStatus == true) {
          setState(() {
            enabledLigthStatus = true;
          });
        } else {
          setState(() {
            enabledLigthStatus = true;
            enabledTempStatus = false;
            enabledhumdStatus = false;
          });
        }
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: enabledLigthStatus
                    ? LinearGradient(
                        colors: [Colors.teal.shade500, Colors.teal.shade200],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.clamp)
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      )),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 5),
                Text(
                  'Lights',
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          (enabledLigthStatus ? Colors.white : Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonTempInLivingRoom() {
    return InkWell(
      onTap: () {
        if (enabledTempStatus == true) {
          setState(() {
            enabledTempStatus = true;
          });
        } else {
          setState(() {
            enabledTempStatus = true;
            enabledLigthStatus = false;
            enabledhumdStatus = false;
          });
        }
      },
      onLongPress: () {},
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: enabledTempStatus
                    ? LinearGradient(
                        colors: [Colors.teal.shade500, Colors.teal.shade200],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.clamp)
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      )),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 5),
                Text(
                  'Temperature',
                  style: TextStyle(
                      fontSize: 19,
                      color: (enabledTempStatus ? Colors.white : Colors.black)),
                ),
                // Image.asset(
                //   'assets/icon/sofa_icon.png',
                //   height: 70,
                //   width: 70,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonHumdtInLivingRoom() {
    return InkWell(
      focusColor: Colors.amber,
      onTap: () {
        if (enabledhumdStatus == true) {
          setState(() {
            enabledTempStatus = false;
            enabledLigthStatus = false;
          });
        } else {
          setState(() {
            enabledTempStatus = false;
            enabledLigthStatus = false;
            enabledhumdStatus = true;
          });
        }
      },
      onLongPress: () {},
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: enabledhumdStatus
                    ? LinearGradient(
                        colors: [Colors.teal.shade500, Colors.teal.shade200],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.clamp)
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      )),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 5),
                Text(
                  'humidity',
                  style: TextStyle(
                      fontSize: 20,
                      color: (enabledhumdStatus ? Colors.white : Colors.black)),
                ),
                // Image.asset(
                //   'assets/icon/sofa_icon.png',
                //   height: 70,
                //   width: 70,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyLightInRoom() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        const Text('ปริมาณเเสงในห้อง'),
        const SizedBox(height: 20),
        const Icon(Icons.wb_sunny_outlined),
        Container(
          height: 200,
        ),
        FlutterSwitch(
            activeColor: Colors.teal,
            value: statusTurnOnLight,
            onToggle: (val) async {
              if (val) {
                sendCmd("poweron");
                ledStatus = true;
                // turnOnLed;
              } else {
                sendCmd("poweroff");
                ledStatus = false;
                // turnOffLed;
              }

              setState(() {
                statusTurnOnLight = val;
              });

              print('val :$val');
            }),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          child: Text(
            "สถานะ : ${(statusTurnOnLight) ? "เปิด" : "ปิด"}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildTempBody() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        const Text('อุณหภูมิในห้องตอนนี้'),
        const SizedBox(height: 20),
        const Icon(Icons.wb_sunny_outlined),
        Container(
          height: 200,
        ),
      ],
    );
  }

  Widget _buildHumdBody() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        const Text('ความชื้นในห้องตอนนี้'),
        const SizedBox(height: 20),
        const Icon(Icons.wb_sunny_outlined),
        Container(
          height: 200,
        ),
      ],
    );
  }
}
