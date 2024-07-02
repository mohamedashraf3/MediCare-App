class DoctorModel {
  String? name;
  String? phoneNumber;
  String? location;
  int? age;
  double? rate;
  String? brief;
  String? type;
  String? specialization;
  int? id;

  DoctorModel({
    this.name,
    this.phoneNumber,
    this.location,
    this.age,
    this.rate,
    this.brief,
    this.type,
    this.specialization,
    this.id,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      phoneNumber: json['phonenumber'],
      location: json['location'],
      age: json['age'],
      rate: (json['rate'] as num?)?.toDouble(),
      brief: json['brief'],
      type: json['type'],
      specialization: json['specialization'],
      id: json['id'],
    );
  }
}

class DoctorListModel {
  List<DoctorModel>? doctors;

  DoctorListModel({this.doctors});

  factory DoctorListModel.fromJson(List<dynamic> jsonList) {
    List<DoctorModel> doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
    return DoctorListModel(doctors: doctors);
  }
}
