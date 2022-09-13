import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(Gate());
}

class Gate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Gate> {
  String state = 'Opened';
  bool opened = false;
  String gate = 'open';
  String st = 'Automatic';
  List<String> mode = ['Automatic', 'Custom'];
  bool auto = false;
  bool motion = false;
  int s = 0;

  checkMotion() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('GateMotion');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        s = event.snapshot.value.hashCode;
        //1237 equal to fasle and 1231 equal to true
      });
      if (s == 1237) {
        motion = false;
      } else {
        motion = true;
      }
      print('$motion');
    });
  }

  checkMode() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('GateMode');
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
      "GateMode": st,
    });
  }

  checkGate() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('GateState');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        state = event.snapshot.value.toString();
        if (state == 'Opened') {
          opened = true;
        } else if (state == 'Closed') {
          opened = false;
        }
      });
      print('$state');
    });
  }

  editGate() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "Gate": gate,
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "GateState": state,
    });
  }

  @override
  void initState() {
    checkGate();
    checkMode();
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
            'Gate System',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
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
                      st = mode[index.hashCode];
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
                const Text('Gate State Is : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                opened
                    ? const Card(
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Opend',
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
                            'Closed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            auto
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            fixedSize: Size(100, 50),
                          ),
                          child: const Text(
                            'Open',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            gate = 'Open';
                            setState(() {
                              editGate();
                            });
                            print(gate);
                          }),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            fixedSize: Size(100, 50),
                          ),
                          child: const Text('Close',
                              style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            gate = 'Close';
                            setState(() {
                              editGate();
                            });
                            print(gate);
                          }),
                    ],
                  )
                : const SizedBox(
                    height: 50,
                  ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
