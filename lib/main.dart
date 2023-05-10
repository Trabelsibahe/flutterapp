import 'package:location_voiture/Screens/LoginOrRegister_Page.dart';
import 'package:location_voiture/Screens/car_list.dart';
import 'package:location_voiture/Screens/home_page.dart';
import 'package:location_voiture/Screens/image_list.dart';
import 'package:location_voiture/Screens/login_page.dart';
import 'package:location_voiture/Screens/register_page.dart';
import 'package:location_voiture/Services/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/',
      routes: {
        '/login': (context) =>  const LoginPage(),
        '/register': (context) =>  const RegisterPage(),
        '/home': (context) =>  HomePage(),
        '/welcome' : (context) => LoginOrRegisterPage(),
        '/carlist' : (context) => CarList(),
        '/images': (context) => ImageList()

      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 180, 0, 0)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 180, 0, 0)


          ),
        ),      ),
      home: const WidgetTree(),
    );
  }
}
