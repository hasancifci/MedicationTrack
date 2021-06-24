import 'package:cloud_firestore/cloud_firestore.dart';

class Medications{
  String id;
  String name;
  double scale;
  int unit;
  String alarm;
  int remaning;
  DocumentReference reference;

  Medications({this.id,this.name,this.scale,this.unit,this.alarm,this.remaning});

  factory Medications.fromSnapshot(DocumentSnapshot snapshot){
    return Medications(
      id: snapshot.id,
      name: snapshot["name"],
      scale: snapshot["scale"],
      unit: snapshot["unit"],
      alarm: snapshot["alarm"],
      remaning: snapshot["remaning"],
    );
  }
  Medications.fromMap(Map<String, dynamic> map)
      : assert(map["name"] != null),
        assert(map["scale"] != null),
        assert(map["unit"] != null),
        assert(map["alarm"] != null),
        assert(map["remaning"] != null),
        name = map["name"],
        scale = map["scale"],
        unit = map["unit"],
        alarm = map["alarm"],
        remaning = map["remaning"];
}