import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home_rounded,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.bar_chart_rounded,
    // title: 'Shop',
  ),
  TabItem(
    icon: Icons.add_rounded,
    // title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.star_rounded,
    // title: 'Cart',
  ),
  TabItem(
    icon: Icons.person_rounded,
    // title: 'profile',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int visit = 0;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _progress;

  int _treeProgress = 0;
  int _treeMaxProgress = 60;

  @override
    void initState() {
      super.initState();
      // Load the animation file from the bundle, note that you could also
      // download this. The RiveFile just expects a list of bytes.
      rootBundle.load('assets/tree_demo.riv').then(
        (data) async {
          // Load the RiveFile from the binary data.
          final file = RiveFile.import(data);

          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          var controller = StateMachineController.fromArtboard(artboard, 'Grow');
          if (controller != null) {
            artboard.addController(controller);
            _progress = controller.findInput('input');
          }
          setState(() => _riveArtboard = artboard);
        },
      );
    }

    void grow(){
      setState(() {
        _treeProgress += 10;
      });
    }

    void deGrow(){
      setState(() {
        _treeProgress -= 10;
      });
    }

  @override
  Widget build(BuildContext context) {
    double treeWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 233, 233),
      appBar: AppBar(
        leading: null,
        backgroundColor: Color.fromARGB(255, 235, 233, 233),
        title: Container(
          alignment: Alignment.bottomCenter,
          child: Text('HYJODEN',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 2)),
        ),
        elevation: 0,
        toolbarHeight: 80,
      ),
      
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _riveArtboard == null ? const SizedBox() :
               Container(
                      width: treeWidth,
                      height: treeWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(treeWidth / 2),
                          border: Border.all(color: Colors.white12, width: 10)),
                        child: Rive(alignment: Alignment.center,artboard: _riveArtboard!),
                    ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomBarInspiredInside(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.blue,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/summary');
          }
        }),
        chipStyle: const ChipStyle(convexBridge: true),
        itemStyle: ItemStyle.circle,
        animated: true,
      ),
    );
  }
}
