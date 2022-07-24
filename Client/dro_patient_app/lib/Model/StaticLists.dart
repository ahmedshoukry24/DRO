
class StaticLists{
  List<String> _insurance = [
    'Aristocrat Insurance', 'Caprock Insurance''I-nsumed', 'Grey Leaf Coverage', 'Cope Health Solutions',
    'Medical ValuSurance', 'LongSage Insurance', 'Intriq Medical Insurance', 'Solid Life Insurance', 'Magnolia Management',
    'Aegis Insurance', 'Rock stone Security', 'Gain Security and Trust', 'Elder Assurance', 'Evolve Insurance',
    'Medieval Insurance', 'EnsureMania', 'Time of your Life Insurance',
  ];
  List<String> _catList = [
    'Dermatology (Skin)', 'Dentistry (Teeth)', 'Psychiatry (Mental, Emotional or Behavioral Disorders)',
    'Pediatrics and New Born (Child)', 'Neurology (Brain & Nerves)', 'Orthopedics (Bones)',
    'Gynecology and Infertility', 'Ear, Nose, and Throat', 'Cardiology and Vascular Disease (Heart)',
    'Allergy and Immunology (Sensitivity and Immunity)', 'Andrology and Male Infertility', 'Audiology',
    'Cardiology and Thoracic Surgery (Heart & Chest)', 'Chest and Respiratory', 'Diabetes and Endocrinology',
    'Diagnostic Radiology (Scan Centers)', 'Dietitian and Nutrition', 'Family Medicine', 'Gastroenterology and Endoscopy',
    'Obesity and Laparoscopic Surgery', 'General Practice', 'Oncology (Tumor)', 'General Surgery',
    'Oncology Surgery (Tumor Surgery)', 'Geriatrics (Old People Health)', 'Ophthalmology (Eyes)', 'Hematology',
    'Osteopathy (Osteopathic Medicine)', 'Hepatology (Liver Doctor)', 'Pain Management', 'Pediatric Surgery',
    'Internal Medicine', 'IVF and Infertility', 'Phoniatrics (Speech)', 'Laboratories', 'Physiotherapy and Sport Injuries',
    'Nephrology', 'Plastic Surgery', 'Neurosurgery (Brain & Nerves Surgery)', 'Urology (Urinary System)',
    'Vascular Surgery (Arteries and Vein Surgery)', 'Rheumatology', 'Spinal Surgery'
  ];

  List<String> _cities = [
    'Alexandria', 'Aswan', 'Asyut', 'Beheira', 'Beni Suef', 'Cairo', 'Dakahlia', 'Damietta',
    'Faiyum', 'Gharbia', 'Giza', 'Ismailia', 'Kafr El Sheikh', 'Luxor', 'Matruh', 'Minya',
    'Monufia', 'New Valley', 'North Sinai', 'Port Said', 'Qalyubia', 'Qena', 'Red Sea', 'Sharqia',
    'Sohag', 'South Sinai', 'Suez'
  ];

  List<String> _titles = ['Professor', 'Lecturer', 'Consultant', 'Specialist'];


  List<String> getCities()=>[..._cities];
  List<String> getInsuranceList()=>[..._insurance];
  List<String> getCategoriesList()=> [..._catList];
  List<String> getTitles()=>[..._titles];
}


