import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Giriş Yapma Fonksiyonu
  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  // Çıkış Yapma Fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  getCurrentUser() async{
    final User user = _auth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  Stream<QuerySnapshot> getUsers(){
    var ref = _firestore.collection("users").snapshots();
    return ref;
  }

  // Kayıt Olma Fonksiyonu
  Future<User> createUser(String eMail, String name, String surName,
      String gender, String dateOfBirth, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: eMail, password: password);

    await _firestore.collection("users").doc(user.user.uid).set({
      'eMail': eMail,
      'name': name,
      'surName': surName,
      'gender': gender,
      'dateOfBirth': dateOfBirth
    });

    return user.user;
  }
}
