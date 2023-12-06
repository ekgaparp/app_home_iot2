// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:web_socket_channel/io.dart';
// // import 'package:web_socket_channel/web_socket_channel.dart';

// class TabLivingRoom extends StatefulWidget {
//   const TabLivingRoom({super.key});

//   @override
//   State<TabLivingRoom> createState() => _TabLivingRoomState();
// }

// class _TabLivingRoomState extends State<TabLivingRoom> {
//   bool enabledLightStatus = true;
//   bool enabledTempStatus = false;
//   bool enabledHumdStatus = false;
//   bool statusTurnOnLight = false;

//   //Web-Socket-Chanel
//   bool ledStatus = false;
//   bool connected = false;
//   // IOWebSocketChannel channel = IOWebSocketChannel;

//   final _channel =
//       IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.1:8080'));

//   @override
//   void initState() {
//     // Future.delayed(Duration.zero, () {
//     //   return connectChanel(); //connect to WebSocket wth NodeMCU
//     // });

//     super.initState();
//   }

//   void connectChanel() {
//     try {
//       _channel.stream.listen((message) {
//         print('has.event :$message');
//         setState(() {
//           if (message == "connected") {
//             connected = true;
//           } else if (message == "poweron:success") {
//             ledStatus = true;
//           } else if (message == "poweroff:success") {
//             ledStatus = false;
//           }
//         });
//       }, onDone: () {
//         //if WebSocket is disconnected
//         print("has.Web socket is closed");
//         setState(() {
//           connected = false;
//         });
//       }, onError: (e) {
//         print("has.error :$e");
//       });
//     } catch (e) {
//       print('has.Error :$e');
//     }
//   }

//   sendCmd(String cmd) {
//     if (connected) {
//       print('has.sendCmd : Connected');
//       if (ledStatus == false && cmd != "poweron" && cmd != "poweroff") {
//         // _channel.sink.add(cmd);
//         print("has.Send the valid command");
//       } else {
//         print('has.sendCmd ${cmd.toString()}');
//         _channel.sink.add(cmd); //sending Command to NodeMCU
//       }
//     } else {
//       connectChanel();
//       print('has.Web Socket is not connected');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         systemOverlayStyle:
//             const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
//         toolbarHeight: 90,
//         shape: const ContinuousRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(40),
//                 bottomRight: Radius.circular(40))),
//         centerTitle: true,
//         title: const Text('Live Room', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//       ),
//       backgroundColor: Colors.white,
//       body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildButtonLightInLivingRoom(),
//             _buildButtonTempInLivingRoom(),
//             _buildButtonHumdtInLivingRoom()
//           ],
//         ),
//         enabledLightStatus ? _buildBodyLightInRoom() : Container(),
//         enabledTempStatus ? _buildTempBody() : Container(),
//         enabledHumdStatus ? _buildHumdBody() : Container()
//       ]),
//     );
//   }

//   Widget _buildButtonLightInLivingRoom() {
//     return InkWell(
//       onTap: () {
//         if (enabledLightStatus == true) {
//           setState(() {
//             enabledLightStatus = true;
//           });
//         } else {
//           setState(() {
//             enabledLightStatus = true;
//             enabledTempStatus = false;
//             enabledHumdStatus = false;
//           });
//         }
//       },
//       child: SizedBox(
//         height: 120,
//         width: 120,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(15)),
//                 gradient: enabledLightStatus
//                     ? LinearGradient(
//                         colors: [Colors.teal.shade500, Colors.teal.shade200],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         tileMode: TileMode.clamp)
//                     : const LinearGradient(
//                         colors: [Colors.white, Colors.white],
//                       )),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(height: 15),
//                 Image.asset('assets/image/lamp.png',
//                     height: 50,
//                     width: 50,
//                     color: enabledLightStatus ? Colors.white : Colors.black),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Lights',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color:
//                           (enabledLightStatus ? Colors.white : Colors.black)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonTempInLivingRoom() {
//     return InkWell(
//       onTap: () {
//         if (enabledTempStatus == true) {
//           setState(() {
//             enabledTempStatus = true;
//           });
//         } else {
//           setState(() {
//             enabledTempStatus = true;
//             enabledLightStatus = false;
//             enabledHumdStatus = false;
//           });
//         }
//       },
//       onLongPress: () {},
//       child: SizedBox(
//         height: 120,
//         width: 150,
//         child: Card(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(15)),
//                 gradient: enabledTempStatus
//                     ? LinearGradient(
//                         colors: [Colors.teal.shade500, Colors.teal.shade200],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         tileMode: TileMode.clamp)
//                     : const LinearGradient(
//                         colors: [Colors.white, Colors.white],
//                       )),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(height: 15),
//                 Image.asset(
//                   'assets/image/thermometer.png',
//                   height: 50,
//                   width: 50,
//                   color: enabledTempStatus ? Colors.white : Colors.black,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Temperature',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: (enabledTempStatus ? Colors.white : Colors.black)),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonHumdtInLivingRoom() {
//     return InkWell(
//       focusColor: Colors.amber,
//       onTap: () {
//         if (enabledHumdStatus == true) {
//           setState(() {
//             enabledTempStatus = false;
//             enabledLightStatus = false;
//           });
//         } else {
//           setState(() {
//             enabledTempStatus = false;
//             enabledLightStatus = false;
//             enabledHumdStatus = true;
//           });
//         }
//       },
//       onLongPress: () {},
//       child: SizedBox(
//         height: 120,
//         width: 120,
//         child: Card(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(15)),
//                 gradient: enabledHumdStatus
//                     ? LinearGradient(
//                         colors: [Colors.teal.shade500, Colors.teal.shade200],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         tileMode: TileMode.clamp)
//                     : const LinearGradient(
//                         colors: [Colors.white, Colors.white],
//                       )),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(height: 15),
//                 Image.asset('assets/image/humidity.png',
//                     height: 50,
//                     width: 50,
//                     color: (enabledHumdStatus ? Colors.white : Colors.black)),
//                 const SizedBox(height: 10),
//                 Text(
//                   'humidity',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: (enabledHumdStatus ? Colors.white : Colors.black)),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBodyLightInRoom() {
//     return Column(
//       children: <Widget>[
//         const SizedBox(height: 30),
//         const Text('ปริมาณเเสงในห้อง'),
//         const SizedBox(height: 60),
//         Container(
//             padding: const EdgeInsets.only(bottom: 50),
//             child: statusTurnOnLight
//                 ? _buildStatusLamp(imagePath: 'assets/image/lamp_on.png')
//                 : _buildStatusLamp(imagePath: 'assets/image/lamp_off.png')),
//         FlutterSwitch(
//             activeColor: Colors.teal,
//             value: statusTurnOnLight,
//             onToggle: (val) async {
//               if (val) {
//                 sendCmd("poweron");
//                 ledStatus = true;
//                 // turnOnLed;
//               } else {
//                 sendCmd("poweroff");
//                 ledStatus = false;
//                 // turnOffLed;
//               }

//               setState(() {
//                 statusTurnOnLight = val;
//               });
//               // print('val :$val');
//             }),
//         const SizedBox(height: 15),
//         Container(
//           alignment: Alignment.center,
//           child: Text(
//             "สถานะ : ${(statusTurnOnLight) ? "เปิด" : "ปิด"}",
//             style: const TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusLamp({required String imagePath}) {
//     return Container(
//         padding: const EdgeInsets.only(top: 20, bottom: 20),
//         height: 200,
//         child: Image.asset(imagePath));
//   }

//   Widget _buildTempBody() {
//     return Column(
//       children: <Widget>[
//         const SizedBox(height: 20),
//         const Text('อุณหภูมิในห้องตอนนี้'),
//         const SizedBox(height: 20),
//         const Icon(Icons.wb_sunny_outlined),
//         Container(
//           height: 200,
//         ),
//       ],
//     );
//   }

//   Widget _buildHumdBody() {
//     return Column(
//       children: <Widget>[
//         const SizedBox(height: 20),
//         const Text('ความชื้นในห้องตอนนี้'),
//         const SizedBox(height: 20),
//         const Icon(Icons.wb_sunny_outlined),
//         Container(
//           height: 200,
//         ),
//       ],
//     );
//   }
// }
