import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/models/medications.dart';
import 'package:ilac_takip_sistemi/screens/home_screen.dart';
import 'package:ilac_takip_sistemi/screens/medicationList.dart';
import 'package:ilac_takip_sistemi/service/medications_service.dart';

class MedicationDetailsScreen extends StatefulWidget {
  DocumentSnapshot medications;
  MedicationDetailsScreen(this.medications);
  @override
  State<StatefulWidget> createState() {
    return MedicationDetailsScreenStateState(medications);
  }
}

class MedicationDetailsScreenStateState extends State {

  DocumentSnapshot medications;
  MedicationDetailsScreenStateState(this.medications);
  String mesaj = "İLAÇ GÜNCELLE";
  TimeOfDay _time;
  String dosage,timeInterval,unit;

  MedicationsService _medicationsService;

  TextEditingController _nameController = TextEditingController();



  @override
  void initState() {
    _medicationsService = new MedicationsService();
    final medication = Medications.fromSnapshot(medications);
    _nameController.text = medication.name;
    dosage  = medication.scale.toString();
    unit = medication.unit.toString();
    super.initState();
    _time = TimeOfDay.now();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(mesaj, style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        buildMedicationNameField(),
                        buildMedicationDosageField(),
                        buildMedicationTimeIntervalField(),
                        buildMedicationTimeField(),
                        buildMedicationSaveButtonField(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildMedicationNameField() {
    return Row(
      children: [
        Flexible(
          child: Text("İlaç Adı : "),
        ),
        SizedBox(width: 10,),
        Flexible(
          child: TextFormField(
            controller: _nameController,
          ),
        )
      ],
    );
  }

  Widget buildMedicationDosageField() {
    return Row(
      children: [
        Text("Ölçek : "),
        SizedBox(width: 10.0,),
        DropdownButton(
          value: dosage,
          items: ["0.5", "1.0", "1.5", "2.0", "2.5", "3.0"]
              .map((label) => DropdownMenuItem(
            child: Text(label),
            value: label,
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              dosage = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildMedicationTimeField() {
    return Row(
      children: [
        Flexible(
          child: Text("Alarm : "),
        ),
        Flexible(
          child: ListTile(
            title: Text("${_time.hour}:${_time.minute}"),
            onTap: pickTime ,
          ),
        )
      ],
    );
  }

  void pickTime() async{
    TimeOfDay time = await showTimePicker(context: context, initialTime: _time,
        builder: (BuildContext context, Widget child){
          return Theme(data: ThemeData(
            primaryColor: Colors.greenAccent,
            accentColor: Colors.greenAccent,
          ), child: child);
        }
    );
    if(_time != null)
      setState(() {
        _time = time;
      });
  }

  Widget buildMedicationTimeIntervalField() {
    return Row(
      children: [
        Text("Adet(1 Günde x Tane) : "),
        SizedBox(width: 10.0,),
        DropdownButton(
          value: unit,
          items: ["1", "2", "3", "4 "]
              .map((label) => DropdownMenuItem(
            child: Text(label),
            value: label,
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              unit = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildMedicationSaveButtonField() {
    return Row(
      children: [
        SizedBox(
          width: 165,
          child: RaisedButton(
            child: const Text("İ P T A L"),
            color: Colors.greenAccent,
            elevation: 4.0,
            splashColor: Colors.green[100],
            onPressed: () {
              goToHomeScreen();
            },
          ),
        ),
        SizedBox(width: 25.0,),
        SizedBox(
          width: 165,
          child: RaisedButton(
            child: const Text("G Ü N C E L L E"),
            color: Colors.greenAccent,
            elevation: 4.0,
            splashColor: Colors.green[100],
            onPressed: () {
              updateMedication();
            },
          ),
        )
      ],
    );
  }

  void goToHomeScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void updateMedication() {

  }
}
