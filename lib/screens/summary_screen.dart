import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyjoden/models/history_model.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

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

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int visit = 1;
  double currentProg = 1690;
  double target = 3700;
  User? user;
  List<int> value = [200, 300, 150, 600, 10];
  double? result;
  int? perc;
  int? _groupValue = 1;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  late LineChartData chart;
  late LineChartData avg;
  @override
  void initState() {
    chart = weekMainData();
    avg = weekAvgData();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final databaseService =
          Provider.of<DatabaseService>(context, listen: false);
      final authservice = Provider.of<AuthService>(context, listen: false);
      User? newUser = await authservice.currentUser();
      setState(() {
        user = newUser;
        if (user!.todayDrink! / user!.target! > 1.00) {
          result = 1.00;
        } else {
          result = user!.todayDrink! / user!.target!;
        }
        if (result!.isNaN) {
          result = 0;
        }
        perc = (result! * 100).toInt();
        if (DateTime.now().hour == 0) {
          user!.todayDrink = 0.0;
          databaseService.updateUserFromUid(uid: user!.uid, user: user!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
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
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child:
                    Text('Today', style: Theme.of(context).textTheme.headline2),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 15, bottom: 25, right: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${user!.todayDrink!.toInt()}',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  color: kColorsGrey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'ml. /',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Text(
                          '${user!.target!.toInt()} ml',
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                    result == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Align(
                            alignment: AlignmentDirectional.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircularPercentIndicator(
                                    animation: true,
                                    animationDuration: 1000,
                                    radius: 100,
                                    lineWidth: 20,
                                    percent: result!,
                                    progressColor: kColorsBlue,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: Text(
                                      '${perc}%',
                                      style: TextStyle(fontSize: 40),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text('Recent Drink',
                    style: Theme.of(context).textTheme.headline3),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: -5,
                        shadowLightColorEmboss: kColorsLightGrey,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: SizedBox(
                      height: 170,
                      child: StreamBuilder<List<History>>(
                          stream: databaseService.getStreamListHistory(
                              uid: user!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Column(
                                children: [
                                  Text('An error occure.'),
                                  Text('${snapshot.error}')
                                ],
                              ));
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text('No Transaction'),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 12),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/${snapshot.data![index].imageName}',
                                                    // 'assets/container5.png',
                                                    width: 40,
                                                    height: 70,
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    '${snapshot.data![index].amount} ml',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                '${snapshot.data![index].time}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              )
                                            ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Container(
                                          height: 1.5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: kColorsLightGrey),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    NeumorphicRadio(
                      child: SizedBox(
                        height: 40,
                        width: 70,
                        child: Center(
                          child: Text(
                            "week",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      style: NeumorphicRadioStyle(
                        unselectedColor: Colors.white,
                        selectedColor: Colors.white,
                        unselectedDepth: 0,
                      ),
                      value: 1,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value;
                          showAvg = false;
                          chart = weekMainData();
                          avg = weekAvgData();
                        });
                      },
                    ),
                    SizedBox(width: 12),
                    NeumorphicRadio(
                      child: SizedBox(
                        height: 40,
                        width: 70,
                        child: Center(
                          child: Text(
                            "month",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      style: NeumorphicRadioStyle(
                        unselectedColor: Colors.white,
                        selectedColor: Colors.white,
                        unselectedDepth: 0,
                      ),
                      value: 2,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value;
                          showAvg = false;
                          chart = monthMainData();
                          avg = monthAvgData();
                        });
                      },
                    ),
                    SizedBox(width: 12),
                    NeumorphicRadio(
                      child: SizedBox(
                        height: 40,
                        width: 70,
                        child: Center(
                          child: Text(
                            "year",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      style: NeumorphicRadioStyle(
                        unselectedColor: Colors.white,
                        selectedColor: Colors.white,
                        unselectedDepth: 0,
                      ),
                      value: 3,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value;
                          showAvg = false;
                          chart = yearMainData();
                          avg = yearAvgData();
                        });
                      },
                    ),
                  ],
                ),
              ),
              CreateGraphSum(),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text('Total Drink',
                    style: Theme.of(context).textTheme.headline3),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Row(
                  children: [
                    Text('${user!.todayDrink!.toInt()}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: kColorsGrey,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ml.',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
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
        elevation: 20,
      ),
    );
  }

  Widget CreateGraphSum() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(
                  showAvg ? avg : chart,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: SizedBox(
              width: 60,
              height: 34,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'avg',
                  style: TextStyle(
                    fontSize: 12,
                    color: showAvg
                        ? kColorsGrey.withOpacity(0.5)
                        : kColorsLightGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

/* week chart */
  Widget weekBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: kColorsGrey);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('MON', style: style);
        break;
      case 2:
        text = const Text('TUE', style: style);
        break;
      case 3:
        text = const Text('WED', style: style);
        break;
      case 4:
        text = const Text('THU', style: style);
        break;
      case 5:
        text = const Text('FRI', style: style);
        break;
      case 6:
        text = const Text('SAT', style: style);
        break;
      case 7:
        text = const Text('SUN', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData weekMainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
              y: 3.44,
              color: kColorsGrey.withOpacity(0.5),
              strokeWidth: 2,
              dashArray: [2, 2]),
        ],
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: weekBottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            left: BorderSide(color: kColorsLightGrey),
            bottom: BorderSide(color: kColorsLightGrey)),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4),
            FlSpot(7, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData weekAvgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: weekBottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            left: BorderSide(color: kColorsLightGrey),
            bottom: BorderSide(color: kColorsLightGrey)),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 3.44),
            FlSpot(2, 3.44),
            FlSpot(3, 3.44),
            FlSpot(4, 3.44),
            FlSpot(5, 3.44),
            FlSpot(6, 3.44),
            FlSpot(7, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

/* month chart */
  Widget monthBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: kColorsGrey);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1-7', style: style);
        break;
      case 3:
        text = const Text('8-14', style: style);
        break;
      case 5:
        text = const Text('15-21', style: style);
        break;
      case 7:
        text = const Text('22-31', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData monthMainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
              y: 3.44,
              color: kColorsGrey.withOpacity(0.5),
              strokeWidth: 2,
              dashArray: [2, 2]),
        ],
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: monthBottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            left: BorderSide(color: kColorsLightGrey),
            bottom: BorderSide(color: kColorsLightGrey)),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 2),
            FlSpot(3, 5),
            FlSpot(5, 3.1),
            FlSpot(7, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData monthAvgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: monthBottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            left: BorderSide(color: kColorsLightGrey),
            bottom: BorderSide(color: kColorsLightGrey)),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 3.44),
            FlSpot(3, 3.44),
            FlSpot(5, 3.44),
            FlSpot(7, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

/* year chart */
  Widget yearBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: kColorsGrey);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('J', style: style);
        break;
      case 2:
        text = const Text('F', style: style);
        break;
      case 3:
        text = const Text('M', style: style);
        break;
      case 4:
        text = const Text('A', style: style);
        break;
      case 5:
        text = const Text('M', style: style);
        break;
      case 6:
        text = const Text('J', style: style);
        break;
      case 7:
        text = const Text('J', style: style);
        break;
      case 8:
        text = const Text('A', style: style);
        break;
      case 9:
        text = const Text('S', style: style);
        break;
      case 10:
        text = const Text('O', style: style);
        break;
      case 11:
        text = const Text('N', style: style);
        break;
      case 12:
        text = const Text('D', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData yearMainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
              y: 3.44,
              color: kColorsGrey.withOpacity(0.5),
              strokeWidth: 2,
              dashArray: [2, 2]),
        ],
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: yearBottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            left: BorderSide(color: kColorsLightGrey),
            bottom: BorderSide(color: kColorsLightGrey)),
      ),
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 2),
            FlSpot(7, 5),
            FlSpot(8, 3.1),
            FlSpot(9, 4),
            FlSpot(10, 3),
            FlSpot(11, 4),
            FlSpot(12, 3.1),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData yearAvgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: yearBottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            left: BorderSide(color: kColorsLightGrey),
            bottom: BorderSide(color: kColorsLightGrey)),
      ),
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 3.44),
            FlSpot(2, 3.44),
            FlSpot(3, 3.44),
            FlSpot(4, 3.44),
            FlSpot(5, 3.44),
            FlSpot(6, 3.44),
            FlSpot(7, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9, 3.44),
            FlSpot(10, 3.44),
            FlSpot(11, 3.44),
            FlSpot(12, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

/* for all */
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: kColorsGrey);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1.2K';
        break;
      case 3:
        text = '1.6k';
        break;
      case 5:
        text = '1.9k';
        break;
      case 7:
        text = '2.1k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
