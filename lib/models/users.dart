import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users{
  String id;
  String name;
  String surname;
  String gender;
  String eMail;
  String dateOfBirth;

  Users({this.id,this.name,this.surname,this.gender,this.eMail,this.dateOfBirth});

  factory Users.fromSnapshot(DocumentSnapshot snapshot){
    return Users(
        id: snapshot.id,
        name: snapshot["name"],
        surname: snapshot["surName"],
        gender: snapshot["gender"],
        eMail: snapshot["email"],
        dateOfBirth: snapshot["dateOfBirth"]
    );
  }

  factory Users.firebasedenuret(User users) {
    return Users(
      id: users.uid,
      name: users.displayName,
      eMail: users.email
    );
  }

  factory Users.dokumandanuret(DocumentSnapshot users) {
    return Users(
      id: users.id,
      name: users.data()['name'],
      eMail: users.data()['email'],
    );
  }
}