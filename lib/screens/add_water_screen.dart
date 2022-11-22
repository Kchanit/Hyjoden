import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyjoden/themes/colors.dart';

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

class AddWaterScreen extends StatefulWidget {
  const AddWaterScreen({super.key});

  @override
  State<AddWaterScreen> createState() => _AddWaterScreenState();
}

class _AddWaterScreenState extends State<AddWaterScreen> {
  int visit = 2;

  String? watertype = 'Milk Tea';

  List<String> type = [
      'Milk Tea',
      'Coke',
      'Sprite',
      'Orange Juice',
      'Coffee',
      'Green Tea',
      'other'
    ];

  @override
  Widget build(BuildContext context) {
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

      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text('Choose your drink', style: Theme.of(context).textTheme.headline2,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: SizedBox(
                height: 300,
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 0.9),
                    children: [
                      Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        padding: EdgeInsets.only(bottom: 15),
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
                            Image.asset('assets/container1.png', height: 35,),
                            SizedBox(height: 10,),
                            Text('120 ml.', style: Theme.of(context).textTheme.subtitle1,)
                          ]
                        ),
                      ),
                      Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        padding: EdgeInsets.only(bottom: 15),
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
                            Image.asset('assets/container2.png', height: 50,),
                            SizedBox(height: 10,),
                            Text('200 ml.', style: Theme.of(context).textTheme.subtitle1,)
                          ]
                        ),
                      ),
                      Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        padding: EdgeInsets.only(bottom: 15),
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
                            Image.asset('assets/container3.png', height: 60,),
                            SizedBox(height: 7,),
                            Text('350 ml.', style: Theme.of(context).textTheme.subtitle1,)
                          ]
                        ),
                      ),
                      Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        padding: EdgeInsets.only(bottom: 12),
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
                            Image.asset('assets/container4.png', height: 55,),
                            SizedBox(height: 10,),
                            Text('750 ml.', style: Theme.of(context).textTheme.subtitle1,)
                          ]
                        ),
                      ),
                      Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        padding: EdgeInsets.only(bottom: 12),
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
                            Image.asset('assets/container5.png', height: 60,),
                            SizedBox(height: 8,),
                            Text('1000 ml.', style: Theme.of(context).textTheme.subtitle1,)
                          ]
                        ),
                      ),
                      Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        padding: EdgeInsets.only(bottom: 15),
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
                            Image.asset('assets/container2.png', height: 50,),
                            SizedBox(height: 7,),
                            Icon(Icons.add_rounded, size: 20,)
                          ]
                        ),
                      ),
                    ]
                  ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: DropdownButton(
                  isExpanded: true,
                  value: watertype,
                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                      color: kColorsGrey),
                  elevation: 3,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: kColorsGrey, ),
                  items: type.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text(value, textAlign: TextAlign.center,)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      watertype = value.toString();
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                hintText: 'other',
                ),
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                suffixText: 'ml.',
                suffixStyle: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: NeumorphicButton(
              style: NeumorphicStyle(
                color: Colors.white,
                shape: NeumorphicShape.flat,
                depth: 5,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: Center(
                child: Text(
                  "add",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              onPressed: () {
                setState(() {

                });
              },
        ),
            ),
          ],
        ),
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
        elevation: 20,
      ),
    );
  }
}
