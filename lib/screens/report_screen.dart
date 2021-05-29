import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ilac_takip_sistemi/models/medications.dart';
import 'package:ilac_takip_sistemi/service/medications_service.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State {
  String mesaj = "Bildirim Deneme";

  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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


    //var scheduledTime = DateTime.now().add(Duration(seconds: 5));
    var scheduledTime = DateTime.parse("2021-05-29 11:47:00Z");

    fltrNotification.schedule(1, "İlaç Vakti", "'    ' isimli ilacınızın vakti geldi!", scheduledTime, generalNotificationDetails);

    MedicationsService _medicationsService = MedicationsService();
    List<Medications> medications;


  }

  Future _showNotification() async{
    var androidDetails = AndroidNotificationDetails("Channel ID", "Medication Track",
        "This is my channel", importance: Importance.max);
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iOSDetails);


    //var scheduledTime = DateTime.now().add(Duration(seconds: 5));
    var scheduledTime = DateTime.parse("2021-05-28 19:58:00Z");
    
    fltrNotification.schedule(1, "İlaç Vakti", "'    ' isimli ilacınızın vakti geldi!", scheduledTime, generalNotificationDetails);
  }

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

  Future notificationSelected(String payload) async {
    showDialog(context: context, builder: (context)=> AlertDialog(
      content: Text("İLAÇ VAKTİNİZ GELDİ!"),
      actions: [
        RaisedButton(child: Text("TAMAM"),),
        RaisedButton(child: Text("ERTELE"),)
      ],
    ));
  }

  buildBody(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: _showNotification,
        child: new Text("Notification Clicked"),
      ),
    );
  }
}
