import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:water_tracker/models/category/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_tracker/widgets/pages/addmedicine/add_medicine.dart';

import 'package:water_tracker/widgets/pages/home/homepage/delete_data.dart';

import '../../addmedicine/celender.dart';

class Myseond extends StatefulWidget {
  const Myseond({super.key});

  @override
  State<Myseond> createState() => _MyseondState();
}

class _MyseondState extends State<Myseond> {
  bool? ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        250,
        247,
        247,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          SizedBox(
            // ignore: sort_child_properties_last
            child: Image.asset(
                'lib/assets/images/53911-online-medical-assistance-animation (1).gif'),
            width: 400,
            height: 280,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ValueListenableBuilder<Box<MedicineModel>>(
                valueListenable: MedicineModel.getData().listenable(),
                builder: (context, Box, _) {
                  var data = Box.values.toList().cast<MedicineModel>();

                  return ListView.separated(
                      separatorBuilder: ((context, index) => const Divider()),
                      shrinkWrap: true,
                      itemCount: Box.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane:
                              ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                deletemedcine(data[index]);
                                // deletem(context);
                              },
                              icon: Icons.delete,
                              label: 'Delete',
                              backgroundColor: Colors.red,
                            )
                          ]),
                          child: Card(
                            color: Color.fromARGB(255, 93, 204, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 7,
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 82,

                                  width: double.infinity,
                                  child: Stack(children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "medicine : ${data[index].note}")),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child:
                                            Text(data[index].time.toString())),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(DateFormat("MMMM d")
                                            .format(data[index].dates))),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          " Reson: ${data[index].dose.toString()}"),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child:
                                            Text("Dose : ${data[index].pill}")),
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Checkbox(
                                        value: data[index].onTap,
                                        activeColor: Colors.blue,

                                        // tristate: true,
                                        onChanged: (value) {
                                          if (value!) {
                                            QuickAlert.show(
                                                title: 'complte your medicne',
                                                context: context,
                                                onConfirmBtnTap: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    data[index].onTap = true;
                                                    MedicineCopyModel
                                                        medComplete =
                                                        MedicineCopyModel(
                                                            date: data[index]
                                                                .note,
                                                            dose: data[index]
                                                                .dose,
                                                            pill: data[index]
                                                                .pill);
                                                    MedicineCopyModel.getData()
                                                        .add(medComplete);
                                                    Box.deleteAt(index);
                                                  });
                                                },
                                                type: QuickAlertType.info);
                                          } else {
                                            setState(() {
                                              data[index].onTap = false;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ]),
                                  // child: ListTile(
                                  //     leading: Text(
                                  //       "medicine : ${data[index].note}",
                                  //       style: const TextStyle(
                                  //         fontSize: 15,
                                  //       ),
                                  //     ),
                                  //     subtitle: Text(data[index].dose),
                                  //     trailing: Column(
                                  //       children: [

                                  // ],
                                  // )),
                                )),
                          ),
                        );
                      });
                }),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: "",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AddMedicine())));
              },
              child: Icon(Icons.add),
              // label: const Text('Add'),

              backgroundColor: const Color.fromARGB(255, 56, 176, 166),
            ),
          ),
        ]),
      ),
    );
  }
}
