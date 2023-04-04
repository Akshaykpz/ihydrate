import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/boxes/box.dart';
import 'package:water_tracker/widgets/pages/home/homepage/delete_data.dart';

import '../../../models/category/database.dart';

class MyMedicine extends StatelessWidget {
  const MyMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(' kk:mm').format(now);
    return Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
                child: ValueListenableBuilder<Box<WaterModel>>(
                    valueListenable: Boxes.getdata().listenable(),
                    builder: (context, box, _) {
                      return Boxes.getdata().isEmpty
                          ? Image.asset(
                              'lib/assets/images/89832-empty-list.gif')
                          : ListView.builder(
                              itemCount: Boxes.getdata().length,
                              itemBuilder: (context, index) {
                                final data = Boxes.getdata().getAt(index);
                                return Card(
                                  color: Color.fromARGB(255, 93, 204, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: SizedBox(
                                      height: 80,
                                      width: 370,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                DateFormat("MMMM d")
                                                    .format(now),
                                              ),
                                            ),
                                            Text(
                                              '${data!.water} ml',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                ("note :${data.subtitle}"),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                (formattedDate),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                  onPressed: () async {
                                                    delete(data);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                            )
                                          ],
                                        ),
                                      )),
                                  // ListTile(
                                  //   title: Text('${data!.water} '),
                                  //   // ignore: unnecessary_string_interpolations
                                  //   leading: Text('${data.subtitle}'),
                                  //   trailing: IconButton(
                                  //       onPressed: () async {
                                  //         delete(data);
                                  //       },
                                  //       icon: const Icon(
                                  //         Icons.delete,
                                  //         color: Colors.red,
                                  //       )),
                                  // ),
                                );
                              });
                    })),
          ],
        ));
  }
}
