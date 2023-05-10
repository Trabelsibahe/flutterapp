import 'package:flutter/cupertino.dart';
import 'package:location_voiture/Screens/register_page.dart';
import 'package:location_voiture/Services/auth.dart';
import 'package:location_voiture/Screens/home_page.dart';
import 'package:location_voiture/Screens/login_page.dart';
import '../Screens/LoginOrRegister_Page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginOrRegisterPage();
        }
      },
    );
  }
}