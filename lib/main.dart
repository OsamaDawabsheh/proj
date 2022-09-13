import 'dart:ui';
// import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'notificationservice.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'IrrigationSystem.dart';
import 'ConditionSystem.dart';
import 'FireSystem.dart';
import 'GateSystem.dart';
import 'InLightSystem.dart';
import 'MonitoringSystem.dart';
import 'OutLightSystem.dart';
import 'WaterSystem.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyApp> {
  int s = 0;
  bool st = false;

  // checkMotion() async {
  //   DatabaseReference starCountRef =
  //       FirebaseDatabase.instance.ref('MotionState');
  //   starCountRef.onValue.listen((DatabaseEvent event) {
  //     setState(() {
  //       s = event.snapshot.value.hashCode;
  //       if (s == 1237) {
  //         st = false;
  //       } else {
  //         st = true;
  //       }
  //       if (st == true) {
  //         NotificationService().showNotification(1, "title", "body", 10);
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    // checkMotion();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 15, 25),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
                height: 90,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 5, 184, 106),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: const SizedBox(
                            width: 200,
                            height: 50,
                            child: Center(
                                child: Text(
                              'Smart Home Systems',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ))),
            ListTile(
              title: const Text(
                'Irrigation System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Irrigation()));
              },
            ),
            ListTile(
              title: const Text(
                'Condition System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Condition()));
              },
            ),
            ListTile(
              title: const Text(
                'Gate System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Gate()));
              },
            ),
            ListTile(
              title: const Text(
                'Inside Light System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InLight()));
              },
            ),
            ListTile(
              title: const Text(
                'Outside Light System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OutLight()));
              },
            ),
            ListTile(
              title: const Text(
                'Monitoring System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Monitoring()));
              },
            ),
            ListTile(
              title: const Text(
                'Water System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Water()));
              },
            ),
            ListTile(
              title: const Text(
                'Fire System',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Fire()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 184, 106),
        title: const Text(
          'Smart Home',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        // leading: const Icon(
        //   Icons.menu,
        //   color: Color.fromARGB(255, 5, 15, 25),
        //   size: 30,
        // ),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Image(
            image: AssetImage('imgs/SmartHome.png'),
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Welcome ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 212, 227, 9)),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // ignore: prefer_const_constructors
          Container(
            // width: 100,
            child: const Text(
              'You can see the Information about the systems from menu icon of AppBar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 8, 212, 239)),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
