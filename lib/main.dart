import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/screens/home_screen.dart';
import 'package:ilac_takip_sistemi/screens/login_screen.dart';
import 'package:ilac_takip_sistemi/screens/register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "İLAÇ TAKİP OTOMASYONU";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text(mesaj, style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          children: [
            buildAppLogo(),
            buildLoginButtonField(),
            buildRegisterButtonField(),
          ],
        ),
      ),
    );
  }

  buildAppLogo() {
    return Padding(
      padding: EdgeInsets.all(100.0),
      child: Container(
        width: 200,
        child: CircleAvatar(
          radius: 75,
          backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2018/09/13/02/17/pills-3673645_960_720.jpg"),
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: Colors.greenAccent,
            width: 4.0,
          ),
        ),
      ),
    );
  }


  Widget buildLoginButtonField() {
    return SizedBox(
      width: 300.0,
      child: RaisedButton(
        child: const Text("G İ R İ Ş    Y A P"),
        color: Colors.greenAccent,
        elevation: 4.0,
        splashColor: Colors.green[100],
        onPressed: () {goToLoginScreen();},
      ),
    );
  }

  Widget buildRegisterButtonField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 300.0,
        child: RaisedButton(
          child: const Text("K A Y I T    O L"),
          color: Colors.greenAccent,
          elevation: 4.0,
          splashColor: Colors.green[100],
          onPressed: () {goToRegisterScreen();},
        ),
      ),
    );
  }

  void goToLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  void goToRegisterScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
  }
}
