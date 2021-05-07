import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountScreenState();
  }
}

class AccountScreenState extends State {
  String mesaj = "HESABIM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(mesaj, style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: Text("KULLANICININ HESAP BİLGİLERİ BURADA OLACAK..."),
        )
    );
  }

  buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2017/05/15/21/58/drug-icon-2316244_960_720.png"),
                    ),
                    title: Text("Minoset"),
                    subtitle: Text("Saat 12:00"),
                    trailing: Icon(Icons.done),
                  );
                })),
      ],
    );
  }
}