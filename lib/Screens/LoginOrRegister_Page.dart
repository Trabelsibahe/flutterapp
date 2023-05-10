import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_voiture/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class LoginOrRegisterPage extends StatelessWidget {
  LoginOrRegisterPage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Widget _title() {
    return const Text('Welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color(0xff1f005c),
                Color(0xff5b0060),
                Color(0xff870160),
                Color(0xffac255e),
                Color(0xffca485c),
                Color(0xffe16b5c),
                Color(0xfff39060),
                Color(0xffffb56b),
              ],
              tileMode: TileMode.mirror,
            ),),
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Text("Welcome", style: TextStyle(fontSize: 33),)),
            SizedBox(
              child: Text("Bienvenue", style: TextStyle(fontSize: 22),),),
            Image.asset("assets/images/logo1.png"),
            SizedBox(
              height:40,
              width:250,
              child:
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, '/register');

              },
                child:Text("Register"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.black,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),),),
            SizedBox(height: 20),
            Text("Already have an account?"),
            SizedBox(height: 10,),
            SizedBox(
              height:40,
              width:200,
              child:
              OutlinedButton(onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
                child:Text("Login"),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}