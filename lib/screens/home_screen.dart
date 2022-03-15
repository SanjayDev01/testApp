// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int leftCount = 0;
  int rightCount = 0;
  List heightList = [];
  double maxHeight = 0;

  TextEditingController leftController = TextEditingController();
  TextEditingController rightController = TextEditingController();

  double radianValue = 0;

  @override
  void initState() {
    super.initState();
    List listCount = [leftCount, rightCount];
    maxHeight = heightList.fold(0, (p, c) => p + c);
    print(maxHeight);
  }

  void writeData() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime
    // Database” step with DatabaseURL
    var url =
        "https://testapp-82eb4-default-rtdb.firebaseio.com/" + "data.json";

    // (Do not remove “data.json”,keep it as it is)
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({"leftCount": leftCount, "rightCount": rightCount}),
      );

      if (response.statusCode == 200) {
        print("Success");
      } else {
        print("Error");
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(90),
                        ],
                        controller: leftController,
                        onChanged: (value) {
                          setState(() {
                            leftCount = value.length;

                            radianValue = -0.0174533 * value.length;
                            writeData();
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            leftCount = value!.length;

                            radianValue = -0.0174533 * value.length;
                            writeData();
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            leftCount = value.length;

                            radianValue = -0.0174533 * value.length;
                            writeData();
                          });
                        },
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                          labelText: 'TYPE HERE',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(90),
                        ],
                        controller: rightController,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        onChanged: (value) {
                          setState(() {
                            rightCount = value.length;

                            radianValue = 0.0174533 * value.length;
                            writeData();
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            rightCount = value!.length;

                            radianValue = 0.0174533 * value.length;
                            writeData();
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            rightCount = value.length;

                            radianValue = 0.0174533 * value.length;
                            writeData();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'TYPE HERE',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),

              // SizedBox(height: sin(0) * 200),
              SizedBox(height: maxHeight),

              AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Container(
                  color: Colors.blue,
                  height: 50,
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 70,
                          alignment: Alignment.center,
                          height: 38,
                          color: Colors.white,
                          child: Text("$leftCount",
                              style: TextStyle(fontSize: 34)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 70,
                          alignment: Alignment.center,
                          height: 38,
                          color: Colors.white,
                          child: Text("$rightCount",
                              style: TextStyle(fontSize: 34)),
                        ),
                      )
                    ],
                  ),
                ),
                transform: Matrix4.rotationZ(radianValue),
                transformAlignment: (radianValue < 0)
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                onEnd: () {
                  print(sin(radianValue) * 300);

                  if (radianValue > 0) {
                    heightList.add(sin(radianValue) * 300);
                  } else {
                    heightList.add(-sin(radianValue) * 300);
                  }
                  print(heightList);
                  maxHeight = heightList.fold(0, (p, c) => p + c);
                  setState(() {
                    radianValue = 0;
                  });
                  if (maxHeight > MediaQuery.of(context).size.height * 0.3) {
                    setState(() {
                      maxHeight = 0;
                      heightList.clear();
                      radianValue = 0;
                      leftCount = 0;
                      rightCount = 0;
                      leftController.clear();
                      rightController.clear();
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
