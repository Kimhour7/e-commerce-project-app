class Address {
  String? status;
  String? message;
  List<Addresses>? addresses;

  Address({this.status, this.message, this.addresses});

  Address.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? id;
  int? userId;
  String? line1;
  String? city;
  String? country;
  String? postalCode;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;

  Addresses({
    this.id,
    this.userId,
    this.line1,
    this.city,
    this.country,
    this.postalCode,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
  });

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    line1 = json['line1'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postal_code'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['line1'] = this.line1;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
