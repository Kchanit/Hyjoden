import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyjoden/screens/home_screen.dart';
import 'package:hyjoden/themes/colors.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  List<String> value = [
    "achievement1", 
    "achievement2",
    "achievement3", 
    "achievement4",
    "achievement5", 
    "achievement6",
    "achievement7", 
    "achievement8"
  ];

  List<String> detail = [
    "detail1", 
    "detail2",
    "detail3", 
    "detail4",
    "detail5", 
    "detail6",
    "detail7", 
    "detail8"
  ];

  int visit = 3;

  bool achieved = false;

  Color _TrophyColor() {
    if (achieved)
      return kColorsYellow;
    else {
      return Colors.black;
    }
  }
  Color _BgColor() {
    if (achieved)
      return kColorsBlue;
    else {
      return Color.fromARGB(255, 217, 217, 217);
    }
  }
  @override
  Widget build(BuildContext context) {
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
                  color: kColorsYellow), onPressed: () {},),
              ),
              Text('10', style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        ),
        leadingWidth: 125,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:  Text('HYJODEN',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 2
            )
          ),
        elevation: 0,
        toolbarHeight: 80,
      ),

      body: ListView(
        children: [
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
                          ),
                      ]
                )
              ]
            ),
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                              SizedBox(width: 15,),
                              Text('Achievement 1\ndetail', style: Theme.of(context).textTheme.subtitle1,)
                            ],
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.asset('assets/container2.png', width: 40, height: 70,),
                            child:
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _BgColor()
                                      ),
                                  ),
                                  IconButton(icon: SvgPicture.asset('assets/icons/trophy-solid.svg', color: _TrophyColor(),), onPressed: () {},)
                                ]
                            )      
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
}
