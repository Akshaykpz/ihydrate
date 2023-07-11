import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:water_tracker/boxes/box.dart';
import 'package:water_tracker/models/category/database.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/pages/view/addwater/add_water.dart';

import 'package:water_tracker/pages/view/home/homepage/water_list.dart';
import 'package:water_tracker/pages/view/home/sidesettings/goal_picker.dart';

import '../../../../models/category/database_functions.dart';
import '../../../../provider/water.dart';

ValueNotifier<double> indiacatorValue = ValueNotifier<double>(0);

class MyFRist extends StatefulWidget {
  const MyFRist({super.key});

  @override
  State<MyFRist> createState() => _MyFRistState();
}

class _MyFRistState extends State<MyFRist> {
  @override
  void initState() {
    final gg = WaterGoal.getdata();
    WaterProivder().currentgoal.value = gg.values.first.goal;
    WidgetsFlutterBinding.ensureInitialized();
   WaterProivder(). grap(Boxes.getdata(), DateTime.now());
    Boxes.getdata();
    WaterGoal.getdata();
    ProgressValue.getData();
    context.read<WaterProivder>().currentgoal;
    goalNotifier.notifyListeners();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime _selectdata = DateTime.now();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(' kk:mm').format(now);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 250, 250),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            // ignore: deprecated_member_use
            // TyperAnimatedTextKit(
            //   text: const [
            //     'Water is the Best Natural Remedy.Drink Your Way to Better Health.'
            //   ],
            //   textStyle:
            //       const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //   speed: const Duration(milliseconds: 130),
            // ),

            ValueListenableBuilder(
              valueListenable: indiacatorValue,
              builder: (context, value, _) {
                if (value > 0.99) {
                  return Column(
                      // height: 300,
                      // width: 150,
                      children: [
                        const Text('CONGRATULATIONS  ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 180,
                          width: 350,
                          child: Image.asset(
                              'lib/assets/images/output-onlinegiftools (2).gif'),
                        ),
                      ]);
                  //  Container(
                  //     // padding: EdgeInsets.all(17),
                  //     // color: Colors.amber,
                  //     // height: 60,
                  //     // width: 200,
                  //     child: Stack(
                  //       children: const [
                  //         Align(
                  //             alignment: Alignment.topCenter,
                  //             child: Text('congratulations',
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.bold))),
                  //         Align(
                  //             alignment: Alignment.topRight,
                  //             child: Icon(Icons.check_circle)),
                  //         Align(
                  //             alignment: Alignment.center,
                  //             child: Text('complete your Goals',
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.bold))),
                  //       ],
                  //     ));
                } else {
                  return CircularPercentIndicator(
                    radius: 125,
                    animation: true,
                    animationDuration: 1000,
                    lineWidth: 20,
                    percent: value,
                    progressColor: const Color.fromARGB(255, 74, 185, 213),
                    backgroundColor: const Color.fromARGB(255, 167, 153, 153),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'YOUR GOAL ',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                        // const SizedBox(
                        //     width: 130,
                        //     child: Divider(
                        //       thickness: 1,
                        //     )),
                       Text(
                            '${WaterProivder().displayGoal().toString()}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                      ],
                    ),
                  );
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Today Records',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: WaterList(),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AddWaterData())));
                },
                backgroundColor: const Color.fromARGB(255, 56, 176, 166),
                // label: const Text('Add'),
                child: const Icon(Icons.add),
              ),
            ),
          ])),
    );
  }
}
