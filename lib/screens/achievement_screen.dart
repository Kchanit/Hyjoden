import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hyjoden/screens/home_screen.dart';
import 'package:hyjoden/themes/colors.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {

  int visit = 3;
  @override
  Widget build(BuildContext context) {
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

      body: ListView(
        children: [
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            
            style: NeumorphicStyle(
              shadowLightColor: kColorsLightGrey,
              depth: 3,
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/container2.png', width: 40, height: 70,),
                          ),
                      ]
                )
              ]
            ),
          ),
            
          
          
        ]
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
            Navigator.pushReplacementNamed(context, '/add');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/achievement');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        }),
        chipStyle: const ChipStyle(convexBridge: true),
        itemStyle: ItemStyle.circle,
        animated: true,
    ));
  }
}
