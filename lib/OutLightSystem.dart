import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(OutLight());
}

class OutLight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<OutLight> {
  String st = 'Automatic';
  List<String> state = ['Automatic', 'Custom'];
  double li = 0.0;
  int lt = 0;
  bool sw = false;
  int s = 0;
  bool auto = false;
  bool motion = false;
  int m = 0;

  checkLamp() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('OutLampState');
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

  editState() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "OutLampState": sw,
    });
  }

  checkOutIntensity() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('OutLightIntensity');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        li = event.snapshot.value.hashCode.toDouble();
      });
      print('$li');
    });
  }

  checkData() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('LampTimer');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        lt = event.snapshot.value.hashCode;
      });
      print('$lt');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "LampTimer": lt,
    });
  }

  checkMode() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('OutOperationMode');
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

  checkMotion() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('MotionState');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        m = event.snapshot.value.hashCode;
      });
      if (m == 1237) {
        motion = false;
      } else {
        motion = true;
      }
      print('motion : $motion');
    });
  }

  editMode() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "OutOperationMode": st,
    });
  }

  @override
  void initState() {
    checkData();
    checkMode();
    checkOutIntensity();
    checkMotion();
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
              'Outside Light System',
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
                height: 100,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Out Light Intensity : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.sunny,
                    size: 40,
                    color: Colors.yellow,
                  ),
                  Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$li',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
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
              auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Lamp State Is : ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
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
                              editState();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Motion State Is : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  motion
                      ? Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.run_circle_sharp,
                              color: Colors.red,
                              size: 50,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'There Is Motion',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        )
                      : Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.run_circle_sharp,
                              color: Colors.green,
                              size: 50,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'No Motion',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              !auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Lamp Timer : ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.white,
                            thumbColor: Colors.yellow,
                            value: lt.toDouble(),
                            max: 10,
                            divisions: 10,
                            label: lt.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                lt = value.toInt();
                                editData();
                              });
                            },
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
              !auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Lamp Timer Value : ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$lt   Second',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Card(),
              const SizedBox(
                height: 50,
              ),
            ],
          )),
    );
  }
}
