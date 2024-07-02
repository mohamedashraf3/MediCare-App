class PharmacyModel {
  String? name;
  String? location;
  String? services;
  bool? isSaved;
  double? rate;
  int? userid;
  Null? user;
  Null? pharmacyProducts;
  int? id;

  PharmacyModel(
      {this.name,
        this.location,
        this.services,
        this.isSaved,
        this.rate,
        this.userid,
        this.user,
        this.pharmacyProducts,
        this.id});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    services = json['services'];
    isSaved = json['isSaved'];
    rate = json['rate'];
    userid = json['userid'];
    user = json['user'];
    pharmacyProducts = json['pharmacyProducts'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['services'] = this.services;
    data['isSaved'] = this.isSaved;
    data['rate'] = this.rate;
    data['userid'] = this.userid;
    data['user'] = this.user;
    data['pharmacyProducts'] = this.pharmacyProducts;
    data['id'] = this.id;
    return data;
  }
}
class PharmacyListModel {
  List<PharmacyModel>? pharmacies;

  PharmacyListModel({this.pharmacies});

  factory PharmacyListModel.fromJson(List<dynamic> jsonList) {
    List<PharmacyModel> pharmacies = jsonList.map((json) => PharmacyModel.fromJson(json)).toList();
    return PharmacyListModel(pharmacies: pharmacies);
  }
}
class PharmacySavedModel {
  String? name;
  String? location;
  String? services;
  bool? isSaved;
  double? rate;
  int? userid;
  Null? user;
  Null? pharmacyProducts;
  int? id;

  PharmacySavedModel({
    this.name,
    this.location,
    this.services,
    this.isSaved,
    this.rate,
    this.userid,
    this.user,
    this.pharmacyProducts,
    this.id,
  });

  factory PharmacySavedModel.fromJson(Map<String, dynamic> json) {
    return PharmacySavedModel(
      name: json['name'],
      location: json['location'],
      services: json['services'],
      isSaved: json['isSaved'],
      rate: (json['rate'] as num?)?.toDouble(),
      userid: json['userid'],
      user: json['user'],
      pharmacyProducts: json['pharmacyProducts'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'services': services,
      'isSaved': isSaved,
      'rate': rate,
      'userid': userid,
      'user': user,
      'pharmacyProducts': pharmacyProducts,
      'id': id,
    };
  }
}
class PharmacySavedListModel {
  List<PharmacySavedModel>? savedPharmacies;

  PharmacySavedListModel({this.savedPharmacies});

  factory PharmacySavedListModel.fromJson(List<dynamic> jsonList) {
    List<PharmacySavedModel> savedPharmacies = jsonList
        .where((json) => json['isSaved'] == true)
        .map((json) => PharmacySavedModel.fromJson(json))
        .toList();
    return PharmacySavedListModel(savedPharmacies: savedPharmacies);
  }
}

