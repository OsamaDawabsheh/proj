import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Fire());
}

class Fire extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Fire> {
  bool sw = true;
  int s = 0;
  double p = 0;
  bool b = true;

  checkBuzzer() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('BuzzerState');
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

  checkLevel() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('PollutionLevel');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        p = event.snapshot.value.hashCode.toDouble();
      });
      print('$p');
      if (p > 50) {
        b = false;
      } else {
        b = true;
      }
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "BuzzerState": sw,
    });
  }

  @override
  void initState() {
    checkBuzzer();
    checkLevel();
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
              'Fire System',
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
          body: ListView(
            children: [
              const SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Buzzer State Is : ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  FlutterSwitch(
                    activeColor: Colors.green,
                    inactiveColor: Colors.red,
                    width: 125.0,
                    height: 45.0,
                    valueFontSize: 24.0,
                    toggleSize: 30.0,
                    value: sw,
                    borderRadius: 25.0,
                    padding: 8.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        sw = val;
                        editData();
                      });
                      print('the switch state is $sw');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Gas State Is : ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  b
                      ? const Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Air is Clear',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const Card(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Air not Clear',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  // ElevatedButton(
                  //     child: const Text('click me'),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     })
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Polution Level Is :  ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$p',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //     child: const Text('click me'),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     })
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          )),
    );
  }
}
