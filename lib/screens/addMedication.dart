import 'package:flutter/material.dart';
import 'package:ilac_takip_sistemi/screens/home_screen.dart';
import 'package:ilac_takip_sistemi/screens/medicationList.dart';
import 'package:ilac_takip_sistemi/service/medications_service.dart';

class AddMedicationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMedicationScreenState();
  }
}

class AddMedicationScreenState extends State {
  String mesaj = "İLAÇ EKLE";
  TimeOfDay _time;
  String dosage,timeInterval,unit;

  MedicationsService _medicationsService = MedicationsService();

  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
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
          items: ["0.5", "1", "1.5", "2", "2.5", "3"]
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
          value: timeInterval,
          items: ["1", "2", "3", "4 "]
              .map((label) => DropdownMenuItem(
            child: Text(label),
            value: label,
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              timeInterval = value;
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
            child: const Text("K A Y D E T"),
            color: Colors.greenAccent,
            elevation: 4.0,
            splashColor: Colors.green[100],
            onPressed: () {
              addMedication();
            },
          ),
        )
      ],
    );
  }

  void goToHomeScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void addMedication() {
    String alarm = "${_time.hour}:${_time.minute}";
    _medicationsService.addMedications(_nameController.text, int.parse(dosage), int.parse(timeInterval),alarm);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationListScreen()));

  }
}
