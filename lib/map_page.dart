// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:html';

import 'package:dino_map/api_helper.dart';
import 'package:dino_map/filter.dart';
import 'package:dino_map/filter_page.dart';
import 'package:dino_map/my_checkbox.dart';
import 'package:dino_map/my_hanhchanh.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'my_location.dart';

class MapPage extends StatelessWidget {
  MapPage() : super();

  @override
  Widget build(BuildContext context) {
    return const PlacePolylineBody();
  }
}

class PlacePolylineBody extends StatefulWidget {
  const PlacePolylineBody();

  @override
  State<StatefulWidget> createState() => PlacePolylineBodyState();
}

class PlacePolylineBodyState extends State<PlacePolylineBody> {
  PlacePolylineBodyState();
  Filter filter;
  GoogleMapController controller;
  PolylineId selectedPolyline;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};

  // Values when toggling polyline color
  List<MyLocation> apiLocations = <MyLocation>[];
  List<MyLocation> currentLocations = <MyLocation>[];
  List<MyHanhChanh> apiHanhchanh;

  var isBusy = false;
  bool _isOnlyShowStore = true;

  BitmapDescriptor iconStart;
  BitmapDescriptor iconEnd;
  BitmapDescriptor iconStore;
  BitmapDescriptor iconNgare;

  TextStyle _textStyleFilter = new TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);
  TextStyle _textStyleFilterHeader = new TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  double widthFilter = 80.0;

  var centerPoint = LatLng(10.8045710952941, 106.708992920358);
  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId('1'),
        center: LatLng(20.9908368, 105.8000611),
        radius: 1500,
        strokeWidth: 15)
  ]);

  Future<List<MyHanhChanh>> loadHanhChanhJson() async {
    List jsonResponse =
        json.decode(await rootBundle.loadString('assets/hanhchanh.json'));
    return jsonResponse.map((item) => new MyHanhChanh.fromJson(item)).toList();
  }

  @override
  void initState() {
    filter = new Filter(city: 'HỒ CHÍ MINH', district: 'BÌNH THẠNH');
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(42, 42)),
            'assets/images/marker_do.png')
        .then((onValue) {
      iconStore = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(36, 36)),
            'assets/images/marker_tim.png')
        .then((onValue) {
      iconStart = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(36, 36)),
            'assets/images/marker_xanhduong.png')
        .then((onValue) {
      iconEnd = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1, 1)),
            'assets/images/icons8-location-update-64.png')
        .then((onValue) {
      iconNgare = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // polylines.clear();
    // markers.clear();
    return Scaffold(
        body: isBusy == true
            ? CircularProgressIndicator()
            : FutureBuilder<List<MyHanhChanh>>(
                future: loadHanhChanhJson(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    apiHanhchanh = snapshot.data;

                    return Row(
                      children: [
                        Expanded(child: _buildGoogleMap),
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                          child: Column(
                            children: [
                              Container(
                                  width: 200, height: 100, child: _buildFilter),
                              Container(
                                width: 200,
                                height: 50,
                                child: MyCheckBox(
                                    title: "Chỉ C/H",
                                    color: Colors.purple,
                                    onChangedCheck: (checkedValue) {
                                      _isOnlyShowStore = checkedValue;
                                      if (apiLocations.isEmpty) {
                                      } else {
                                        currentLocations = _isOnlyShowStore
                                            ? apiLocations
                                                .where((element) =>
                                                    element.loai == '3')
                                                .toList()
                                            : apiLocations;
                                      }
                                      setRounds();
                                      setState(() {
                                        drawMapWard();
                                      });
                                    }),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: _isOnlyShowStore == true ||
                                          apiLocations == null ||
                                          apiLocations.length == 0
                                      ? ListView.builder(
                                          itemCount: 0,
                                          itemBuilder: (context, index) =>
                                              Text(index.toString()),
                                        )
                                      : ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                                  thickness: 0.2,
                                                  color: Colors.black),
                                          itemCount: rounds.length,
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                                  onTap: () {
                                                    currentLocations =
                                                        apiLocations
                                                            .where((element) =>
                                                                element
                                                                    .username ==
                                                                rounds[index])
                                                            .toList();

                                                    setState(() {
                                                      drawMapWard();
                                                    });
                                                  },
                                                  child: Text(rounds[index]
                                                      .toString())),
                                        ),
                                ),
                              )
                              // _isOnlyShowStore == true ||
                              //         apiLocations == null ||
                              //         apiLocations.length == 0
                              //     ? Expanded(
                              //         child: Container(
                              //         width: 250,
                              //         height: double.infinity,
                              //       ))
                              //     : Container(
                              //         width: 250,
                              //         height: double.infinity,
                              //         child: ListView.separated(
                              //           shrinkWrap: true,
                              //           itemCount: rounds.length,
                              //           separatorBuilder: (context, index) =>
                              //               Divider(
                              //                   thickness: 0.2,
                              //                   color: Colors.black),
                              //           itemBuilder: (context, index) => InkWell(
                              //               onTap: () {
                              //                 print('on tap');
                              //                 print(rounds[index]);

                              //                 currentLocations = apiLocations
                              //                     .where((element) =>
                              //                         element.username ==
                              //                         rounds[index])
                              //                     .toList();
                              //                 for (var item in currentLocations) {
                              //                   print(
                              //                       item.gpSX + ' ' + item.gpSY);
                              //                 }
                              //                 setState(() {
                              //                   drawMapWard();
                              //                 });
                              //               },
                              //               child:
                              //                   Text(rounds[index].toString())),
                              //         ),
                              //       ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ));
  }

  var store_map = <MyLocation>[];
  var rounds = <String>[];

  setRounds() {
    rounds.clear();
    print('rounds setup');
    for (var item in apiLocations) {
      if (!rounds.contains(item.username)) {
        rounds.insert(0, item.username);
      }
    }
  }

  Widget get _buildFilter {
    return Container(
      // height: 125,
      width: 220,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: widthFilter,
                  child: Text('TP',
                      textAlign: TextAlign.start,
                      style: _textStyleFilterHeader)),
              Expanded(
                child: InkWell(
                    onTap: () {
                      List<String> source = <String>[];
                      for (var item in apiHanhchanh) {
                        if (!source.contains(item.city) &&
                            item.city.trim().isNotEmpty) {
                          source.add(item.city);
                        }
                      }
                      showPopup(context, source, "CITY");
                    },
                    child: Text(
                      filter.city == null ? "Chưa có" : filter.city,
                      textAlign: TextAlign.start,
                      style: _textStyleFilter,
                    )),
              ),
            ],
          ),
          Container(
            height: 10.0,
          ),
          Row(
            children: [
              Container(
                  width: widthFilter,
                  child: Text('QUẬN',
                      textAlign: TextAlign.start,
                      style: _textStyleFilterHeader)),
              Expanded(
                child: InkWell(
                  onTap: () {
                    List<String> source = <String>[];
                    for (var item in apiHanhchanh
                        .where((element) => element.city == filter.city)) {
                      if (!source.contains(item.district) &&
                          item.district.trim().isNotEmpty) {
                        source.add(item.district);
                      }
                    }
                    showPopup(context, source, "DISTRICT");
                  },
                  child: Text(
                    filter.district == null ? "Chưa có" : filter.district,
                    textAlign: TextAlign.start,
                    style: _textStyleFilter,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 10.0,
          ),
          Row(
            children: [
              Container(
                  width: widthFilter,
                  child: Text(
                    'PHƯỜNG',
                    style: _textStyleFilterHeader,
                    textAlign: TextAlign.start,
                  )),
              Expanded(
                child: InkWell(
                  onTap: () {
                    List<String> source = <String>[];
                    for (var item in apiHanhchanh.where((element) =>
                        element.city == filter.city &&
                        element.district == filter.district)) {
                      if (!source.contains(item.ward) &&
                          item.ward.trim().isNotEmpty) {
                        source.add(item.ward);
                      }
                    }
                    showPopup(context, source, "WARD");
                  },
                  child: Text(filter.ward == null ? "Chưa có" : filter.ward,
                      textAlign: TextAlign.start, style: _textStyleFilter),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget get _buildGoogleMap {
    print('rebuild map');
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: centerPoint,
        zoom: 17.0,
      ),
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.of(markers.values),
      onMapCreated: _onMapCreated,
      // circles: circles,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  String getTitleInfoWindown(MyLocation location) {
    return location.loai == '1'
        ? 'Bắt đầu'
        : (location.loai == '2'
            ? 'Ngã rẽ'
            : (location.loai == '3'
                ? (location.status == '2'
                    ? ('[CLOSED]' +
                        (location.fullname == null ? '--' : location.fullname))
                    : (location.fullname == null ? '--' : location.fullname) +
                        ':' +
                        location.address +
                        ',' +
                        location.street)
                : 'Kết thúc'));
  }

  void _addMarkers(List<PointLocation> points) {
    markers = <MarkerId, Marker>{};

    for (var location in points) {
      var markerIdVal = location.latlng.latitude.toString();

      final MarkerId markerId = MarkerId(markerIdVal);
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: location.latlng,
        infoWindow: InfoWindow(title: getTitleInfoWindown(location.location)),
        onTap: () {},
        icon: location.location.loai == '1'
            ? iconStart
            : (location.location.loai == '2'
                ? iconNgare
                : (location.location.loai == '3' ? iconStore : iconEnd)),
      );
      markers[markerId] = marker;
    }
  }

  List<PointLocation> _createPointsWard() {
    final List<PointLocation> points = <PointLocation>[];

    for (var point in (currentLocations)) {
      LatLng latlng = LatLng(double.parse(point.gpSY.replaceAll(',', '.')),
          double.parse(point.gpSX.replaceAll(',', '.')));
      points.add(PointLocation(latlng, point));
    }

    return points;
  }

  showPopup(BuildContext context, List<String> source, String fieldName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: FilterPage(
              source: source,
              savedData: (selectedValue) async {
                if (fieldName == "CITY") {
                  setState(() {
                    filter.city = selectedValue;
                    filter.district = null;
                    filter.ward = null;
                    filter.street = null;
                  });
                }
                if (fieldName == "DISTRICT") {
                  setState(() {
                    filter.district = selectedValue;
                    filter.ward = null;
                    filter.street = null;
                  });
                }

                if (fieldName == "WARD") {
                  setState(() {
                    filter.ward = selectedValue;
                    filter.street = null;
                  });
                  apiLocations.clear();
                  currentLocations.clear();
                  store_map.clear();
                  apiLocations.addAll(await API_HELPER.getLocations(
                      filter.city, filter.district, filter.ward));
                  setRounds();
                  currentLocations = _isOnlyShowStore
                      ? apiLocations
                          .where((element) => element.loai == '3')
                          .toList()
                      : apiLocations;
                  setState(() {
                    drawMapWard();
                  });
                }
              },
            ),
          );
        });
  }

  void _addPolys(List<PointLocation> locations) {
    polylines = <PolylineId, Polyline>{};
    final String polylineIdVal = 'polyline_id_10';

    final PolylineId polylineId = PolylineId(polylineIdVal);
    List<LatLng> points = <LatLng>[];

    for (var item in locations) {
      points.add(item.latlng);
    }
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.purple,
      width: _isOnlyShowStore == true ? 0 : 3,
      points: points,
      onTap: () {},
    );

    polylines[polylineId] = polyline;
  }

  void drawMapWard() async {
    setState(() {
      var points = _createPointsWard();
      _addMarkers(points);
      _addPolys(points);
      if (points.length > 0)
        controller.moveCamera(CameraUpdate.newLatLng(points[0].latlng));
    });
  }
}
