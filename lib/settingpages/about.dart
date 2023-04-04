// // ignore: avoid_web_libraries_in_flutter

// import 'package:flutter/material.dart';
// // import 'package:flutter_flushbar/flutter_flushbar.dart';
// // import 'package:quickalert/quickalert.dart';

// class MyAbout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//   // void showAlert(BuildContext context) {
//   //   QuickAlert.show(context: context, type: QuickAlertType.success);
//    }

//   const MyAbout({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
// //         body: Center(
// //           child: ElevatedButton(onPressed: () {}, child: Text('hai')),
// //         ),
// //       ),
// //     );
// //   }
// // }

//     appBar: AppBar(
//       title: const Text(
//         'About',
//       ),
//       centerTitle: true,
//       backgroundColor: const Color.fromARGB(255, 76, 197, 187),
//     ),
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: const [
//         Center(
//             child: Text(
//           'Water Minder',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         )),
//         SizedBox(
//           height: 15,
//         ),
//         Text(
//           'Devloped by Akshay ',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           'Version 1.0.2',
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
//         )
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 76, 197, 187),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
              child: Text(
            'Water Minder',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 15,
          ),
          Text(
            'Devloped by Akshay ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Version 1.0.2',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
