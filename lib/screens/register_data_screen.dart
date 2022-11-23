import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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

enum Gender { MALE, FEMALE }

class _RegisterDataScreenState extends State<RegisterDataScreen> {
  int visit = 4;
  String dropdownValue = list.first;
  User? user;
  double age = 20;
  late Gender gender = Gender.MALE;

  TimeOfDay input_waketime = TimeOfDay(hour: 06, minute: 00);
  TimeOfDay input_bedtime = TimeOfDay(hour: 22, minute: 00);
  TextEditingController bedtimeInput = TextEditingController();
  TextEditingController waketimeInput = TextEditingController();

  @override
  void initState() {
    bedtimeInput.text = ""; //set the initial value of text field
    waketimeInput.text = ""; //set the initial value of text field
    // gender = Gender.MALE;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authservice = Provider.of<AuthService>(context, listen: false);
      User? newUser = await authservice.currentUser();
      setState(() {
        user = newUser;
        user!.gender = 'Men';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
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
          SizedBox(height: 20),
          Center(
            child: Text(
              'Set up your data',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: 20),
          // Center(
          //   child: DropdownButton<String>(
          //     value: dropdownValue,
          //     icon: const Icon(Icons.keyboard_arrow_down_rounded),
          //     elevation: 16,
          //     style: const TextStyle(color: kColorsGrey),
          //     underline: Container(
          //       height: 0.5,
          //       color: kColorsGrey,
          //     ),
          //     onChanged: (String? value) {
          //       // This is called when the user selects an item.
          //       setState(() {
          //         dropdownValue = value!;
          //         user!.gender = value;
          //       });
          //     },
          //     items: list.map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          _GenderField(
            gender: gender,
            onChanged: (gender) {
              setState(() {
                this.gender = gender;
              });
            },
          ),

          SizedBox(height: 5),
          _AgeField(
            user: user,
            age: age,
            onChanged: (value) {
              setState(() {
                age = value;
              });
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 35.0, right: 35.0),
          //   child: TextFormField(
          //     inputFormatters: <TextInputFormatter>[
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //     keyboardType: TextInputType.number,
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: 'Age',
          //     ),
          //     onChanged: (String value) {
          //       user!.age = int.parse(value);
          //     },
          //   ),
          // ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: _TextField(
              label: "Favorite Container (ml.)",
              hint: "",
              onChanged: (value) {
                setState(() {
                  user.favContainer = double.parse(value);
                });
              },
            ),
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: _TextField(
              label: "Height (cm.)",
              hint: "",
              onChanged: (value) {
                setState(() {
                  user.height = int.parse(value);
                });
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: _TextField(
              label: "Weight (kg.)",
              hint: "",
              onChanged: (value) {
                setState(() {
                  user.weight = int.parse(value);
                });
              },
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Text('Wake Up Time',
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Neumorphic(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
                  style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.stadium(),
                      color: Colors.grey[50]),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    controller: waketimeInput,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.timer,
                      ), //icon of text field
                      border: InputBorder.none,
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
                            DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          waketimeInput.text =
                              formattedTime; //set the value of text field.
                          user.waketime = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Text('Bed Time',
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Neumorphic(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
                  style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.stadium(),
                      color: Colors.grey[50]),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    controller: bedtimeInput,
                    decoration: InputDecoration(
                      icon: Icon(Icons.timer), //icon of text field
                      border: InputBorder.none,
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
                            DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          bedtimeInput.text =
                              formattedTime; //set the value of text field.
                          user.bedtime = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120.0),
            child: NeumorphicButton(
              style: NeumorphicStyle(
                color: Colors.grey[50],
                shape: NeumorphicShape.flat,
                depth: 5,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Let\'s start',
                      style: Theme.of(context).textTheme.headline3),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_right_alt_rounded,
                  )
                ],
              )),
              onPressed: () {
                user.target = user.weight! * 2.2 * 0.5 * 29.5735;
                user.lastLogin = DateTime.now().toString();
                startButtonHandle(uid: user.uid, user: user);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ),
          SizedBox(height: 70),
        ]),
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
    // Navigator.pushReplacementNamed(context, '/home', arguments: user);
  }
}

/* Text Field Style */
class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  _TextField(
      {required this.label, required this.hint, required this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
          child: Text(this.widget.label,
              style: Theme.of(context).textTheme.subtitle1),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
              depth: NeumorphicTheme.embossDepth(context),
              boxShape: NeumorphicBoxShape.stadium(),
              color: Colors.grey[50]),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.widget.hint),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter";
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}

/* Text Field Style (time) */
class _TextTimeField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  _TextTimeField(
      {required this.label, required this.hint, required this.onChanged});

  @override
  __TextTimeFieldState createState() => __TextTimeFieldState();
}

class __TextTimeFieldState extends State<_TextTimeField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
          child: Text(this.widget.label,
              style: Theme.of(context).textTheme.subtitle1),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
              depth: NeumorphicTheme.embossDepth(context),
              boxShape: NeumorphicBoxShape.stadium(),
              color: Colors.grey[50]),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextFormField(
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.widget.hint),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter";
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}

/* Age Style */

class _AgeField extends StatelessWidget {
  User? user;
  final double age;
  final ValueChanged<double> onChanged;

  _AgeField({required User user, required this.age, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: Text(
            "Age",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: NeumorphicSlider(
                  min: 0,
                  max: 150,
                  height: 12,
                  value: this.age,
                  onChanged: (value) {
                    this.onChanged(value);
                    user!.age = value.toInt();
                  },
                ),
              ),
            ),
            Text(
              "${this.age.floor()}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

/* Gender Field */
class _GenderField extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const _GenderField({
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Gender",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NeumorphicRadio(
              groupValue: gender,
              padding: EdgeInsets.all(20),
              style: NeumorphicRadioStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  selectedColor: Colors.grey[50],
                  unselectedColor: Colors.grey[50]),
              value: Gender.MALE,
              child: Icon(Icons.man_rounded),
              onChanged: (value) => onChanged(value!),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: gender,
              padding: EdgeInsets.all(20),
              style: NeumorphicRadioStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  selectedColor: Colors.grey[50],
                  unselectedColor: Colors.grey[50]),
              value: Gender.FEMALE,
              child: Icon(Icons.woman_rounded),
              onChanged: (value) => onChanged(value!),
            ),
          ],
        ),
      ],
    );
  }
}
