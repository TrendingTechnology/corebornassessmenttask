class UserModel {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;
  int albumCount;
  int postCount;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
    required this.albumCount,
    required this.postCount,
  });

  UserModel.fromJson(Map<String, dynamic> json, this.albumCount, this.postCount)
      : id = json['id'] as int,
        name = json['name'] as String,
        username = json['username'] as String,
        email = json['email'] as String,
        address = Address.fromJson(json['address']),
        phone = json['phone'] as String,
        website = json['website'] as String,
        company = Company.fromJson(json['company']);
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        suite = json['suite'],
        city = json['city'],
        zipcode = json['zipcode'],
        geo = Geo.fromJson(json['geo']);
}

class Geo {
  String lat;
  String lng;

  Geo.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        catchPhrase = json['catchPhrase'],
        bs = json['bs'];
}
