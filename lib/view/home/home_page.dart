import 'package:app_home_iot/view/tab/tab_living_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 26),
            ),
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            automaticallyImplyLeading: false,
            expandedHeight: 200,
            pinned: true,
            floating: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).primaryColor,
              ),
            ),
            //
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0))),
                    child: Container())),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                // children: List<int>.generate(100, (index) => index)
                //     .map((index) => Container(
                //           height: 40,
                //           margin: const EdgeInsets.symmetric(vertical: 10),
                //           color: Colors.grey[300],
                //         alignment: Alignment.center,
                //           child: Text('$index item'),
                //         ))
                //     .toList(),
                children: [
                  _buildWeather(),
                  _buildRoomButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeather() {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
              colors: [Colors.yellow.shade700, Colors.redAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
         const  Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Icon(
              Icons.cloud,
              color: Colors.white70,
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'New York',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Sunny',
                style: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
            ],
          )),
         const  Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              '12°',
              style: TextStyle(fontSize: 30.0, color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRoomButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Text('Rooms', style: TextStyle(fontSize: 25)),
        const SizedBox(height: 10),
        SizedBox(
            height: 203,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildButtonLivingRoom(
                    title: 'Live Room',
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: ((context) {
                      //   return const TabLivingRoom();
                      // })));
                    },
                  );
                }))
      ],
    );
  }

  Widget _buildButtonLivingRoom({String? title, void Function()? onTap}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return const TabLivingRoom();
        })));
      },
      onLongPress: () {},
      child: SizedBox(
        // height: 200,
        width: 180,
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
                Image.asset('assets/icon/sofa_icon.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
