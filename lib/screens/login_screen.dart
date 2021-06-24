import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ilac_takip_sistemi/service/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State {
  String mesaj = "İLAÇ TAKİP OTOMASYONU - GİRİŞ";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(mesaj, style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildAppLogo(),
              buildEMailField(),
              buildPasswordField(),
              buildLoginButtonField(),
            ],
          ),
        ));
  }

  buildAppLogo() {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: Container(
        width: 200,
        child: CircleAvatar(
          radius: 75,
          backgroundImage: NetworkImage(
              "https://cdn.pixabay.com/photo/2018/09/13/02/17/pills-3673645_960_720.jpg"),
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

  buildEMailField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: "E-Mail : "),
      ),
    );
  }

  buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Şifre : ',
        ),
      ),
    );
  }

  Widget buildLoginButtonField() {
    return SizedBox(
      width: 375.0,
      child: RaisedButton(
        child: const Text("G İ R İ Ş    Y A P"),
        color: Colors.greenAccent,
        elevation: 4.0,
        splashColor: Colors.green[100],
        onPressed: () {
          goToHomeScrenn();
        },
      ),
    );
  }

  void goToHomeScrenn() {
    _authService.signIn(_emailController.text, _passwordController.text).then((value){
      return Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
