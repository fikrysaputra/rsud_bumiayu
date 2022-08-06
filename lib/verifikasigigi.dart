// ignore_for_file: unused_local_variable, avoid_print, non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rsudbumiayu/dashboard.dart';

import 'antrianpoligigi.dart';
import 'auth.dart';

class VerifikasiGigi extends StatefulWidget {
  static bool jenis = false;
  static String poli = "";
  static String id = "";
  const VerifikasiGigi({Key? key}) : super(key: key);

  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<VerifikasiGigi> {
  TextEditingController hp = TextEditingController();
  TextEditingController tgl = TextEditingController();
  String no = "";
  String tanggal = "";
  CollectionReference verifgigi =
      FirebaseFirestore.instance.collection('VerifikasiPasienGigi');

  Future<void> lanjut() async {
 return verifgigi
        .doc(email)
        .set({
          'hp': hp.text,
          'tgl': tgl.text,
          'no': no,
          'tanggal': tanggal,
        })
        .then((value) => print("Data ditambahkan"))
        .catchError((error) => print("Gagal menambahkan: $error"));
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff406882),
        shadowColor: const Color(0xff406882),
        elevation: 0,
        title: const Text("Langkah 4/4"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Dashboard()),
              (Route<dynamic> route) => false),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff406882),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 100,
                width: 100,
                child: Icon(Icons.checklist_rounded),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "SELANGKAH LAGI",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Kami membutuhkan nomor kontak untuk memverifikasi pendaftaran Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Nomor Kontak",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: TextField(
                          controller: hp,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 12)),
                          ),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Tanggal Kunjungan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: TextField(
                          controller: tgl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 12),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 3)));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("EEE, d MMMM y", "id_ID")
                                      .format(pickedDate);
                              setState(() {
                                tgl.text = formattedDate;
                                tanggal =
                                    DateFormat("y-MM-d").format(pickedDate);
                              });
                            }
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffE4CDA7),
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 5),
                        onPressed:  () {
                          lanjut();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const Poligigi();
                            },
                          ));
                        },
                        child: const Text(
                          "DAFTAR SEKARANG",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Pasien {
  static String nama = "";
  static String tempat = "";
  static String tgl_lahir = "";
  static String tglformat = "";
}
