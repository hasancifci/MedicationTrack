import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/models/medications.dart';
import 'package:ilac_takip_sistemi/service/medications_service.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State {
  String mesaj = "Rapor - İstatistik";
  MedicationsService _medicationsService = MedicationsService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(mesaj, style: TextStyle(color: Colors.black)),
        ),
        body: buildBody(context));
  }



  buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("K A L A N   K U L L A N I M L A R I M",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
          ),
        ),
        Expanded(
          flex: 13,
          child: StreamBuilder(
            stream: _medicationsService.getMedications(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: (ListTile(
                        title: new Text(mypost['name']),
                        trailing: new Text(
                          mypost['remaning'].toString(),
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      )),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Future<List<Medications>> searchMedication() async {
    List<Medications> query = [];
    QuerySnapshot result = await FirebaseFirestore.instance.collection(
        "medications").get();
    query = result.docs.map((e) => Medications.fromMap(e.data())).toList();

  }

}
