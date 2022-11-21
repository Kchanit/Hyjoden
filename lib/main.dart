import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hyjoden/route.dart';
import 'package:hyjoden/services/auth_service.dart';
import 'package:hyjoden/services/database_service.dart';
import 'package:hyjoden/services/storage_service.dart';
import 'package:hyjoden/themes/style.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      child: Text(
        'Error: ${details.exception}',
        style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  };
  runApp(MyApp());
}

final messageKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (_) => DatabaseService()),
        Provider<StorageService>(create: (_) => StorageService()),
        ProxyProvider<DatabaseService, AuthService>(
            update: (_, dbService, __) => AuthService(dbService: dbService)),
      ],
      
      child: MaterialApp(
        scaffoldMessengerKey: messageKey,
        debugShowCheckedModeBanner: false,
        // theme: appTheme(),
      //   theme: NeumorphicThemeData(
      //   baseColor: Color(0xFFFFFFFF),
      //   lightSource: LightSource.topLeft,
      //   depth: 10,
      // ),
      // home: MotionTabBarScreen(),
        theme: appTheme(),
        initialRoute: "/home",
        routes: routes,
      ),
    );
  }
}
