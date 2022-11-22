import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rive/rive.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home_rounded,
    title: 'HOME',
  ),
  TabItem(
    icon: Icons.bar_chart_rounded,
    title: 'SUMMARY',
  ),
  TabItem(
    icon: Icons.add_rounded,
    // title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.star_rounded,
    title: 'REWARD',
  ),
  TabItem(
    icon: Icons.person_rounded,
    title: 'PROFILE',
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
  int _treeMaxProgress = 100;

  String buttonText = "";

  @override
    void initState() {
      super.initState();
      // Load the animation file from the bundle, note that you could also
      // download this. The RiveFile just expects a list of bytes.
      if (_treeProgress == 0) {
        rootBundle.load('assets/tree_demo.riv').then(
          (data) async {
            // Load the RiveFile from the binary data.
            final file = RiveFile.import(data);

            // The artboard is the root of the animation and gets drawn in the
            // Rive widget.
            final artboard = file.mainArtboard;
            var controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
            if (controller != null) {
              artboard.addController(controller);
              _progress = controller.findInput('input');
            }
            setState(() => _riveArtboard = artboard);
          },
        );
      }
    }
    // แบบถ้าทำ acheivement แล้วเราจะ load riv ใหม่
    void evolution() {
      setState(() {
        if (_treeProgress == 100) {
          rootBundle.load('assets/tree_demo (1).riv').then(
          (data) async {
            final file = RiveFile.import(data);
            final artboard = file.mainArtboard;
            var controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
            if (controller != null) {
              artboard.addController(controller);
              _progress = controller.findInput('input');
            }
            setState(() => _riveArtboard = artboard);
          },
        );
        _treeProgress = 0;
        }
      });
    }

    void grow() {
      setState(() {
        _treeProgress += 10;
        _progress?.value = _treeProgress.toDouble();
      });
    }

    void deGrow(){
      setState(() {
        _treeProgress -= 10;
        _progress?.value = _treeProgress.toDouble();
      });
    }

  @override
  Widget build(BuildContext context) {
    double treeWidth = MediaQuery.of(context).size.width - 40;

    double result = _treeProgress / 100;
    String percent = (result*100).toString() + "%";

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 233, 233),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
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
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
          ),
          SizedBox(height: 50),
            LinearPercentIndicator(
              // animation: true,
              // animationDuration: 1000,
              center: Text(percent, style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 2)),
              lineHeight: 30,
              barRadius: Radius.circular(20),
              percent: result,
              progressColor: Color(0xFF3E3E3E),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    evolution();
                    if (_treeProgress < _treeMaxProgress){
                      grow();
                    } else {
                      return ;
                    }
                  },
                  child: Text('GROW'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    if (_treeProgress > 0)
                      deGrow();
                  },
                  child: Text('DeGROW'),
                )
              ],
            ),
          )
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
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/add-water');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/reward');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        }),
        chipStyle: const ChipStyle(convexBridge: true),
        itemStyle: ItemStyle.circle,
        animated: true,
      ),
    );
  }
}
