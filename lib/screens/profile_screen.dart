import 'dart:math';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/screens/add_water_screen.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int visit = 4;

  User? user;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final authservice = Provider.of<AuthService>(context, listen: false);
  //     User? newUser = await authservice.currentUser();
  //     setState(() {
  //       user = newUser;
  //     });
  //     print(user!.uid);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.currentUser().then((currentUser) {
      if (!mounted) return;
      setState(() {
        user = currentUser;
      });
    });
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

      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.left,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 225, bottom: 10, top: 75),
            child: Text('Profile',
             style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 2)
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(12),
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 5,
              color: Colors.white,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text('Username: ${user!.username}', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                      ]
                )
              ]
            ),
        ),
        Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(12),
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 5,
              color: Colors.white,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text('Gender: ${user!.gender}', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                      ]
                )
              ]
            ),
        ),
        Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(12),
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 5,
              color: Colors.white,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text('Age: ${user!.age}', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                      ]
                )
              ]
            ),
        ),
        Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(12),
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 5,
              color: Colors.white,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text('Weight: ${user!.weight} height: ${user!.height}', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                      ]
                )
              ]
            ),
        ),
        Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(12),
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 5,
              color: Colors.white,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text('Waketime: ${user!.waketime} Bedtime: ${user!.bedtime}', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                      ]
                )
              ]
            ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 148.0, vertical: 15),
          child: NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.grey[50],
              shape: NeumorphicShape.flat,
              depth: 5,
              boxShape: NeumorphicBoxShape.stadium(),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Center(
              child: Text(
                "Logout",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            onPressed: () {
              LogoutHandle(context: context);
            },
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
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/add-water');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/reward');
          }
        }),
        chipStyle: const ChipStyle(convexBridge: true),
        itemStyle: ItemStyle.circle,
        animated: true,
      ),
    );
  }
  Future<void> LogoutHandle({required BuildContext context}) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try{
      await authService.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } on auth.FirebaseAuthException catch (e) {
      print(e.message!);
    }
  }
}