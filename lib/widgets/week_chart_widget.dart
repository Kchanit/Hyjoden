// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:hyjoden/themes/colors.dart';


// class WeekChartWidget extends StatelessWidget {
//   WeekChartWidget({Key? key }) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Stack(
//         children: <Widget>[
//           AspectRatio(
//             aspectRatio: 1.70,
//             child: DecoratedBox(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(18),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: 18,
//                   left: 12,
//                   top: 24,
//                   bottom: 12,
//                 ),
//                 child: LineChart(
//                   showAvg ? avgData() : mainData(),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: AlignmentDirectional.topEnd,
//             child: SizedBox(
//               width: 60,
//               height: 34,
//               child: TextButton(
//                 onPressed: () {
//                   setState(() {
//                     showAvg = !showAvg;
//                   });
//                 },
//                 child: Text(
//                   'target',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: showAvg ? kColorsGrey.withOpacity(0.5) : kColorsLightGrey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }