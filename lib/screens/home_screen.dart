import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/screens/add_water2_screen.dart';
import 'package:hyjoden/screens/add_water_screen.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/services/local_notification_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
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
  // NotificationsServices notificationsServices = NotificationsServices();
  late final LocalNotificationService notificationService;
  int visit = 0;
  User? user;
  // User? curuser;
  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _progress;
  int? growTimes; //จำนวนครั้งที่จะกดgrow
  int _treeProgress = 0;
  int _treeMaxProgress = 100;
  double? amount;
  double? result;
  String? percent;
  int? achievementCount;
  String buttonText = "";
  String text = "";

  @override
  void initState() {
    notificationService = LocalNotificationService();
    notificationService.intialize();
    listenNotifications();
    super.initState();
    // notificationsServices.initializeNotification();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final databaseService =
          Provider.of<DatabaseService>(context, listen: false);
      final authservice = Provider.of<AuthService>(context, listen: false);
      User? newUser = await authservice.currentUser();
      setState(() {
        user = newUser;
        databaseService.checkAchievement(user: user!);
        // achievementCount = databaseService.countAchievement(user: user!);

        if (user!.todayDrink! / user!.target! > 1.00) {
          result = 1.00;
        } else {
          result = user!.todayDrink! / user!.target!;
        }

        percent = (result! * 100).toStringAsFixed(0) + "%";
        grow((result! * 100).toInt());

        if (DateTime.now().hour == 0 &&
            DateTime.parse(user!.lastLogin!).hour != 0) {
          user!.todayDrink = 0;
        }
        user!.lastLogin = DateTime.now().toString();
        databaseService.updateUserFromUid(uid: user!.uid, user: user!);
      });
    });
    Future.delayed(Duration.zero, () {
      changText();
    });

    if (_treeProgress == 0) {
      rootBundle.load('assets/animations/tree_og.riv').then(
        (data) async {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            _progress = controller.findInput('input');
          }
          setState(() => _riveArtboard = artboard);
        },
      );
    }
    print(achievementCount);
    if (achievementCount == 1) {
      rootBundle.load('assets/animations/tree_demo (1).riv');
    }
  }

  // แบบถ้าทำ acheivement แล้วเราจะ load riv ใหม่
  // void evolution() {
  //   setState(() {
  //     if (_treeProgress == 100) {
  //       rootBundle.load('assets/animations/tree_demo (1).riv').then(
  //         (data) async {
  //           final file = RiveFile.import(data);
  //           final artboard = file.mainArtboard;
  //           var controller = StateMachineController.fromArtboard(
  //               artboard, 'State Machine 1');
  //           if (controller != null) {
  //             artboard.addController(controller);
  //             _progress = controller.findInput('input');
  //           }
  //           setState(() => _riveArtboard = artboard);
  //         },
  //       );
  //       _treeProgress = 0;
  //     }
  //   });
  // }

  void grow(int percent) {
    setState(() {
      _treeProgress += percent;
      _progress?.value = _treeProgress.toDouble();
    });
  }

  void deGrow() {
    setState(() {
      _treeProgress -= 10;
      _progress?.value = _treeProgress.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationService =
        Provider.of<LocalNotificationService>(context, listen: false);
    double treeWidth = MediaQuery.of(context).size.width - 40;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      amount = 0.0;
    } else {
      amount = ModalRoute.of(context)!.settings.arguments as double;
    }

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
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Expanded(
                child: Center(
                  child: _riveArtboard == null
                      ? const SizedBox()
                      : Container(
                          width: treeWidth,
                          height: treeWidth,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(treeWidth / 2),
                              border: Border.all(
                                  color: kColorsLightGrey, width: 10)),
                          child: Rive(
                              alignment: Alignment.center,
                              artboard: _riveArtboard!),
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
                    Text('${user!.todayDrink!.toInt()}',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: kColorsGrey,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'ml. / ${user!.target!.toInt()} ml.',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: LinearPercentIndicator(
                  // animation: true,
                  // animationDuration: 1000,
                  center: Text(percent!,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 2,
                      )),
                  lineHeight: 30,
                  barRadius: Radius.circular(20),
                  percent: result!,
                  progressColor: Colors.blue[300],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              changText(),
            ]),
      bottomNavigationBar: BottomBarInspiredInside(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.blue,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/summary');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/add-water');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/reward');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        }),
        chipStyle: const ChipStyle(convexBridge: true),
        itemStyle: ItemStyle.circle,
        animated: true,
      ),
    );
  }

  Widget changText() {
    if (_treeProgress <= 10) {
      return Text("It's a good start. 👍🏻",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 20) {
      return Text("Do it for YOURSELF. 🪄",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 30) {
      return Text("Keep Tryin\'! 👊🏻",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 40) {
      return Text("Drink More 👄",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 50) {
      return Text("A Little More ✨",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 60) {
      return Text("You're Halfway There. 🏃‍♂️",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 70) {
      return Text("Don't Give Up. ✌🏻",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 80) {
      return Text("You Can Do It 🌻",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 90) {
      return Text("Almost There. 💦",
          style: Theme.of(context).textTheme.headline2);
    } else if (_treeProgress <= 100) {
      return Text("You Did It 🎊",
          style: Theme.of(context).textTheme.headline2);
    } else {
      return Text("", style: Theme.of(context).textTheme.headline2);
    }
  }

  void listenNotifications() => notificationService.onNotificationClick.stream
      .listen(onNotificationListener);
  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.pushReplacementNamed(context, '/add-water');
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => AddWater2Screen(payload: payload))));
    }
  }
}
