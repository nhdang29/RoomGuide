import 'package:flutter/material.dart';
import 'package:flutter_room_guide/screens/export_screens.dart';
import 'admin/admin_page.dart';
import 'admin/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'contrast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
        textTheme: kGoogleTextTheme
      ),
      routes: {
        "/": (context) => const HomePage(),
        FindRoomPage.routeName: (context) => const FindRoomPage(),
        AdminPage.routeName: (context) => const AdminPage(),
        LoginPage.routeName: (context) => const LoginPage()

      },
      initialRoute: "/",
    );
  }
}




