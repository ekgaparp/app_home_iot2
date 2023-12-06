import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TabKitchen extends StatefulWidget {
  const TabKitchen({super.key});

  @override
  State<TabKitchen> createState() => _TabKitchenState();
}

class _TabKitchenState extends State<TabKitchen> {
  String status = '';
  String url = 'http://192.168.1.200:80/';
  var response;

  @override
  void initState() {
    getInitLedState();
    super.initState();
  }

  getInitLedState() async {
    try {
      response =
          await http.get(Uri.parse(url), headers: {"Accept": "plain/text"});
      setState(() {
        status = 'On';
      });
      print('status response :$response');
    } catch (e) {
      print(e);
      if (this.mounted) {
        setState(() {
          status = 'Not Connected';
        });
        print('status :$status');
      }
    }
  }

  toggleLed() async {
    try {
      var urlLed = '${url}led';
      print('status urlLed :$urlLed');
      response =
          await http.get(Uri.parse(urlLed), headers: {"Accept": "plain/text"});
      setState(() {
        status = response.body;
        print(response.body);
        print('status response :${response.body}');
      });
    } catch (e) {
      print(e);
      displaySnackBar(context, 'Module Not Connected');
    }
  }

  turnOnLed() async {
    try {
      var urlLedOn = '${url}led/on';
      print('status urlLedOn :$urlLedOn');
      print(response.body);
      response = await http
          .get(Uri.parse(urlLedOn), headers: {"Accept": "plain/text"});
      setState(() {
        status = response.body;
        print('status response :${response.body}');
      });
    } catch (e) {
      print(e);
      displaySnackBar(context, 'Module Not Connected');
    }
  }

  turnOffLed() async {
    try {
      var urlLedOff = '${url}led/off';
      print('status urlLedOff :$urlLedOff');
      response = await http
          .get(Uri.parse(urlLedOff), headers: {"Accept": "plain/text"});
      setState(() {
        status = response.body;
        print(response.body);
      });
    } catch (e) {
      print(e);
      displaySnackBar(context, 'Module Not Connected');
    }
  }

  displaySnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            )),
        title: const Text('Web Connect'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: toggleLed,
          child: const Text('Toggle LED'),
        ),
        ElevatedButton(
          onPressed: turnOnLed,
          child: const Text('Turn LED On'),
        ),
        ElevatedButton(
          onPressed: turnOffLed,
          child: const Text('Turn LED Off'),
        )
      ]),
    );
  }
}
