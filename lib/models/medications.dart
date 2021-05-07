import 'package:cloud_firestore/cloud_firestore.dart';

class Medications{
  String id;
  String name;
  int scale;
  int unit;
  String alarm;

  Medications({this.id,this.name,this.scale,this.unit,this.alarm});

  factory Medications.fromSnapshot(DocumentSnapshot snapshot){
    return Medications(
      id: snapshot.id,
      name: snapshot["name"],
      scale: snapshot["scale"],
      unit: snapshot["unit"],
      alarm: snapshot["alarm"]
    );
  }
}