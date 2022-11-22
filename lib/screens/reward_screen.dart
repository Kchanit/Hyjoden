// import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
// import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// const List<TabItem> items = [
//   TabItem(
//     icon: Icons.home_rounded,
//     title: 'HOME',
//   ),
//   TabItem(
//     icon: Icons.bar_chart_rounded,
//     title: 'SUMMARY',
//   ),
//   TabItem(
//     icon: Icons.add_rounded,
//     // title: 'Wishlist',
//   ),
//   TabItem(
//     icon: Icons.star_rounded,
//     title: 'REWARD',
//   ),
//   TabItem(
//     icon: Icons.person_rounded,
//     title: 'PROFILE',
//   ),
// ];

// class RewardScreen extends StatefulWidget {
//   const RewardScreen({super.key});

//   @override
//   State<RewardScreen> createState() => _RewardScreenState();
// }

// class _RewardScreenState extends State<RewardScreen> {
//   int visit = 3;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.grey[300],
//         title: Container(
//           alignment: Alignment.bottomCenter,
//           child: Text('HYJODEN',
//               style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                   letterSpacing: 2)),
//         ),
//         elevation: 0,
//         toolbarHeight: 80,
//       ),
//       bottomNavigationBar: BottomBarInspiredInside(
//         items: items,
//         backgroundColor: Colors.white,
//         color: Colors.blue,
//         colorSelected: Colors.white,
//         indexSelected: visit,
//         onTap: (int index) => setState(() {
//           visit = index;
//           if (index == 0) {
//             Navigator.pushReplacementNamed(context, '/home');
//           } else if (index == 1) {
//             Navigator.pushReplacementNamed(context, '/summary');
//           } else if (index == 2) {
//             Navigator.pushReplacementNamed(context, '/add-water');
//           } else if (index == 3) {
//             Navigator.pushReplacementNamed(context, '/reward');
//           } else if (index == 4) {
//             Navigator.pushReplacementNamed(context, '/login');
//           }
//         }),
//         chipStyle: const ChipStyle(convexBridge: true),
//         itemStyle: ItemStyle.circle,
//         animated: true,
//       ),
//     );
//   }
// }
