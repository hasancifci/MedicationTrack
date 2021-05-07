import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ilac_takip_sistemi/models/medications.dart';

class MedicationsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Veri Ekleme Fonksiyonu
  Future<void> addMedications(
      String name, int scale, int unit, String alarm) async {
    var ref = _firestore.collection("medications");

    var documentRef = await ref
        .add({'name': name, 'scale': scale, 'unit': unit, 'alarm': alarm});

    return Medications(
        id: documentRef.id, name: name, scale: scale, unit: unit, alarm: alarm);
  }

  // Veri Listeleme Fonksiyonu
  Stream<QuerySnapshot> getMedications(){
    var ref = _firestore.collection("medications").snapshots();
    return ref;
  }

  // Veri Silme Fonksiyonu
  Future<void> removeMedication(String docId){
    var ref = _firestore.collection("medications").doc(docId).delete();
    return ref;
  }
}
