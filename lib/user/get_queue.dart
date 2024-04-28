import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puskesmas_cisadea/data/data_service.dart';
import 'package:puskesmas_cisadea/data/poli.dart';

class GetQueue extends StatelessWidget {
  final Poli poli;
  String allDoctor = '';
  TextEditingController rmController = TextEditingController();
  TextEditingController bpjsController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController ttlController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tujuanController = TextEditingController();
  TextEditingController keluhanController = TextEditingController();

  GetQueue({super.key, required this.poli});

  @override
  Widget build(BuildContext context) {
    if (poli.doctor.length > 1) {
      allDoctor = ("${poli.doctor[0]} | ${poli.doctor[0]}");
    } else {
      allDoctor = poli.doctor[0];
    }
    return Scaffold(
        backgroundColor: const Color(0xFFeeedf2),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        // listPoli[index].name,
                        'Ambil antrean',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: const Color(0xFFf5f5f5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(2, 2))
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        poli.logo,
                        size: 30,
                        color: const Color(0xFF6798f8),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // listPoli[index].name,
                            poli.name,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                allDoctor,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: const Color(0xFFf5f5f5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(2, 2))
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      TextInput(
                          controller: rmController,
                          title: 'No. RM (opsional)',
                          placeholder: 'Masukan nomor'),
                      TextInput(
                          controller: bpjsController,
                          title: 'No. BPJS/KIS/Askes (opsional)',
                          placeholder: 'Masukan nomor'),
                      TextInput(
                          controller: nikController,
                          title: 'NIK/No. KTP',
                          placeholder: 'Masukan nomor'),
                      TextInput(
                          controller: namaController,
                          title: 'Nama lengkap',
                          placeholder: 'Masukan nama'),
                      TextInput(
                          controller: ttlController,
                          title: 'Tempat, tanggal lahir',
                          placeholder: 'Masukan TTL'),
                      TextInput(
                          controller: alamatController,
                          title: 'Alamat (sesuai KTP)',
                          placeholder: 'Masukan alamat'),
                      TextInput(
                          controller: tujuanController,
                          title: 'Tujuan poli',
                          placeholder: 'Masukan tujuan'),
                      TextInput(
                          controller: keluhanController,
                          title: 'Keluhan',
                          placeholder: 'Masukan keluhan'),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(poli.slug)
                            .orderBy("queue", descending: true)
                            .limit(1)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          }
                          var data = snapshot.data!.docs;
                          String queue;

                          if (data.isNotEmpty) {
                            queue = data[0]['queue'];
                          } else {
                            queue = '1';
                          }
                          // print(data[0]['queue']);
                          return InkWell(
                            onTap: () async {
                              final message = await DataService().store(
                                  collection: poli.slug,
                                  queue: queue,
                                  rm: rmController.text,
                                  bpjs: bpjsController.text,
                                  nik: nikController.text,
                                  nama: namaController.text,
                                  ttl: ttlController.text,
                                  alamat: alamatController.text,
                                  tujuan: tujuanController.text,
                                  keluhan: keluhanController.text);

                              if (message == 'Success') {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    // backgroundColor: Colors.yellow,
                                    content: Text(
                                        message ?? 'Sukses mengajukan antrean'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        message ?? 'Gagal mengajukan antrean'),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF578af5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text('Anjukan pendaftaran online',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  )),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Silahkan tunggu konfirmasi dan Terima nomor antrian pasien online. Diharapkan Pendaftaran Online H-1 mulai pukul 07.00-13.00 WIB, hari minggu dan tanggal merah Libur.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )));
  }
}

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String placeholder;
  const TextInput(
      {super.key,
      required this.controller,
      required this.title,
      required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: placeholder,
                  border: InputBorder.none,
                ),
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
