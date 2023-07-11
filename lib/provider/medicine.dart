import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/category/database.dart';
import '../models/category/database_functions.dart';
import '../pages/view/addmedicine/celender.dart';
import '../pages/view/addmedicine/time.dart';

final currentTime = DateFormat('hh:mm');
final formatTime = currentTime.format(DateTime.now()).toString();

class MedcineProivder extends ChangeNotifier {
  final meddatas = MedicineModel.getData();
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
    notifyListeners();
  }
}
