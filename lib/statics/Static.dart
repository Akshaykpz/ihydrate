// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:water_tracker/models/category/database.dart';

// class MyStatic extends StatefulWidget {
//   const MyStatic({super.key});

//   @override
//   State<MyStatic> createState() => _MyStaticState();
// }

// class _MyStaticState extends State<MyStatic> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         color: Color.fromARGB(255, 255, 238, 238),
//         child: Column(
//           children: [
//             Center(
//                 child: Image.asset(
//                     'lib/assets/images/animation_640_lelay9ee.gif')),
//             // Expanded(
//             //     child: ListView.builder(
//             //         itemCount: MedicineCopyModel.getData().length,
//             //         itemBuilder: (context, index) {
//             //           final data = MedicineCopyModel.getData().getAt(index);
//             //           return Card(
//             //             elevation: 2,
//             //             child: ListTile(
//             //               title: Text('${data!.date} '),
//             //               trailing: Text("${data.dose} dose "),
//             //               subtitle: Text(data.dose),
//             //               // leading: text(''),
//             //             ),
//             //           );
//             //         })),
//           ],
//         ),
//       ),
//     );
//     //
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:water_tracker/boxes/box.dart';
import 'package:water_tracker/models/category/database.dart';
import 'package:water_tracker/models/category/database_functions.dart';

class WaterProgressChart extends StatefulWidget {
  @override
  _WaterProgressChartState createState() => _WaterProgressChartState();
}

class _WaterProgressChartState extends State<WaterProgressChart> {
  int _waterGoal = 0;
  int _waterCount = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final waterGoalBox = await WaterGoal.getdata();
    final drinkBox = await Boxes.getdata();

    setState(() {
      _waterGoal = waterGoalBox.get(0)!.goal;
      _waterCount = drinkBox.values.fold(0, (sum, drink) => sum + drink.water);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData('Water Count', _waterCount),
                  ChartData('Remaining', _waterGoal - _waterCount),
                ],
                //water count
                xValueMapper: (ChartData data, _) => data.category,
                //reming
                yValueMapper: (ChartData data, _) => data.value,
                //convert percetage in data
                dataLabelMapper: (ChartData data, _) =>
                    //fixed using in number show
                    '${((data.value / _waterGoal) * 100).toStringAsFixed(0)}%',
                //data show down side
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
            //show detiles in list count and reming
            legend: Legend(isVisible: true),
          ),

          // Display the percentage of the total goal completed
          Text(
              '${(_waterCount / _waterGoal * 100).toStringAsFixed(0)}%Complete of Goal'),
          const SizedBox(height: 16),
          // Display the percentage of remaining water
          Text(
              '${((_waterGoal - _waterCount) / _waterGoal * 100).toStringAsFixed(0)}% of water remaining'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}
