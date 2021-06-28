class MyHanhChanh {
  String city;
  String district;
  String ward;

  MyHanhChanh({this.city, this.district, this.ward});

  MyHanhChanh.fromJson(Map<String, dynamic> json) {
    city = json['City'];
    district = json['District'];
    ward = json['Ward'];
  }
}
