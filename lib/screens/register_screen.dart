import 'dart:developer';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../utils/showSnackBar.dart';

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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int visit = 4;
  User? user;
  final formKey = GlobalKey<FormState>();

  String? username, email, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          children: [
            Column(children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 35),
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 30),
                    CreateUsername(),
                    SizedBox(height: 20),
                    CreateEmail(),
                    SizedBox(height: 20),
                    CreatePassword(),
                    SizedBox(height: 20),
                    CreateConfirmPassword(),
                    SizedBox(height: 40),
                    InkWell(
                        onTap: () {
                          registerHandle(context: context);
                          authService.currentUser().then((currentUser) {
                            setState(() {
                              user = currentUser;
                            });
                            Navigator.pushReplacementNamed(
                                context, '/register-data',
                                arguments: user);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Next',
                                style: Theme.of(context).textTheme.headline3),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_right_alt_rounded)
                          ],
                        ))
                  ],
                ),
              )
            ]),
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
      ),
    );
  }

  Widget CreateEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Email',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter email";
          }
          return null;
        },
        onChanged: (value) {
          email = value;
        },
      ),
    );
  }

  Widget CreateUsername() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Username',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter username";
          }
          return null;
        },
        onChanged: (value) {
          username = value;
        },
      ),
    );
  }

  Widget CreatePassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Password',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter password";
          }
          return null;
        },
        onChanged: (value) {
          password = value;
        },
      ),
    );
  }

  Widget CreateConfirmPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Confirm Password',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter password";
          }
          return null;
        },
        onChanged: (value) {
          confirmPassword = value;
        },
      ),
    );
  }

  Future<void> registerHandle({required BuildContext context}) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      showDialog(
          context: context,
          builder: ((context) => Center(
                child: CircularProgressIndicator(strokeWidth: 4),
              )));

      try {
        await authService.createUser(
          email: email,
          username: username,
          password: password,
        );
      } on auth.FirebaseAuthException catch (e) {
        log(e.message!);
        showSnackBar(e.message);
        Navigator.of(context).pop();
      }
    }
  }
}
