import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ilac_takip_sistemi/models/medications.dart';
import 'package:ilac_takip_sistemi/screens/account_screen.dart';
import 'package:ilac_takip_sistemi/screens/addMedication.dart';
import 'package:ilac_takip_sistemi/screens/medicationDetails.dart';
import 'package:ilac_takip_sistemi/screens/medicationList.dart';
import 'package:ilac_takip_sistemi/screens/report_screen.dart';
import 'package:ilac_takip_sistemi/service/medications_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenScreenState();
  }
}

enum Options { hesabim, ayarlar }

class HomeScreenScreenState extends State {
  String mesaj = "İLAÇ TAKİP OTOMASYONU";
  FlutterLocalNotificationsPlugin fltrNotification;
  MedicationsService _medicationsService = MedicationsService();
  DocumentSnapshot medications;
  CollectionReference _firestore = FirebaseFirestore.instance.collection('medications');
  var medica;

  @override
  void initState() {
    Future<List<Medications>> searchMedication() async{
      List<Medications> query = [];
      QuerySnapshot result = await FirebaseFirestore.instance.collection("medications").get();
      query = result.docs.map((e) => Medications.fromMap(e.data())).toList();

      var year = DateTime.now().year.toString();
      var month = "06";
      var day = DateTime.now().day.toString();
      var date =(year + "-" + month + "-" + day);

      var androidInitilize = AndroidInitializationSettings('app_icon');
      var iOSinitilize = IOSInitializationSettings();
      var initilizationsSettings = InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
      fltrNotification = FlutterLocalNotificationsPlugin();
      fltrNotification.initialize(initilizationsSettings,
          onSelectNotification: notificationSelected);

      var androidDetails = AndroidNotificationDetails("Channel ID", "Medication Track",
          "This is my channel", importance: Importance.max);
      var iOSDetails = IOSNotificationDetails();
      var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iOSDetails);


      for(int i=0; i<query.length; i++){
        var units = (24/query[i].unit).toInt();
        var scheduledTime = DateTime.parse(date + " "+query[i].alarm.toString()+":00Z");
        fltrNotification.schedule(i+1, "İLAÇ VAKTİ", query[i].name +" ilacınızın vakti geldi!", scheduledTime, generalNotificationDetails);
        await _firestore.doc("mJ0VB157dNaSt1TddVeq").update({'remaning':query[i].remaning - 1});

      }


    }
    searchMedication();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.hesabim,
                child: Text("Hesabım"),
              ),
              PopupMenuItem<Options>(
                value: Options.ayarlar,
                child: Text("Ayarlar"),
              ),
            ],
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        title: Text(mesaj, style: TextStyle(color: Colors.black)),
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: StreamBuilder(
              stream: _medicationsService.getMedications(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mypost = snapshot.data.docs[index];
                          medica = Medications.fromSnapshot(mypost);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: (ListTile(
                                title: new Text(mypost['name']),
                                subtitle: new Text(
                                  mypost['alarm'],
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                trailing: new Icon(Icons.alarm),
                                onTap: () {
                                  goToMedicationDetails(mypost);
                                },
                              )),
                            ),
                          );
                        },
                      );
              },
            )),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    Icon(Icons.alarm_on),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: [Text("Hatırlatma"), Text("Ekle")],
                    ),
                  ],
                ),
                onPressed: () {
                  goToMedicationAddScreen();
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      children: [Text("İlaç"), Text("Listesi")],
                    ),
                  ],
                ),
                onPressed: () {
                  goToMedicationListScreen();
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                  color: Colors.greenAccent,
                  child: Row(
                    children: [
                      Icon(Icons.stacked_line_chart),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [Text("Rapor"), Text("İstatistik")],
                      ),
                    ],
                  ),
                  onPressed: () {
                    goToReportScreen();
                  }),
            ),
          ],
        ),
      ],
    );
  }

  void selectProcess(Options options) {
    switch (options) {
      case Options.hesabim:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AccountScreen()));
        break;
      default:
    }
  }

  void goToMedicationAddScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddMedicationScreen()));
  }

  void goToMedicationListScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MedicationListScreen()));
  }

  void goToMedicationDetails(DocumentSnapshot mypost) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MedicationDetailsScreen(mypost)));
  }

  void goToReportScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReportScreen()));
  }


  Future notificationSelected(String payload) async{

    showDialog(context: context, builder: (context)=> AlertDialog(
      content: Text("İLAÇ VAKTİNİZ GELDİ!"),
      actions: [
        RaisedButton(child: Text("TAMAM"),onPressed: (){},),
        RaisedButton(child: Text("ERTELE"),onPressed: (){},)
      ],
    ));
  }
}
