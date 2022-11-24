import 'dart:math';

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
import 'package:hyjoden/utils/showSnackBar.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int visit = 4;

  User? user;
  bool _ageVisible = false;
  bool _weightVisible = false;
  bool _heightVisible = false;
  bool _favVisible = false;
  bool _bedVisible = false;
  bool _wakeVisible = false;


  TimeOfDay input_waketime = TimeOfDay(hour: 06, minute: 00);
  TimeOfDay input_bedtime = TimeOfDay(hour: 22, minute: 00);
  TextEditingController bedtimeInput = TextEditingController();
  TextEditingController waketimeInput = TextEditingController();


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
                            color: kColorsBlue,
                            lightSource: LightSource.topLeft,
                            shape: NeumorphicShape.convex,
                            depth: 5,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                          child: Center(
                            child: Icon(Icons.edit_off_rounded, color: kColorsWhite,)
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/profile');
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                _weightVisible = true;
                              });
                            },
                            child: Text('${user!.weight} kg', 
                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, 
                              color: kColorsBlue),)),
                          SizedBox(height: 15,),
                          Text('Bed Time :', style: Theme.of(context).textTheme.subtitle2,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _bedVisible = true;
                              });
                            },
                            child: Text('${user!.bedtime}', 
                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, 
                              color: kColorsBlue),)),
                          SizedBox(height: 15,),
                          Text('Goal :', style: Theme.of(context).textTheme.subtitle2,),
                          Text('${user!.target!.toInt()} ml', style: Theme.of(context).textTheme.headline3,),
                        ]),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age :', style: Theme.of(context).textTheme.subtitle2,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _ageVisible = true;       
                              });
                            },
                            child: Text('${user!.age}', 
                            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, 
                              color: kColorsBlue),
                            )
                          ),
                          SizedBox(height: 15,),
                          Text('Height :', style: Theme.of(context).textTheme.subtitle2,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _heightVisible = true;
                              });
                            },
                            child: Text('${user!.height} cm', 
                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, 
                              color: kColorsBlue),)),
                          SizedBox(height: 15,),
                          Text('Wake Up Time :', style: Theme.of(context).textTheme.subtitle2,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _wakeVisible = true;
                              });
                            },
                            child: Text('${user!.waketime}', 
                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, 
                              color: kColorsBlue),)),
                          SizedBox(height: 15,),
                          Text('Favorite Container :', style: Theme.of(context).textTheme.subtitle2,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _favVisible = true;
                              });
                            },
                            child: Text('${user!.favContainer!.toInt()} ml', 
                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, 
                              color: kColorsBlue),)),
                        ]),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('*tap', style: Theme.of(context).textTheme.subtitle2,),
                    Text(' BLUE ', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: kColorsBlue),),
                    Text('text for choose EDIT', style: Theme.of(context).textTheme.subtitle2,),
                  ],
                ),

                SizedBox(height: 15,),
                Visibility(
                  visible: _ageVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _TextField(
                            label: "Age",
                            hint: "",
                            onChanged: (value) {
                              user!.age = int.parse(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                               _ageVisible = false;
                              });
                            }, 
                            icon: Icon(Icons.cancel_outlined, color: kColorsGrey,)),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Visibility(
                  visible: _weightVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _TextField(
                            label: "Weight",
                            hint: "",
                            onChanged: (value) {
                              user!.weight = int.parse(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                _weightVisible = false;
                              });
                            }, 
                            icon: Icon(Icons.cancel_outlined, color: kColorsGrey,)),
                        )
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 10,),
                Visibility(
                  visible: _heightVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _TextField(
                            label: "Height",
                            hint: "",
                            onChanged: (value) {
                              user!.height = int.parse(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                _heightVisible = false;
                              });
                            }, 
                            icon: Icon(Icons.cancel_outlined, color: kColorsGrey,)),
                        )
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 10,),
                Visibility(
                  visible: _favVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _TextField(
                            label: "Favorite Container",
                            hint: "",
                            onChanged: (value) {
                              user!.favContainer = double.parse(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                _favVisible = false;
                              });
                            }, 
                            icon: Icon(Icons.cancel_outlined, color: kColorsGrey,)),
                        )
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: _bedVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                          child: Text('Bed Time',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Neumorphic(
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
                                        user!.bedtime = formattedTime;
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ),
                            ),
                             IconButton(
                              onPressed: (){
                                setState(() {
                                  _bedVisible = false;
                                });
                              }, 
                              icon: Icon(Icons.cancel_outlined, color: kColorsGrey,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Visibility(
                  visible: _wakeVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                          child: Text('Wake Up Time',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Neumorphic(
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
                                        user!.waketime = formattedTime;
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                            onPressed: (){
                              setState(() {        
                                _wakeVisible = false;
                              });
                            }, 
                            icon: Icon(Icons.cancel_outlined, color: kColorsGrey,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 145.0, vertical: 70),
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
                        "Confirm",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    onPressed: () {
                      final databaseService = Provider.of<DatabaseService>(context, listen: false);
                       databaseService
                        .updateUserFromUid(uid: user!.uid, user: user!)
                        .then((value) {
                //success state
                showSnackBar('success', backgroundColor: Colors.green);
                    }).catchError((e) {
                      //handle error
                      showSnackBar(e, backgroundColor: Colors.red);
                    });
                    Navigator.pop(context, 'Ok');
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
}


/* text field */
class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  _TextField({required this.label, required this.hint, required this.onChanged});

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
          child: Text(
            this.widget.label,
            style: Theme.of(context).textTheme.subtitle1
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
            color: Colors.grey[50]
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
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