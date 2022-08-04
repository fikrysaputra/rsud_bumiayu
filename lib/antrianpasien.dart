// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import './verifikasigigi.dart';
import 'package:rsudbumiayu/verifikasisyaraf.dart';

import 'dashboard.dart';

class Wantrian extends StatefulWidget {
  const Wantrian({Key? key}) : super(key: key);

  @override
  State<Wantrian> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Wantrian> {

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Pilih Antrian Pasien"),
              centerTitle: true,
              leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const Dashboard();
              },
            ));
          },
        ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2DA6AB),
                    Color(0xFF247EAA),
                  ],
                ),
              ),
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 20.0,),
                  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                  height: 50,
                  width: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return const VerifikasiGigi();
                      }), ModalRoute.withName('/verifgigi'));
                    },
                    child: const Center(
                      child: Text(
                        "Poliklinik Gigi",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                  ),
                  const SizedBox(height: 10.0,),
                  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                  height: 50,
                  width: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return const VerifikasiSyaraf();
                      }), ModalRoute.withName('/verifsyaraf'));
                    },
                    child: const Center(
                      child: Text(
                        "Poliklinik Syaraf",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                  ),
                ],
              ),
              ),
            );
  }
}
