import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyjoden/models/achievement_model.dart';
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/screens/home_screen.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:hyjoden/utils/checkAchievement.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int visit = 3;
  bool achieved = false;
  User? user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authservice = Provider.of<AuthService>(context, listen: false);
      User? newUser = await authservice.currentUser();
      setState(() {
        user = newUser;
      });
    });
  }

  Color _TrophyColor({required bool achieved}) {
    if (achieved)
      return kColorsYellow;
    else {
      return Colors.black;
    }
  }

  Color _BgColor({required bool achieved}) {
    if (achieved)
      return kColorsBlue;
    else {
      return Color.fromARGB(255, 217, 217, 217);
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    iconSize: 5,
                    icon: SvgPicture.asset('assets/icons/trophy-solid.svg',
                        color: kColorsYellow),
                    onPressed: () {},
                  ),
                ),
                user == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text('${user!.achievementCount}',
                        style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
          leadingWidth: 125,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text('HYJODEN',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 2)),
          elevation: 0,
          toolbarHeight: 80,
        ),
        body: user == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder<List<Achievement>>(
                stream:
                    databaseService.getStreamListAchievement(uid: user!.uid),
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
                      child: Text(
                        'No Achievement Found',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    // List<String> check = checkAchievement(user: user!).split(',');
                    // // for (var i = 0; i < snapshot.data!.length; i++) {
                    // for (var i = 0; i < 3; i++) {
                    //   if (isNumeric(check[i])) {
                    //     print(check[i]);
                    //     snapshot.data![i].unlocked = true;
                    //     achieved = true;
                    //   }

                    //   try {
                    //     double.parse(check[i]);
                    //   } on FormatException {
                    //     snapshot.data![i].unlocked = true;
                    //   }
                    // }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Neumorphic(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                padding: EdgeInsets.all(12),
                                style: NeumorphicStyle(
                                  shadowLightColor: kColorsLightGrey,
                                  depth: 5,
                                  color: Colors.white,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(12)),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${snapshot.data![index].name} \n${snapshot.data![index].detail}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: _BgColor(
                                                                achieved: snapshot
                                                                    .data![
                                                                        index]
                                                                    .unlocked)),
                                                      ),
                                                      IconButton(
                                                        icon: SvgPicture.asset(
                                                          'assets/icons/trophy-solid.svg',
                                                          color: _TrophyColor(
                                                              achieved: snapshot
                                                                  .data![index]
                                                                  .unlocked),
                                                        ),
                                                        onPressed: () {},
                                                      )
                                                    ])),
                                          ])
                                    ]),
                              ),
                            ],
                          );
                        });
                  }
                }),
        bottomNavigationBar: BottomBarInspiredInside(
          items: items,
          backgroundColor: kColorsWhite,
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
            } else if (index == 4) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          }),
          chipStyle: const ChipStyle(convexBridge: true),
          itemStyle: ItemStyle.circle,
          animated: true,
          elevation: 20,
        ));
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
