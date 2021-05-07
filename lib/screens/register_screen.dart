import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/screens/login_screen.dart';
import 'package:ilac_takip_sistemi/service/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State {
  String mesaj = "İLAÇ TAKİP OTOMASYONU - KAYIT";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birtofdayController = TextEditingController();
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
              //buildAppLogo(),
              buildEMailField(),
              buildNameField(),
              buildSurnamNameField(),
              buildGenderField(),
              buildBirtOfDayField(),
              buildPasswordField(),
              buildRegisterButtonField(),
            ],
          ),
        )
    );
  }

  buildAppLogo() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 200,
        child: CircleAvatar(
          radius: 50,
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
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
            labelText: "E-Mail : "),
      ),
    );
  }

  buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Şifre : ',
        ),
      ),
    );
  }

  buildNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
            labelText: "Ad : "),
      ),
    );
  }

  buildGenderField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
      child: TextFormField(
        controller: _genderController,
        decoration: InputDecoration(
            labelText: "Cinsiyet : "),
      ),
    );
  }

  buildBirtOfDayField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
      child: TextFormField(
        controller: _birtofdayController,
        decoration: InputDecoration(
            labelText: "Doğum Tarihi : "),
      ),
    );
  }

  Widget buildRegisterButtonField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 375.0,
        child: RaisedButton(
          child: const Text("K A Y I T    O L"),
          color: Colors.greenAccent,
          elevation: 4.0,
          splashColor: Colors.green[100],
          onPressed: () {
            goToLogin();
          },
        ),
      ),
    );
  }

  buildSurnamNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
      child: TextFormField(
        controller: _surnameController,
        decoration: InputDecoration(
            labelText: "Soyad : "),
      ),
    );
  }

  tarihSec(BuildContext context) {
    return showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2023),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  void goToLogin() {
    _authService.createUser(_emailController.text, _nameController.text, _surnameController.text, _genderController.text, _birtofdayController.text, _passwordController.text).then((value){
      return Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}