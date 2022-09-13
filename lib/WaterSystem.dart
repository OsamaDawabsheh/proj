import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(Water());
}

class Water extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Water> {
  bool sw = false;
  int s = 0;
  double water = 0;
  String st = 'Automatic';
  List<String> state = ['Automatic', 'Custom'];
  bool auto = false;
  bool w = false;

  checkWaterPump() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('WaterPumpState');
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
        FirebaseDatabase.instance.ref('WaterLevel');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        water = event.snapshot.value.hashCode.toDouble();
      });
      if (water < 50) {
        w = true;
      } else {
        w = false;
      }
      print('$water');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "WaterPumpState": sw,
    });
  }

  checkMode() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('WaterMode');
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
      "WaterMode": st,
    });
  }

  @override
  void initState() {
    checkWaterPump();
    checkLevel();
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
              'Water System',
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
                      st = state[index.hashCode];
                      editMode();
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
                          'Water Pumb Is : ',
                          style: TextStyle(
                              fontSize: 20,
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
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              const SizedBox(
                height: 50,
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
                        !w
                            ? const Card(
                                color: Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pump disable , Tank is full ',
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
                                    'Pump enable : Tank not full',
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
                    'Water Level Is : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$water',
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
