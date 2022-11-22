import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyjoden/themes/colors.dart';
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

  late double result;
  late String percent;

  String buttonText = "";
  String text = "";

  
  @override
    void initState() {
      super.initState();
      Future.delayed(Duration.zero, () {
        changText();
      });
    
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
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kColorsWhite,
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
                            border: Border.all(color: kColorsLightGrey, width: 10)),
                          child: Rive(alignment: Alignment.center,artboard: _riveArtboard!),
                      ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('600', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, 
                          color: kColorsGrey,)),
                SizedBox(width: 5,),
                Text('ml. / 2100 ml.', style: Theme.of(context).textTheme.subtitle1,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: LinearPercentIndicator(
              // animation: true,
              // animationDuration: 1000,
              center: Text(percent, style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 2,)),
              lineHeight: 30,
              barRadius: Radius.circular(20),
              percent: result,
              progressColor: Colors.blue[300],
            ),
          ),
          SizedBox(height: 10,),
          changText(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
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
  
  Widget changText() {
    if (_treeProgress == 10) {
      return Text("It's a good start. 👍🏻", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 20) {
      return Text("Do it for YOURSELF. 🪄", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 30) {
      return Text("Keep Tryin\'! 👊🏻", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 40) {
      return Text("Drink More 👄", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 50) {
      return Text("A Little More ✨", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 60) {
      return Text("You're Halfway There. 🏃‍♂️", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 70) {
      return Text("Don't Give Up. ✌🏻", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 80) {
      return Text("You Can Do It 🌻", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 90) {
      return Text("Almost There. 💦", style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress == 100) {
      return Text("You Did It 🎊", style: Theme.of(context).textTheme.headline2);
    } else {
      return Text("", style: Theme.of(context).textTheme.headline2);
    }
  }
  
}
