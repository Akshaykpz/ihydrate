import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../boxes/box.dart';
import '../../../../models/category/database.dart';
import '../../../../models/category/database_functions.dart';

void showAlert(BuildContext context) {
  QuickAlert.show(
      context: context, onConfirmBtnTap: () {}, type: QuickAlertType.confirm);
}

Future<void> delete(WaterModel waterModel) async {
  await waterModel.delete();
  ProgressValue.getData();
  grap(Boxes.getdata(), DateTime.now());
}

showAlertmed(BuildContext context, index, data) {
  QuickAlert.show(
      context: context,
      onConfirmBtnTap: () {
        deletemedcine(data[index]);
      },
      type: QuickAlertType.confirm);
}

Future<void> deletemedcine(MedicineModel medicineModel) async {
  
  await medicineModel.delete();
}

Future<void> deletem(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Dialog Title'),
        content: const Text('Dialog content goes here.'),
        actions: [
          TextButton(
            onPressed: () {
              // Do something when the user presses this button
              Navigator.of(context).pop();
            },
            child: const Text('Button'),
          ),
        ],
      );
    },
  );
}
