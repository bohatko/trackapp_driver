import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _signUpCategory = prefs.getString('ff_signUpCategory') ?? _signUpCategory;
    });
    _safeInit(() {
      _driverGeoStart =
          latLngFromString(prefs.getString('ff_driverGeoStart')) ??
              _driverGeoStart;
    });
    _safeInit(() {
      _NullGeo = latLngFromString(prefs.getString('ff_NullGeo')) ?? _NullGeo;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _signUpCategory = 'Водитель';
  String get signUpCategory => _signUpCategory;
  set signUpCategory(String value) {
    _signUpCategory = value;
    prefs.setString('ff_signUpCategory', value);
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int value) {
    _pageIndex = value;
  }

  int _menuIndex = 1;
  int get menuIndex => _menuIndex;
  set menuIndex(int value) {
    _menuIndex = value;
  }

  String _adress = '';
  String get adress => _adress;
  set adress(String value) {
    _adress = value;
  }

  String _pickedDataaddress = '';
  String get pickedDataaddress => _pickedDataaddress;
  set pickedDataaddress(String value) {
    _pickedDataaddress = value;
  }

  LatLng? _pickedDataaddressLatLong;
  LatLng? get pickedDataaddressLatLong => _pickedDataaddressLatLong;
  set pickedDataaddressLatLong(LatLng? value) {
    _pickedDataaddressLatLong = value;
  }

  LatLng? _driverGeoStart = LatLng(55, 37);
  LatLng? get driverGeoStart => _driverGeoStart;
  set driverGeoStart(LatLng? value) {
    _driverGeoStart = value;
    value != null
        ? prefs.setString('ff_driverGeoStart', value.serialize())
        : prefs.remove('ff_driverGeoStart');
  }

  String _smsCode = '';
  String get smsCode => _smsCode;
  set smsCode(String value) {
    _smsCode = value;
  }

  LatLng? _NullGeo = LatLng(0, 0);
  LatLng? get NullGeo => _NullGeo;
  set NullGeo(LatLng? value) {
    _NullGeo = value;
    value != null
        ? prefs.setString('ff_NullGeo', value.serialize())
        : prefs.remove('ff_NullGeo');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
