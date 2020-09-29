// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:polaris_map/location.dart';
import 'package:polaris_map/my_checkbox.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<GoogleMapStateBase>();

  _checkValueChange(bool checkedValue, String brand) {
    setState(() {
      if (checkedValue == false) {
        for (var location
            in api_locations.where((element) => element.brandName == brand)) {
          GoogleMap.of(_key).removeMarker(GeoCoord(
            location.latitude,
            location.longitude,
          ));
        }
      } else {
        for (var location
            in api_locations.where((element) => element.brandName == brand)) {
          GoogleMap.of(_key).addMarkerRaw(
            get_GeoCoord(location),
            info: location.brandName + " / " + location.storeNo,
            infoSnippet: location.address,
            onInfoWindowTap: () {},
            icon: get_Icon(location),
          );
        }
      }
    });
  }

  GeoCoord hcm_point = GeoCoord(10.7741454, 106.6862577);
  GeoCoord hn_point = GeoCoord(21.0359191, 105.8121223);
  String get_Icon(MyLocation location) {
    String _icon = "";
    switch (location.brandName) {
      case "Phúc Long":
        _icon = "assets/images/marker_do.png";
        break;
      case "GongCha":
        _icon = "assets/images/marker_tim.png";
        break;
      case "Highlands":
        _icon = "assets/images/marker_xanhduong.png";
        break;
      case "Ding Tea":
        _icon = "assets/images/marker_xanhla.png";
        break;
      default:
        _icon = "assets/images/marker_do.png";
    }
    return _icon;
  }

  GeoCoord get_GeoCoord(MyLocation location) {
    return GeoCoord(
      location.latitude,
      location.longitude,
    );
  }

  List<MyLocation> api_locations = [
    MyLocation(
        10.7928337000,
        106.6858129000,
        '101191',
        'CH VLXD NGOC THO',
        'Số 2 đường PHAN DINH PHUNG phường 2 quận PHÚ NHUẬN , Thành phố Hồ Chí Minh',
        'GongCha'),
    MyLocation(
        10.8033516000,
        106.7045842000,
        '100399',
        'NGOC MY',
        'Số 385A  đường BACH DANG phường 15 quận BÌNH THẠNH , Thành phố Hồ Chí Minh',
        'GongCha'),
    MyLocation(
        10.8474697653,
        106.6123346854,
        '100111',
        'ĐỨC TÀI',
        'Số A37  đường QL22 phường TRUNG MỸ TÂY quận 12 , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8022388000,
        106.6437759000,
        '100237',
        'DAI GIA LONG',
        'Số 404 đường CONG HOA phường 13 quận TÂN BÌNH , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7545454000,
        106.7015085000,
        '100531',
        'DUNG MAI',
        'Số 189E đường TON THAT THUYET phường 3 quận 4 , Thành phố Hồ Chí Minh',
        'GongCha'),
    MyLocation(
        10.7680315000,
        106.6991320000,
        '100363',
        'CTY TNHH TM PHUC ANH NGUYEN',
        'Số 103 đường CALMETTE phường NGUYỄN THÁI BÌNH quận 1 , Thành phố Hồ Chí Minh',
        'GongCha'),
    MyLocation(
        10.7635480588,
        106.6472899944,
        '1279',
        'KIẾN SANG',
        'Số 35 đường 9 CƯ XÁ BÌNH THỚI phường 8 quận 11 , Thành phố Hồ Chí Minh',
        'Highlands'),
    MyLocation(
        10.8033804000,
        106.7035770000,
        '100485',
        'CHIN SON',
        'Số 387 đường BACH DANG phường 15 quận BÌNH THẠNH , Thành phố Hồ Chí Minh',
        'GongCha'),
    MyLocation(
        10.8029655000,
        106.7104019900,
        '100401',
        'THAI NGOC',
        'Số 32 đường BACH DANG phường 24 quận BÌNH THẠNH , Thành phố Hồ Chí Minh',
        'Ding Tea'),
    MyLocation(
        10.8848034312,
        106.6813936663,
        '100189',
        'TUẤN DŨNG',
        'Số 628A  đường HÀ HUY GIÁP phường THẠNH LỘC quận 12 , Thành phố Hồ Chí Minh',
        'Ding Tea'),
    MyLocation(
        10.8506764230,
        106.6563312471,
        '100316',
        'VẠN LỘC',
        'Số 461 đường PHẠM VĂN CHIÊU phường 13 quận GÒ VẤP , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7682425000,
        106.6990129000,
        '100621',
        'CH THU KHANH',
        'Số 109B đường CALMETTE phường NGUYỄN THÁI BÌNH quận 1 , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8012041000,
        106.6447292000,
        '101245',
        'CHI TAI',
        'Số 86A đường BINH GIA phường 13 quận TÂN BÌNH , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8322429657,
        106.6342185715,
        '100314',
        'PHÁT LỘC',
        'Số 148 đường PHAN HUY ÍCH phường 12 quận GÒ VẤP , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7762757098,
        106.6070174463,
        '100433',
        'THIÊN PHÁT',
        'Số 456 đường LÊ VĂN QUỚI phường BÌNH HƯNG HOÀ quận BÌNH TÂN , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8012728000,
        106.6517570000,
        '100239',
        'ĐẠI HỒNG PHÚC',
        'Số 125 đường CỘNG HÒA phường 12 quận TÂN BÌNH , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7766285,
        106.7543142,
        '100082',
        'LIEN SON',
        'Số 998 đường ĐỒNG VĂN CỐNG phường BÌNH TRƯNG TÂY quận 2 , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7555464335,
        106.6266725425,
        '100874',
        'VĨNH THẮNG 1',
        'Số 228A  đường BÀ HOM phường 13 quận 6 , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.755278,
        106.674156,
        '100198',
        'THANH HAI',
        'Số 113 đường TÂN KỲ TÂN QUÝ phường TÂN SƠN NHÌ quận TÂN PHÚ , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8297917762,
        106.6807806296,
        '100070',
        'QUANG HUY',
        'Số 510 đường PHAN VĂN TRỊ phường 7 quận GÒ VẤP , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8005679000,
        106.7081957000,
        '100353',
        'THANH DAO',
        'Số 438 đường DIEN BIEN PHU phường 17 quận BÌNH THẠNH , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7844226000,
        106.6693217000,
        '100129',
        'DUOC PHUOC',
        'Số 462 đường CMT8 phường 11 quận 3 , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.8024578000,
        106.6421040000,
        '100049',
        'SON THIEN LOC (TUONG XINH)',
        'Số 458 đường CONG HOA phường 13 quận TÂN BÌNH , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7770660000,
        106.6343974000,
        '101261',
        'UY VU',
        'Số 406 đường LUY BAN BICH phường HÒA THẠNH quận TÂN PHÚ , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7495489055,
        106.6728798111,
        '100738',
        'PHÚ THÁI',
        'Số 960 đường VÕ VĂN KIỆT phường 6 quận 5 , Thành phố Hồ Chí Minh',
        'Phúc Long'),
    MyLocation(
        10.7947915000,
        106.7014034000,
        '100352',
        'THIỆN',
        'Số 39 đường ĐIỆN BIÊN PHỦ phường 15 quận BÌNH THẠNH , Thành phố Hồ Chí Minh',
        'Phúc Long'),
  ];
  List<Widget> _buildCheckBrandButtons() => [
        const SizedBox(width: 16),
        MyCheckBox(
          title: "Phúc Long",
          color: Colors.red,
          onChangedCheck: (checkedValue) =>
              _checkValueChange(checkedValue, "Phúc Long"),
        ),
        const SizedBox(width: 16),
        MyCheckBox(
          title: "GongCha",
          color: Colors.purple,
          onChangedCheck: (checkedValue) =>
              _checkValueChange(checkedValue, "GongCha"),
        ),
        const SizedBox(width: 16),
        MyCheckBox(
          title: "Highlands",
          color: Colors.blue,
          onChangedCheck: (checkedValue) =>
              _checkValueChange(checkedValue, "Highlands"),
        ),
        const SizedBox(width: 16),
        MyCheckBox(
          title: "Ding Tea",
          color: Colors.green,
          onChangedCheck: (checkedValue) =>
              _checkValueChange(checkedValue, "Ding Tea"),
        ),
      ];
  List<Widget> _buildMoveCityButtons() => [
        const SizedBox(width: 16),
        Container(
          width: 100,
          child: RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            icon: Icon(Icons.directions),
            label: Text('HCM'),
            onPressed: () {
              GoogleMap.of(_key).moveCamera(hcm_point);
            },
          ),
        ),
        Container(
          width: 100,
          child: RaisedButton.icon(
            color: Colors.purple,
            textColor: Colors.white,
            icon: Icon(Icons.directions),
            label: Text('HN'),
            onPressed: () {
              GoogleMap.of(_key).moveCamera(hn_point);
            },
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = new Set<Marker>();

    for (var location in api_locations) {
      markers.add(new Marker(
        get_GeoCoord(location),
        info: location.brandName + " / " + location.storeNo,
        infoSnippet: location.address,
        onInfoWindowTap: () {},
        icon: get_Icon(location),
        // onTap: (value) => get_TapMarkerEvent(value, location), label: "label",
      ));
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              key: _key,
              markers: markers,
              initialZoom: 13,
              initialPosition:
                  GeoCoord(10.8077946924, 106.6221338057), // Los Angeles, CA
              mapType: MapType.roadmap,

              interactive: true,
              // onTap: (coord) => _scaffoldKey.currentState.showSnackBar(SnackBar(
              //   content: Text(coord?.toString()),
              //   duration: const Duration(seconds: 2),
              // )),
              mobilePreferences: const MobileMapPreferences(
                trafficEnabled: true,
                zoomControlsEnabled: false,
              ),
              webPreferences: WebMapPreferences(
                fullscreenControl: true,
                zoomControl: true,
              ),
            ),
          ),
          Positioned(
              left: 16,
              bottom: 16,
              child: Column(children: _buildCheckBrandButtons())),
          Positioned(
              left: 16,
              top: 16,
              child: Column(children: _buildMoveCityButtons())),
        ],
      ),
    );
  }
}
