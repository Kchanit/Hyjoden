import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:hyjoden/services/auth_service.dart';
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

const List<String> list = <String>['Men', 'Women'];

class RegisterDataScreen extends StatefulWidget {
  const RegisterDataScreen({super.key});

  @override
  State<RegisterDataScreen> createState() => _RegisterDataScreenState();
}

class _RegisterDataScreenState extends State<RegisterDataScreen> {
  int visit = 4;
  String dropdownValue = list.first;
  User? user;
  TimeOfDay input_bedtime = TimeOfDay(hour: 22, minute: 00);
  TimeOfDay input_waketime = TimeOfDay(hour: 06, minute: 00);
  TextEditingController bedtimeInput = TextEditingController();
  TextEditingController waketimeInput = TextEditingController();

  @override
  void initState() {
    bedtimeInput.text = ""; //set the initial value of text field
    waketimeInput.text = ""; //set the initial value of text field
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authservice = Provider.of<AuthService>(context, listen: false);
      User? newUser = await authservice.currentUser();
      setState(() {
        user = newUser;
        user!.gender = 'Men';
      });
      print(user!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
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
        child: ListView(children: [
          SizedBox(height: 35),
          Center(
            child: Text(
              'Set up your data',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              elevation: 16,
              style: const TextStyle(color: kColorsGrey),
              underline: Container(
                height: 0.5,
                color: kColorsGrey,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                  user!.gender = value;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Age',
              ),
              onChanged: (String value) {
                user!.age = int.parse(value);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Favourite Container',
              ),
              onChanged: (String value) {
                user!.favContainer = double.parse(value);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Height',
              ),
              onChanged: (String value) {
                user!.height = int.parse(value);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Weight',
              ),
              onChanged: (value) {
                user!.weight = int.parse(value);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0),
              child: TextField(
                controller: waketimeInput,
                decoration: InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText: "Enter Wakeup Time" //label text of field
                    ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: input_waketime,
                    context: context,
                  );
                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.Hm()
                        .parse(pickedTime.format(context).toString());
                    //converting to DateTime so that we can further format on different pattern.
                    print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                    setState(() {
                      waketimeInput.text =
                          formattedTime; //set the value of text field.
                      user!.waketime = formattedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              )),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0),
              child: TextField(
                controller: bedtimeInput,
                decoration: InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText: "Enter Bed Time" //label text of field
                    ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: input_bedtime,
                    context: context,
                  );
                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.Hm()
                        .parse(pickedTime.format(context).toString());
                    //converting to DateTime so that we can further format on different pattern.
                    print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                    setState(() {
                      bedtimeInput.text =
                          formattedTime; //set the value of text field.
                      user!.bedtime = formattedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              )),
          SizedBox(height: 40),
          InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Let\'s start',
                  //     style: Theme.of(context).textTheme.headline3),
                  TextButton(
                    onPressed: (() {
                      startButtonHandle(uid: user!.uid, user: user);
                    }),
                    child: Text('Let\'s start '),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_right_alt_rounded)
                ],
              ))
        ]),
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
      ),
    );
  }

  startButtonHandle({required uid, required User? user}) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    databaseService.updateUserFromUid(uid: uid, user: user!).then((value) {
      //success state
      showSnackBar('success', backgroundColor: Colors.green);
    }).catchError((e) {
      //handle error
      showSnackBar(e, backgroundColor: Colors.red);
    });
    Navigator.pushReplacementNamed(context, '/home', arguments: user);
  }
}
