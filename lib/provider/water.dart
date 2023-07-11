import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../boxes/box.dart';
import '../models/category/database.dart';
import '../pages/view/addmedicine/celender.dart';
import '../pages/view/home/homepage/water_page.dart';

int waterValue = 0;

class WaterProivder extends ChangeNotifier {
  final _Waterdata = Boxes.getdata();
  get Waterdata => _Waterdata;

  int value = 0;

  setWaterNumberPickerValue(int value) {
    waterValue = value;
    notifyListeners();
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
      notifyListeners();
      // Call the grap() function with the updated data and current time
      grap(Boxes.getdata(), DateTime.now());
    } else {
      print('itsdone');
    }
  }

  goalRetriever({required final currentValue}) {
    Box<WaterGoal> goalBox = WaterGoal.getdata();
    WaterGoal myGoal = WaterGoal(goal: currentValue ?? 2000);

    goalBox.put(0, myGoal);
    myGoal.save();

    currentgoal.value = WaterGoal.getdata().get(0)!.goal;
  }

  ValueNotifier<int> currentgoal = ValueNotifier(0);

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

  double getIndicatorValue() {
    final box = ProgressValue.getData();
    double indicatorValue = box.get(0)?.progressvalues ?? 0;
    // notifyListeners();
    return indicatorValue;
  }

  int displayGoal() {
    int value = WaterGoal.getdata().get(0)?.goal ?? 0;
    return value;
  }
}
