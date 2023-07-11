import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:water_tracker/models/category/database.dart';
import 'package:water_tracker/pages/view/home/homepage/delete_data.dart';
import 'package:water_tracker/pages/view/home/homepage/home_pageui.dart';

import '../home/Setting/Settings.dart';

class MyWater extends StatefulWidget {
  const MyWater({super.key});

  @override
  State<MyWater> createState() => _MyWaterState();
}

class _MyWaterState extends State<MyWater> {
  @override
  void initState() {
    MedicineModel.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            if (datafilter == false)
              ValueListenableBuilder(
                  valueListenable: dateRangeNotifier,
                  builder: (context, dateRange, _) {
                    return ValueListenableBuilder(
                      valueListenable: filter,
                      builder: (context, value, child) {
                        return value == false
                            ? Expanded(
                                child:
                                    ValueListenableBuilder<Box<MedicineModel>>(
                                        valueListenable: MedicineModel.getData()
                                            .listenable(),
                                        builder: (context, Box, _) {
                                          var dataList = Box.values
                                              .toList()
                                              .cast<MedicineModel>();

                                          //--------------------

                                          List<MedicineModel> dateFilteredList =
                                              [];

                                          if (dateRange != null) {
                                            for (var element in dataList) {
                                              if (element.dates.isAfter(
                                                      dateRange.start.subtract(
                                                          Duration(days: 1))) &&
                                                  element.dates.isBefore(
                                                      dateRange.end.add(
                                                          Duration(days: 1)))) {
                                                dateFilteredList.add(element);
                                              }
                                            }
                                            dataList = dateFilteredList;
                                          }
                                          //--------------------
                                          return dataList.isEmpty
                                              ? Image.asset(
                                                  'lib/assets/images/89832-empty-list.gif')
                                              : ListView.builder(
                                                  itemCount: dataList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final data =
                                                        MedicineModel.getData()
                                                            .getAt(index);
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              93, 204, 255),
                                                          elevation: 2,
                                                          child: SizedBox(
                                                              height: 100,
                                                              width: 350,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Stack(
                                                                    children: [
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .topLeft,
                                                                          child:
                                                                              Text("Medicine : ${data!.note}")),
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .bottomCenter,
                                                                          child: Text(data
                                                                              .time
                                                                              .toString())),
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .center,
                                                                          child:
                                                                              Text(DateFormat("MMMM d").format(data.dates))),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child: Text(
                                                                            " Reson: ${data.dose}"),
                                                                      ),
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .bottomLeft,
                                                                          child:
                                                                              Text("Dose : ${data.pill}")),
                                                                      Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                deletemedcine(data);
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.delete,
                                                                                color: Colors.red,
                                                                              ))),
                                                                    ]),
                                                              ))),
                                                    );
                                                  });
                                        }),
                              )
                            : Expanded(
                                child: MedicineCopyModel.getData().isEmpty
                                    ? Center(
                                        child: Image.asset(
                                            'lib/assets/images/output-onlinegiftools (2).gif'))
                                    : ListView.builder(
                                        itemCount:
                                            MedicineCopyModel.getData().length,
                                        itemBuilder: (context, index) {
                                          final data =
                                              MedicineCopyModel.getData()
                                                  .values
                                                  .toList();

                                          return Card(
                                              color: const Color.fromARGB(
                                                  255, 93, 204, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              elevation: 2,
                                              child: SizedBox(
                                                width: 350,
                                                height: 90,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Stack(children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            "Medicine :${data[index].date}")),
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "Reson :${data[index].dose} ")),
                                                    Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Text(
                                                            " Dose :${data[index].pill}")),
                                                    Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              data[index]
                                                                  .delete();
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ))),
                                                  ]),
                                                ),
                                              )
                                              //  ListTile(
                                              //   title: Text('${data!.date} '),
                                              //   trailing: Text("${data.dose} dose "),
                                              //   subtitle: Text(data.dose),
                                              //   // leading: text(''),
                                              // ),
                                              );
                                        }));
                      },
                    );
                  })
          ],
        ),
      ),
    );
  }
}
