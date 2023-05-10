import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_voiture/Screens/home_page.dart';
import 'package:location_voiture/Screens/register_page.dart';
import '../Services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      ).then((value) {
        print("Logged in.");
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      });
    }  on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Widget _title() {
    return const Text('Login Page');
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(
            width: 2, color: Colors.black,),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        labelText: title, labelStyle:  TextStyle(color: Colors.black), hintText: title, hintStyle:  TextStyle(color: Colors.cyan),),
      style: TextStyle(color: Colors.red),
      keyboardType: TextInputType.text,
      obscureText: false,
    );
  }
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
        signInWithEmailAndPassword,
      child: Text('Login'),
      style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3)),
    primary: Colors.black,
    textStyle: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,),)
    );
  }

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);

      },
      child: Text('Register instead'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        color: Color.fromRGBO(225, 225, 225, 1.0),
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(child:Image.asset("assets/images/compte.png"),
              height: 200,width: 200, ),
            SizedBox(height: 50,),

            _entryField('Email', _controllerEmail),
            _entryField('Password', _controllerPassword),
            SizedBox(height: 15,),
            _errorMessage(),
            SizedBox(height: 50,),
            SizedBox(width: 200,child: _submitButton()),
            _loginButton(),
          ],
        ),
      ),
    );
  }
}