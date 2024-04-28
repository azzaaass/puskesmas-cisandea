import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Poli {
  String name;
  List<String> doctor;
  String slug;
  IconData logo;

  Poli(
      {required this.name,
      required this.slug,
      required this.doctor,
      required this.logo});
}

List<Poli> listPoli = [
  Poli(
      name: 'Poli Umum',
      slug: 'umum',
      doctor: [
        'dr. Widjatmiko',
        'dr. Aqidatul Izzah'
      ],
      logo: FontAwesomeIcons.stethoscope),
  Poli(
      name: 'Poli KIA',
      slug: 'kia',
      doctor: [
        'dr. Retnaning Dian P.',
        'dr. Dwi Rahayu K.'
      ],
      logo: FontAwesomeIcons.personBreastfeeding),
  Poli(
      name: 'Poli Gigi dan Mulut',
      slug: 'gigi',
      doctor: [
        'Samain, Amd. Keb',
      ],
      logo: FontAwesomeIcons.tooth),
];
