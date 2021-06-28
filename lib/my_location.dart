import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocation {
  String username;
  String fullname;
  String address;
  String street;
  String ward;
  String district;
  String city;
  String gpSX;
  String gpSY;
  String loai;
  String loaiDiem;
  String status;
  String createdOn;

  MyLocation(
      {this.username,
      this.fullname,
      this.address,
      this.street,
      this.ward,
      this.district,
      this.city,
      this.gpSX,
      this.gpSY,
      this.loai,
      this.loaiDiem,
      this.status,
      this.createdOn});

  MyLocation.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    address = json['address'];
    street = json['street'];
    ward = json['ward'];
    district = json['district'];
    city = json['city'];
    gpSX = json['gpS_X'];
    gpSY = json['gpS_Y'];
    loai = json['loai'];
    loaiDiem = json['loaiDiem'];
    status = json['status'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['address'] = this.address;
    data['street'] = this.street;
    data['ward'] = this.ward;
    data['district'] = this.district;
    data['city'] = this.city;
    data['gpS_X'] = this.gpSX;
    data['gpS_Y'] = this.gpSY;
    data['loai'] = this.loai;
    data['loaiDiem'] = this.loaiDiem;
    data['status'] = this.status;
    data['createdOn'] = this.createdOn;
    return data;
  }
}

class PointLocation {
  LatLng latlng;
  MyLocation location;

  PointLocation(this.latlng, this.location);
}
