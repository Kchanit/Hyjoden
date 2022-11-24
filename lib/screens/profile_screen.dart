import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
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
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              // crossAxisAlignment: CrossAxisAlignment.left,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user!.username}', style: Theme.of(context).textTheme.headline2,),
                          Text('${user!.email}', style: Theme.of(context).textTheme.headline3,)
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.white,
                            lightSource: LightSource.topLeft,
                            shape: NeumorphicShape.convex,
                            depth: 5,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                          child: Center(
                            child: Icon(Icons.edit)
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit-profile');
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Neumorphic(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    color: Colors.grey[50],
                    depth: -5
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gender :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.gender}', style: Theme.of(context).textTheme.headline3,),
                          SizedBox(height: 15,),
                          Text('Weight :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.weight} kg', style: Theme.of(context).textTheme.headline3,),
                          SizedBox(height: 15,),
                          Text('Bed Time :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.bedtime}', style: Theme.of(context).textTheme.headline3,),
                          SizedBox(height: 15,),
                          Text('Goal :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.target!.toInt()} ml', style: Theme.of(context).textTheme.headline3,),
                        ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.age}', style: Theme.of(context).textTheme.headline3,),
                          SizedBox(height: 15,),
                          Text('Height :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.height} kg', style: Theme.of(context).textTheme.headline3,),
                          SizedBox(height: 15,),
                          Text('Wake Up Time :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.waketime}', style: Theme.of(context).textTheme.headline3,),
                          SizedBox(height: 15,),
                          Text('Favorite Container :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.favContainer!.toInt()} ml', style: Theme.of(context).textTheme.headline3,),
                        ]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 70),
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
                      "Log Out",
                      style: Theme.of(context).textTheme.subtitle1,
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
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/summary');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/add-water');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/reward');
          } else if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
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
