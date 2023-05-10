

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_voiture/Screens/LoginOrRegister_Page.dart';
import 'package:location_voiture/Screens/car_list.dart';
import 'package:location_voiture/Services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut().then((value) =>
    {
      print("Signed out."),
      Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false)
    });
  }


  Widget _title() {
    return const Text('Home Page');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  Widget _CarListButton(){
    return IconButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/carlist', (route) => false);
        },   icon: Image.asset("assets/images/cars.png"), iconSize: 250,


    );
  }

  Widget _ImageListButton(){
    return IconButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/images', (route) => false);
      }, icon: Image.asset("assets/images/gallery1.png"), iconSize: 250,);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        color: Color.fromRGBO(225, 225, 225, 1.0),

        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                  Text('Bienvenue ', style: TextStyle (fontSize: 16, fontWeight: FontWeight.bold),), _userUid(),
                  SizedBox(width: 20),
                  _signOutButton()
                ],
              ),
            ),
            SizedBox(
              child: _CarListButton()
            ),
            _ImageListButton()




          ],
        ),
      ),
    );

  }
}
