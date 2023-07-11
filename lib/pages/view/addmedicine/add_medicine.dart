import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:water_tracker/models/category/database_functions.dart';
import 'package:water_tracker/pages/view/addmedicine/celender.dart';

import 'package:water_tracker/pages/view/addmedicine/time.dart';

import '../../../provider/medicine.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  _AddMedicineState() {}

  String? _selectedValue = "";
  DateTime _dateTime = DateTime.now();
  void showAlert(BuildContext context) {
    QuickAlert.show(
        context: context, type: QuickAlertType.error, title: 'Add Medicine');
  }

  final _formkey = GlobalKey<FormState>();
  final _nameditingController = TextEditingController();
  final _timeController = TextEditingController();
  final _doseeditingContoleer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 192, 187),
        title: const Text('Add Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      subtitle: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                        controller: _nameditingController,
                        maxLength: 15,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          hintText: 'medicine name....',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          subtitle: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            controller: _doseeditingContoleer,
                            maxLength: 15,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: ' add note.. ',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ListTile(
                          subtitle: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            controller: _timeController,
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: ' dose.. ',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(padding: EdgeInsets.all(12)),
                ],
              ),
              Row(
                children: const [
                  Dateselector(),
                  SizedBox(
                    width: 90,
                  ),
                  TimePicker(),
                ],
              ),
              Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          Navigator.pop(context);

                        context.read<MedcineProivder>().addmed(
                                pillControler: _timeController,
                                nameditingController: _nameditingController,
                                doseeditingContoleer: _doseeditingContoleer,
                              );
                          _doseeditingContoleer.clear();
                          _nameditingController.clear();
                          _timeController.clear();
                          showTopSnackbar(context);
                        } else {
                          showAlert(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 70, 175, 178),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'SAVE',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTopSnackbar(BuildContext context) {
    Flushbar(
      animationDuration: const Duration(milliseconds: 700),
      icon: Icon(Icons.check_circle, color: Colors.white),
      shouldIconPulse: false,
      duration: const Duration(seconds: 1),
      padding: const EdgeInsets.all(15),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(20),
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      backgroundGradient: const LinearGradient(
        colors: [Colors.blue, Colors.white],
      ),
      message: 'Success',
    ).show(context).then((value) {});
  }
}
