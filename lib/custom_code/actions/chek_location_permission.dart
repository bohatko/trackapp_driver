// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> chekLocationPermission(BuildContext context) async {
  var status = await Permission.location.request();

  if (status.isGranted) {
    return await _checkGpsStatus(context);
  }

  if (status.isDenied || status.isPermanentlyDenied) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 206, 137, 8),
          title: Text(
            'Доступ к местоположению',
            style: TextStyle(color: Color(0xFFFAFAFA)),
          ),
          content: Text(
            'Чтобы передавать геоданые нужно включить местоположение. Пожалуйста, включите в настройках.',
            style: TextStyle(color: Color(0xFFFAFAFA)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Нет, спасибо',
                style: TextStyle(color: Color(0xFFFAFAFA)),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Color(0xFFFAFAFA)),
              ),
            ),
          ],
        );
      },
    );
    return false;
  }

  return false;
}

Future<bool> _checkGpsStatus(BuildContext context) async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!isLocationServiceEnabled) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 206, 137, 8),
          title: Text(
            'Ошибка GPS',
            style: TextStyle(color: Color(0xFFFAFAFA)),
          ),
          content: Text(
            'Чтобы передавать геоданые нужно включить местоположение. Пожалуйста, включите в настройках.',
            style: TextStyle(color: Color(0xFFFAFAFA)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Нет, спасибо',
                style: TextStyle(color: Color(0xFFFAFAFA)),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Geolocator.openLocationSettings();
              },
              child: Text(
                'Ок',
                style: TextStyle(color: Color(0xFFFAFAFA)),
              ),
            ),
          ],
        );
      },
    );
    return false;
  }

  return true;
}
