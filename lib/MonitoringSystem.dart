import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Monitoring());
}

class Monitoring extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Monitoring> {
  bool sw = true;
  int s = 0;
  String url = "";

  _launchUrl() async {
    if (await canLaunch("http://$url")) {
      await launch("http://$url");
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(Uri.parse("http://$url"))) {
  //     throw 'Could not launch $url';
  //   }
  // }

  checkIP() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Camera');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        url = event.snapshot.value.toString();
      });
    });
  }

  checkMonitoring() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('MonitoringState');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        s = event.snapshot.value.hashCode;
        //1237 equal to fasle and 1231 equal to true
      });
      if (s == 1237) {
        sw = false;
      } else {
        sw = true;
      }
      print('$sw');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "MonitoringState": sw,
    });
  }

  @override
  void initState() {
    checkMonitoring();
    checkIP();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 5, 15, 25),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 5, 184, 106),
            title: const Text(
              'Monitoring System',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body:
              // child: Image(image: AssetImage('imgs/os.png')),
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      fixedSize: const Size(200, 50),
                    ),
                    onPressed: _launchUrl,
                    child: const Text(
                      'Start Monitoring',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
