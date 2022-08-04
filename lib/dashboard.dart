import 'package:flutter/material.dart';
import 'package:rsudbumiayu/beranda.dart';
import 'package:rsudbumiayu/isidatapasien.dart';
import 'antrianpasien.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  IniDashboard createState() => IniDashboard();
}

class IniDashboard extends State<Dashboard> {
  int tabPilih = 0;

  @override
  Widget build(BuildContext context) {
    final isiTab = <Widget>[
      const Beranda(),
      const IsiDataPasien(),
      const Wantrian(),
    ];

    final daftarTab = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.home), label: 'Beranda'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.create_rounded), label: 'Isi Data'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number), label: 'Antrian'),
    ];
    assert(isiTab.length == daftarTab.length);
    final bottomBar = BottomNavigationBar(
      items: daftarTab,
      currentIndex: tabPilih,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          tabPilih = index;
        });
      },
    );

    return Scaffold(
      body: isiTab[tabPilih],
      bottomNavigationBar: bottomBar,
    );
  }
  
}
