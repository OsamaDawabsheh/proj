import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_switch/flutter_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Irrigation());
}

class Irrigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Irrigation> {
  String st = 'Automatic';
  List<String> state = ['Automatic', 'Custom'];
  bool sw = false;
  int s = 0;
  double wet = 0;
  bool auto = false;
  bool p = false;

  checkWetness() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('WetnessLevel');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        wet = event.snapshot.value.hashCode.toDouble();
      });
      if (wet < 70) {
        p = true;
      } else {
        p = false;
      }
      print('$wet');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "SoilPumpState": sw,
    });
  }

  checkSoilPump() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('SoilPumpState');
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

  checkMode() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('SoilMode');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        st = event.snapshot.value.toString();
      });
      if (st == 'Automatic') {
        auto = false;
      } else if (st == 'Custom') {
        auto = true;
      }
      print('$st');
    });
  }

  editMode() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "SoilMode": st,
    });
  }

  @override
  void initState() {
    checkSoilPump();
    checkWetness();
    checkMode();
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
              'Irrigation System',
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
              ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(
                    minWidth: 150.0,
                    minHeight: 60.0,
                    fontSize: 20.0,
                    initialLabelIndex: 0,
                    activeBgColor: [Colors.green],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.black,
                    totalSwitches: 2,
                    labels: ['Automatic', 'Manual'],
                    onToggle: (index) {
                      setState(() {
                        st = state[index.hashCode];
                        editMode();
                      });
                      print('$st');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'soil pump is : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              const SizedBox(
                height: 30,
              ),
              !auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Pump State : ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        !p
                            ? const Card(
                                color: Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pump disable , soil is wet ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : const Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pump enable , soil is dry ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wetness Level is : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$wet',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
