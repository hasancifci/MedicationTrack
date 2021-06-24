import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/service/auth.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountScreenState();
  }
}

class AccountScreenState extends State {
  String mesaj = "HESABIM";
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(mesaj, style: TextStyle(color: Colors.black)),
        ),
        body: buildBody(context)
        );

  }

  buildBody(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _authService.getUsers(),
            builder: (context, snapshot){
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index){
                  DocumentSnapshot mypost = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child:(
                        new Text(mypost['name'])
                      ),

                    ),
                  );

                },
              );
            },
          ),
        ),
      ],
    );
  }
}