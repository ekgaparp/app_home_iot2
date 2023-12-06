import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:app_home_iot/view/tab/tab_living_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/weather.dart';

import '../tab/tab_kitchen.dart';

// enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  String key = '0d67fcc57039eb5d6f167c8beec907c9';
  late WeatherFactory ws;
  @override
  void initState() {
    ws = WeatherFactory(key, language: Language.THAI);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
                centerTitle: true,
                title: const Text('Home', style: TextStyle(fontSize: 26)),
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent),
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                automaticallyImplyLeading: false,
                expandedHeight: 180,
                pinned: true,
                toolbarHeight: 70,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.yellow.shade700,
                            Colors.redAccent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          tileMode: TileMode.repeated)),
                  child: _buildWeatherLocate(),
                ))),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRoomButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<Weather> _buildWeatherLocate() {
    return StreamBuilder<Weather>(
      stream: ws.currentWeatherByCityName('Bangkok, Thailand').asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final weather = snapshot.data;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                  margin: const EdgeInsets.only(
                      top: 110.0, left: 16.0, right: 20.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.yellow.shade700,
                            Colors.redAccent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          tileMode: TileMode.clamp)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Icon(
                              Icons.cloud,
                              color: Colors.white70,
                              size: 40,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${weather!.areaName}',
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                '${weather.weatherDescription}',
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.white70),
                              ),
                            ],
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              '${weather.temperature?.celsius?.toStringAsFixed(2)}°C',
                              style: const TextStyle(
                                  fontSize: 26.0, color: Colors.white70),
                            ),
                          )
                        ],
                      ),
                      // _buildSearchLocation()
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error getting weather data: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: SizedBox(),
          );
        }
      },
    );
  }

  // Widget _buildSearchLocation() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       AnimSearchBar(
  //         onSubmitted: (String) {
  //           print('String :$String');
  //         },
  //         onSuffixTap: () {
  //           setState(() {
  //             textController.clear();
  //           });
  //         },
  //         textController: textController,
  //         width: MediaQuery.of(context).size.width * 0.9,
  //       )
  //     ],
  //   );
  // }

  Widget _buildRoomButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Text('Rooms', style: TextStyle(fontSize: 25)),
        const SizedBox(height: 10),
        SizedBox(
            height: 203,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildButtonRoom(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: ((context) {
                        //   return const TabLivingRoom();
                        // })));
                      },
                      title: 'Living Room',
                      imagePath: 'assets/icon/sofa_icon.png'),
                  _buildButtonRoom(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const TabKitchen();
                        })));
                      },
                      title: 'Kitchen Room',
                      imagePath: 'assets/icon/sofa_icon.png'),
                  _buildButtonRoom(
                      onTap: () {},
                      title: 'BedRoom',
                      imagePath: 'assets/icon/sofa_icon.png')
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildButtonRoom(
      {String? title, void Function()? onTap, String? imagePath}) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {},
      child: SizedBox(
        // height: 200,
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  title!,
                  style: const TextStyle(fontSize: 20),
                ),
                Image.asset(
                  imagePath!,
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
