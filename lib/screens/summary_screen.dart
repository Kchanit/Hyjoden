import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    title: 'AWARD',
  ),
  TabItem(
    icon: Icons.person_rounded,
    title: 'PROFILE',
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

  List<int> value = [
    200, 300, 150, 600, 10
  ];

  @override
  Widget build(BuildContext context) {
    double result = currentProg / target;
    int perc = (result * 100).toInt();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
      body: ListView(
        
        children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Today', style: Theme.of(context).textTheme.headline2),
        ),
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
                    progressColor: kColorsBlue,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '$perc%', style: TextStyle(fontSize: 40),
                      // style: GoogleFonts.getFont('Poppins', fontSize: 40),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // Container(
                  //   width: 945,
                  //   height: 444,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     borderRadius: BorderRadius.circular(42),
                  //   ),
                  //   child: Row(children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(left: 10),
                  //       child: Image.asset(
                  //         'assets/container1.png',
                  //         scale: 6,
                  //       ),
                  //     )
                  //   ]),
                  // ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Recent Drink', style: Theme.of(context).textTheme.headline3),
        ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Neumorphic(
          style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)), 
          depth: -5,
          lightSource: LightSource.topLeft,
          color: Colors.white
            ),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/container2.png', width: 40, height: 70,),
                            SizedBox(width: 15,),
                            Text('${value[index]} ml', style: Theme.of(context).textTheme.subtitle1,)
                          ],
                        ),
                        Text('10 : 30 am', style: Theme.of(context).textTheme.subtitle1,)
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                    height: 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: kColorsLightGrey),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
          ),
        ),

        NeumorphicRadio(

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
