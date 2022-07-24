import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownSpecialties extends StatefulWidget {
  List<String> _specialties = [
    'Dermatology (Skin)',
    'Dentistry (Teeth)',
    'Psychiatry (Mental, Emotional or Behavioral Disorders)',
    'Pediatrics and New Born (Child)',
    'Neurology (Brain & Nerves)',
    'Orthopedics (Bones)',
    'Gynecology and Infertility',
    'Ear, Nose, and Throat',
    'Cardiology and Vascular Disease (Heart)',
    'Allergy and Immunology (Sensitivity and Immunity)',
    'Andrology and Male Infertility',
    'Audiology',
    'Cardiology and Thoracic Surgery (Heart & Chest)',
    'Chest and Respiratory',
    'Diabetes and Endocrinology',
    'Diagnostic Radiology (Scan Centers)',
    'Dietitian and Nutrition',
    'Family Medicine',
    'Gastroenterology and Endoscopy',
    'Obesity and Laparoscopic Surgery',
    'General Practice',
    'Oncology (Tumor)',
    'General Surgery',
    'Oncology Surgery (Tumor Surgery)',
    'Geriatrics (Old People Health)',
    'Ophthalmology (Eyes)',
    'Hematology',
    'Osteopathy (Osteopathic Medicine)',
    'Hepatology (Liver Doctor)',
    'Pain Management',
    'Pediatric Surgery',
    'Internal Medicine',
    'IVF and Infertility',
    'Phoniatrics (Speech)',
    'Laboratories',
    'Physiotherapy and Sport Injuries',
    'Nephrology',
    'Plastic Surgery',
    'Neurosurgery (Brain & Nerves Surgery)',
    'Urology (Urinary System)',
    'Vascular Surgery (Arteries and Vein Surgery)',
    'Rheumatology',
    'Spinal Surgery'
  ];
  String result;

  @override
  _DropdownSpecialtiesState createState() {
    return _DropdownSpecialtiesState();
  }
}

class _DropdownSpecialtiesState extends State<DropdownSpecialties> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
        items: widget._specialties.map((item) {
          return DropdownMenuItem(
            child: Text(
              item,
              style: TextStyle(color: Colors.blue[800], fontSize: 13),
            ),
            value: item,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.result = value;
          });
        },
        hint: Text('Specialty',style: TextStyle(color: Colors.blue[800]),),
        value: widget.result,
        isExpanded: true,
      ),
    );
  }
}
