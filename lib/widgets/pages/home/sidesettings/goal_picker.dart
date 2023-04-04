import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../models/category/database.dart';
import '../../../../models/category/database_functions.dart';

ValueNotifier<int> goalNotifier =
    ValueNotifier<int>(WaterGoal.getdata().get(0)!.goal);

class GoalPicker extends StatefulWidget {
  const GoalPicker({super.key});

  @override
  State<GoalPicker> createState() => _GoalPickerState();
}

class _GoalPickerState extends State<GoalPicker> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Edit Your Goal',
            style: TextStyle(fontSize: 21, color: Colors.purple),
          )),
      const Align(
          alignment: Alignment.centerRight,
          child: Text('ML',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 100,
          width: 200,
          child: NumberPicker(
            value: goalNotifier.value,
            minValue: 0,
            maxValue: 15000,
            step: 1000,
            onChanged: (value) => setState(() {
              goalNotifier.value = value;
              log('${goalNotifier.value}notifier have goal');
              goalRetriever(currentValue: goalNotifier.value);
            }),
          ),
        ),
      ),
    ]);
  }
}
