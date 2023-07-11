import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/models/category/database_functions.dart';
import 'package:water_tracker/pages/view/home/homepage/delete_data.dart';
import 'package:water_tracker/provider/water.dart';
import '../../../../boxes/box.dart';
import '../../../../models/category/database.dart';

class WaterList extends StatefulWidget {
  const WaterList({super.key});

  @override
  State<WaterList> createState() => _WaterListState();
}

class _WaterListState extends State<WaterList> {
  @override
  void initState() {
    context.read<WaterProivder>().Waterdata;

    super.initState();
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // String formattedDate = DateFormat(' kk:mm').format(now);
    String formattedDate = DateFormat('kk:mm a').format(now);

    return Consumer<WaterProivder>(builder: (context, WaterProivder, _) {
      final box = Boxes.getdata();
      final today = DateTime.now();
      final filter = box.values
          .where((element) =>
              element.date.year == today.year &&
              element.date.month == today.month &&
              element.date.day == today.day)
          .toList();

      return box.length == 0
          ? Image.asset('lib/assets/images/89832-empty-list.gif')
          : ListView.separated(
              separatorBuilder: ((context, index) => Container(
                    height: 7,
                  )),
              itemCount: filter.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        // showAlert(context);
                        delete(filter[index]);
                        // deletem(context);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    )
                  ]),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color.fromARGB(255, 93, 204, 255),
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'note:  ${filter[index].subtitle.toString()}',
                                ),
                              ),
                              Text(
                                '${filter[index].water.toString()} ml',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  (DateFormat("MMMM d").format(now)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  formattedDate,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                );
              });
    });
  }
}
