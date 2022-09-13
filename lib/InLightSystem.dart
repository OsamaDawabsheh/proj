import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(InLight());
}

class InLight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<InLight> {
  String st = 'Automatic';
  List<String> state = ['Automatic', 'Custom'];
  double oli = 0.0;
  double ili = 0.0;
  int l = 0;
  bool auto = false;
  bool led1 = false;
  bool led2 = false;
  bool led3 = false;
  bool led4 = false;

  checkOutIntensity() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('OutLightIntensity');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        oli = event.snapshot.value.hashCode.toDouble();
      });
      print('$oli');
    });
  }

  checkInIntensity() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('InLightIntensity');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        ili = event.snapshot.value.hashCode.toDouble();
      });
      if (st == "Automatic") {
        if (ili >= 0 && ili <= 20) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        } else if (ili > 20 && ili <= 40) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (ili > 40 && ili <= 60) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (ili > 60 && ili <= 80) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (ili > 80 && ili <= 100) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        }
      } else if (st == "Custom") {
        if (l == 0) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (l > 0 && l <= 20) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (l > 20 && l <= 50) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (l > 50 && l <= 80) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (l > 80 && l <= 100) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        }
      }
      print('$ili');
    });
  }

  checkData() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('InLambValue');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        l = event.snapshot.value.hashCode;
      });
      if (st == "Automatic") {
        if (ili >= 0 && ili <= 20) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        } else if (ili > 20 && ili <= 40) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (ili > 40 && ili <= 60) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (ili > 60 && ili <= 80) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (ili > 80 && ili <= 100) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        }
      } else if (st == "Custom") {
        if (l == 0) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (l > 0 && l <= 20) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (l > 20 && l <= 50) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (l > 50 && l <= 80) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (l > 80 && l <= 100) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        }
      }
      print('$l');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "InLambValue": l,
    });
  }

  checkMode() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('InOperationMode');
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
      print(auto);
    });
  }

  editMode() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "InOperationMode": st,
    });
    if (st == 'Automatic') {
      auto = false;
    } else if (st == 'Custom') {
      auto = true;
    }
    if (st == "Automatic") {
      if (ili >= 0 && ili <= 20) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = true;
      } else if (ili > 20 && ili <= 40) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = false;
      } else if (ili > 40 && ili <= 60) {
        led1 = true;
        led2 = true;
        led3 = false;
        led4 = false;
      } else if (ili > 60 && ili <= 80) {
        led1 = true;
        led2 = false;
        led3 = false;
        led4 = false;
      } else if (ili > 80 && ili <= 100) {
        led1 = false;
        led2 = false;
        led3 = false;
        led4 = false;
      }
    } else if (st == "Custom") {
      if (l == 0) {
        led1 = false;
        led2 = false;
        led3 = false;
        led4 = false;
      } else if (l > 0 && l <= 20) {
        led1 = true;
        led2 = false;
        led3 = false;
        led4 = false;
      } else if (l > 20 && l <= 50) {
        led1 = true;
        led2 = true;
        led3 = false;
        led4 = false;
      } else if (l > 50 && l <= 80) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = false;
      } else if (l > 80 && l <= 100) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = true;
      }
    }
    print(auto);
  }

  @override
  void initState() {
    checkData();
    checkInIntensity();
    checkMode();
    checkOutIntensity();
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
              'Inside Light System',
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
                    'Indoor Light Intensity Is : ',
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
                        '$ili',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
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
                    'Lamp State Is : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  led1
                      ? (const Icon(
                          Icons.lightbulb_rounded,
                          color: Colors.white,
                          size: 30,
                        ))
                      : (const Icon(
                          Icons.lightbulb_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
                  led2
                      ? const Icon(
                          Icons.lightbulb_rounded,
                          color: Colors.white,
                          size: 30,
                        )
                      : const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                  led3
                      ? const Icon(
                          Icons.lightbulb_rounded,
                          color: Colors.white,
                          size: 30,
                        )
                      : (const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                          size: 30,
                        )),
                  led4
                      ? (const Icon(
                          Icons.lightbulb_rounded,
                          color: Colors.white,
                          size: 30,
                        ))
                      : (const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                          size: 30,
                        ))
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
              auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          '0',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.white,
                            thumbColor: Colors.yellow,
                            value: l.toDouble(),
                            max: 100,
                            divisions: 100,
                            label: l.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                editData();
                                l = value.toInt();
                              });
                            },
                          ),
                        ),
                        const Text(
                          '100 ',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
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
