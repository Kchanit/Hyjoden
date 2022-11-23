import 'dart:developer';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 140.0),
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
                            Text('Next',
                                style: Theme.of(context).textTheme.headline3),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_right_alt_rounded,)
                          ],
                        )
                      ),
                      onPressed: () {
                        registerHandle(
                            context: context,
                          );
                      },
                    ),
                  ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }

  Widget CreateEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: _TextField(
        label: "email",
        hint: "",
        onChanged: (value) {
          email = value;
        },
      ),
    );
  }

  Widget CreateUsername() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: _TextField(
        label: "username",
        hint: "",
        onChanged: (value) {
          username = value;
        },
      ),
    );
  }

  Widget CreatePassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: _TextField(
        label: "password",
        hint: "",
        onChanged: (value) {
          password = value;
        },
      ),
    );
  }

  Widget CreateConfirmPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: _TextField(
        label: "confirm password",
        hint: "",
        onChanged: (value) {
          confirmPassword = value;
        },
      ),
    );
  }

  Future<void> registerHandle(
      {required BuildContext context, User? user}) async {
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
        authService.currentUser().then((currentUser) {
          setState(() {
            user = currentUser;
          });
          Navigator.pushReplacementNamed(context, '/register-data',
              arguments: user);
        });
      } on auth.FirebaseAuthException catch (e) {
        log(e.message!);
        showSnackBar(e.message);
        Navigator.of(context).pop();
      }
    }
  }
}

/* Text Field Style */
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


