import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home_rounded,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.bar_chart_rounded,
    title: 'Summary',
  ),
  TabItem(
    icon: Icons.add_rounded,
    // title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.star_rounded,
    title: 'Achievement',
  ),
  TabItem(
    icon: Icons.person_rounded,
    title: 'Profile',
  ),
];

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int visit = 1;
  double currentProg = 1690;
  double target = 3700;

  @override
  Widget build(BuildContext context) {
    double result = currentProg / target;
    int perc = (result * 100).toInt();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: null,
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
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(25),
          child: Container(
            // style: NeumorphicStyle(
            //     shape: NeumorphicShape.concave,
            //     boxShape:
            //         NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
            //     lightSource: LightSource.topLeft,
            //     depth: 4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    radius: 100,
                    lineWidth: 20,
                    percent: result,
                    progressColor: Color(0xFF3E3E3E),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '$perc%',
                      style: GoogleFonts.getFont('Poppins', fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 50),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 30,
                    barRadius: Radius.circular(20),
                    percent: result,
                    progressColor: Color(0xFF3E3E3E),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 945,
                    height: 569,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(42),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Image.asset(
                          'assets/container1.png',
                          scale: 6,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
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
