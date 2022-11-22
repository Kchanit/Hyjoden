import 'dart:developer';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:hyjoden/services/auth_service.dart';
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
          child: Column(children: [
            SizedBox(height: 35),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 30),
            CreateEmail(),
            SizedBox(height: 30),
            CreatePassword(),
            SizedBox(height: 40),
            InkWell(
                onTap: () {
                  loginHandle(context: context);
                },
                child: Text('Login',
                    style: Theme.of(context).textTheme.headline3)),
            SizedBox(height: 40),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Register',
                    style: Theme.of(context).textTheme.headline3))
          ]),
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
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } on FirebaseAuthException catch (e) {
        log(e.message!);
        Navigator.pop(context);
      }
    }
  }

  CreateEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Email',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your email";
          }
          return null;
        },
        onChanged: (value) {
          email = value;
        },
      ),
    );
  }

  CreatePassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Password',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your password";
          }
          return null;
        },
        onChanged: (value) {
          password = value;
        },
      ),
    );
  }
}
