import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_voiture/Screens/home_page.dart';
import '../Services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      ).then((value) => {
        print ("Registerd."),
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false)
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Register Page');
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
      onPressed: createUserWithEmailAndPassword,
      child: Text('Register'),
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

  Widget _RegisterButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },

        child: Text('Login instead'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        SizedBox(child:Image.asset("assets/images/new.png")),
            _entryField('Email', _controllerEmail),
            _entryField('Password', _controllerPassword),
            SizedBox(height: 15,),
            _errorMessage(),
            SizedBox(height: 50,),


            SizedBox(width: 200, child:_submitButton()),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}