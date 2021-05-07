import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/screens/addMedication.dart';
import 'package:ilac_takip_sistemi/service/medications_service.dart';

class MedicationListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MedicationListScreenState();
  }
}

class MedicationListScreenState extends State {
  String mesaj = "İLAÇ LİSTESİ";
  MedicationsService _medicationsService = MedicationsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(mesaj, style: TextStyle(color: Colors.black)),
        ),
        body: buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
        onPressed: (){goToMedicationAdd();},
        child: Icon(Icons.add),
        tooltip: "Yeni İlaç Ekle",
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: _medicationsService.getMedications(),
      builder: (context, snapshot){
        return !snapshot.hasData
            ? CircularProgressIndicator()
            : ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot mypost = snapshot.data.docs[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('İlaç Adı')),
                          DataColumn(label: Text('Ölçek')),
                          DataColumn(label: Text('Adet (24s)')),
                          DataColumn(label: Text('Saat')),
                        ],
                        rows: [
                          DataRow(
                              cells: [
                                DataCell(Text("${mypost['name']}")),
                                DataCell(Text("${mypost['scale']}")),
                                DataCell(Text("${mypost['unit']}")),
                                DataCell(Text("${mypost['alarm']}")),
                              ]
                          )
                        ],
                      ),
                    )
                ),
              ),
            );

          },
        );
      },
    );
  }

  void goToMedicationAdd() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicationScreen()));
  }
}