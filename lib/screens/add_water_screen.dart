import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyjoden/models/drink_model.dart';
import 'package:hyjoden/models/history_model.dart';
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:hyjoden/utils/showSnackBar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  User? user;
  int visit = 2;
  int selectedAmount = 100;
  String? watertype = 'Milk Tea';
  bool _visibleOther = false;
  bool _visibleCustom = false;
  int? _groupValue = 1;

  bool selectedComponent = false;
  Color _SelectedColor() {
    if (selectedComponent)
      return kColorsLightGrey;
    else {
      return Colors.white;
    }
  }

  List<String> type = [
    'Milk Tea',
    'Coke',
    'Sprite',
    'Orange Juice',
    'Coffee',
    'Green Tea',
    'other'
  ];
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
              child: Text(
                'Choose your drink',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: SizedBox(
                height: 300,
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.9),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            unselectedColor: Colors.grey[50],
                            selectedColor: Colors.grey[50],
                            lightSource: LightSource.topRight
                          ),
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            selectedAmount = 100;
                            setState(() {
                              _groupValue = value;
                              _visibleCustom = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/container1.png',
                                    height: 35,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '100 ml.',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            unselectedColor: Colors.grey[50],
                            selectedColor: Colors.grey[50],
                            lightSource: LightSource.topRight
                          ),
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            selectedAmount = 200;
                            setState(() {
                              _groupValue = value;
                              _visibleCustom = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/container2.png',
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '200 ml.',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            unselectedColor: Colors.grey[50],
                            selectedColor: Colors.grey[50],
                            lightSource: LightSource.topRight
                          ),
                          value: 3,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            selectedAmount = 350;
                            setState(() {
                              _groupValue = value;
                              _visibleCustom = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/container3.png',
                                    height: 60,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '350 ml.',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            unselectedColor: Colors.grey[50],
                            selectedColor: Colors.grey[50],
                            lightSource: LightSource.topRight
                          ),
                          value: 4,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            selectedAmount = 750;
                            setState(() {
                              _groupValue = value;
                              _visibleCustom = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/container4.png',
                                    height: 55,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '750 ml.',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            unselectedColor: Colors.grey[50],
                            selectedColor: Colors.grey[50],
                            lightSource: LightSource.topRight
                          ),
                          value: 5,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            selectedAmount = 1000;
                            setState(() {
                              _groupValue = value;
                              _visibleCustom = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/container5.png',
                                    height: 60,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '1000 ml.',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            unselectedColor: Colors.grey[50],
                            selectedColor: Colors.grey[50],
                            lightSource: LightSource.topRight
                          ),
                          value: 6,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                              _visibleCustom = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/container2.png',
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Icon(
                                    Icons.add_rounded,
                                    size: 20,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ]),
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
                    color: kColorsGrey,
                  ),
                  items: type.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                          child: Text(
                        value,
                        textAlign: TextAlign.center,
                      )),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      watertype = value.toString();
                      if (watertype == 'other') {
                        _visibleOther = true;
                      }
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Visibility(
                visible: _visibleOther,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your drink',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Visibility(
                visible: _visibleCustom,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your drinks volume',
                    suffixText: 'ml.',
                    suffixStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                  onChanged: (value) {
                    selectedAmount = int.parse(value);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
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
                    "add",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                onPressed: () {
                  user!.drinkAttempt = user!.drinkAttempt! + 1;
                  user!.todayDrink = user!.todayDrink! + selectedAmount;
                  user!.totalDrink = user!.totalDrink! + selectedAmount;
                  if (user!.todayDrink! >= user!.target!) {
                    user!.targetHit = user!.targetHit! + 1;
                  }

                  dialogHandle(uid: user!.uid, user: user!);
                  // addBtnHandle(uid: user!.uid, user: user!);
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

  dialogHandle({required uid, required User user}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Water'),
        content: Text('You drink ${selectedAmount} ml?'),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final databaseService =
                  Provider.of<DatabaseService>(context, listen: false);
              databaseService
                  .updateUserFromUid(uid: uid, user: user)
                  .then((value) {
                //success state
                showSnackBar('success', backgroundColor: Colors.green);
              }).catchError((e) {
                //handle error
                showSnackBar(e, backgroundColor: Colors.red);
              });
              createHistory();
              Navigator.pop(context, 'Ok');
              Navigator.pushReplacementNamed(context, '/home', arguments: user.todayDrink);
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  // addBtnHandle({required uid, required User user}) {
  //   final databaseService =
  //       Provider.of<DatabaseService>(context, listen: false);
  //   databaseService.updateUserFromUid(uid: uid, user: user);
  //   createHistory();
  // }

  createHistory() {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    var now = DateTime.now();
    String date = DateFormat.yMd().format(now).toString();
    String time = DateFormat.Hm().format(now).toString();
    final newDrink = Drink(amount: selectedAmount);
    final newHistory = History(amount: selectedAmount, date: date, time: time);
    databaseService.addHistory(history: newHistory, uid: user!.uid);
  }
}
