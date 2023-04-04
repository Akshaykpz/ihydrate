import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/models/category/database.dart';
import 'package:water_tracker/widgets/pages/addmedicine/celender.dart';
import 'package:water_tracker/widgets/pages/addmedicine/time.dart';

import '../../boxes/box.dart';
import '../../widgets/pages/home/homepage/water_page.dart';

waterGoalAdd() {
  final box = WaterGoal.getdata();
  final value = box.values.first.goal;
  return value;
}

adddata({
  required int texteditingcontroller,
  required final nameditingController,
}) {
  // Get the water goal from WaterGoal class and data from Boxes class
  final watergoal = WaterGoal.getdata();
  final box = Boxes.getdata();
  // Set a variable to keep track of the total water consumed
  double total = 0.0;
//list convert data month currect check
  for (var element in box.values.toList()) {
    try {
      if (element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year) {
        double value = double.parse(element.water.toString());
        total += value;
      }
    } catch (e) {
      //show message in eroor handling
      log('error occurred while parsing to double: $e');
    }
  }
//value double convert

  double totalData = texteditingcontroller.toDouble();

  if (watergoal.values.first.goal.toDouble() > total + totalData) {
    final data = WaterModel(
        date: DateTime.now(),
        water: texteditingcontroller,
        subtitle: nameditingController,
        time: DateTime.now());

    box.add(data);
    data.save();
    // Call the grap() function with the updated data and current time
    grap(Boxes.getdata(), DateTime.now());
  } else {}
}

final currentTime = DateFormat('hh:mm');
final formatTime = currentTime.format(DateTime.now()).toString();

addmed(
    {required final nameditingController,
    required final doseeditingContoleer,
    required final pillControler}) {
  final data = MedicineModel(
      dates: date,
      time: medTime ?? formatTime,
      note: nameditingController.text,
      dose: doseeditingContoleer.text,
      pill: pillControler.text);
  final box = MedicineModel.getData();
  box.add(data);
  data.save();
}

ValueNotifier<int> currentgoal = ValueNotifier(0);
goalRetriever({required final currentValue}) {
  Box<WaterGoal> goalBox = WaterGoal.getdata();
  WaterGoal myGoal = WaterGoal(goal: currentValue ?? 2000);

  goalBox.put(0, myGoal);
  myGoal.save();

  currentgoal.value = WaterGoal.getdata().get(0)!.goal;
}

progressvalues({required final progresvalues}) {
  final data = ProgressValue.getData();
  final progressdata = ProgressValue(progressvalues: progresvalues);
  data.put(0, progressdata);
  indiacatorValue.value = data.get(0)!.progressvalues;
  indiacatorValue.notifyListeners();
  log('${data.get(0)!.progressvalues} value added');

  progressdata.save();
}

ValueNotifier<double> gValue = ValueNotifier(0.0);
Future<void> grap(Box<WaterModel> box, DateTime date) async {
  double total = 0;
  final watergoal = WaterGoal.getdata();
  for (var element in box.values.toList()) {
    try {
      if (element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year) {
        double value = double.parse(element.water.toString());
        total += value;
      }
    } catch (e) {
      log('error occurred while parsing to double: $e');
      // handle the exception here, e.g. log an error or show an error message to the user
    }
  }
  // final String goal = watergoal.values.first.addgoal;
  final goal = watergoal.values.isNotEmpty
      ? watergoal.values.first.goal.toDouble()
      : 0.0;
  log("total value =$total");
  log("total goal =$goal");
  double graphValue = total / goal;
  gValue.value = graphValue;
  log(total.toString());

  progressvalues(progresvalues: gValue.value);
  gValue.notifyListeners();
  log('${gValue.toString()} gvalue');
}
