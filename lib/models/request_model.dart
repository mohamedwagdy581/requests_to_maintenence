class RequestModel {
  String? uId;
  late String city;
  late String school;
  late String machine;
  late String machineType;
  late String consultation;

  RequestModel({
    this.uId = '',
    required this.city,
    required this.school,
    required this.machine,
    required this.machineType,
    required this.consultation,
  });

  Map<String, dynamic> toJson() =>
  {
    'uId' : uId,
    'city' : city,
    'school' : school,
    'machine' : machine,
    'machineType' : machineType,
    'consultation' : consultation,
  };

  RequestModel.fromJson(Map<String, dynamic> json)
  {
    uId = json['uId'];
    city = json['city'];
    school = json['school'];
    machine = json['machine'];
    machineType = json['machineType'];
    consultation = json['consultation'];
  }
}
