import 'dart:developer';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/themes/colors.dart';
import 'package:provider/provider.dart';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int visit = 4;
  String? email, password;
  final formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 40),
                  CreateEmail(),
                  SizedBox(height: 30),
                  CreatePassword(),
                  SizedBox(height: 50),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
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
                          "Login",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      onPressed: () {
                        loginHandle(context: context);
                      },
                    ),
                  ),
                  
                  SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account yet?'),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text('Register',
                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: kColorsBlue),)),
                    ],
                  )
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }

  Future<void> loginHandle({required BuildContext context}) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      showDialog(
          context: context,
          builder: ((context) => Center(
                child: CircularProgressIndicator(strokeWidth: 4),
              )));

      try {
        await authService.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/profile', (route) => false);
      } on FirebaseAuthException catch (e) {
        log(e.message!);
        Navigator.pop(context);
      }
    }
  }

  CreateEmail() {
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

  CreatePassword() {
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

}

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

