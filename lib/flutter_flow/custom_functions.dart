import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

bool validatorSms(String sms) {
  if (sms.length >= 4) {
    return true;
  } else {
    return false;
  }
}

String? plusText(
  String? text1,
  String? text2,
) {
  return '$text1 (гос.номер: $text2)';
}

DateTime? timeInOrder(DateTime? startDataTime) {
  if (startDataTime != null) {
    return startDataTime.add(Duration(hours: 1));
  }
  return null;
}

int? returnIntenger(double? slider) {
  // get double and  return Intenger
  if (slider == null) {
    return null;
  } else {
    return slider.toInt();
  }
}

bool? returnMaxSumm(
  String? priceTeh,
  String? inputSumm,
) {
  if (priceTeh == null || inputSumm == null) {
    // Вернуть null, если один из аргументов равен null
    return null;
  }

  double order = double.tryParse(priceTeh) ?? 0;
  double input = double.tryParse(inputSumm) ?? 0;

  return input <= order;
}

int? returnHourInt(String? rate) {
  if (rate == null) {
    return null;
  }

  final regex = RegExp(r'\d+');
  final match = regex.firstMatch(rate);

  if (match != null) {
    return int.tryParse(match.group(0) ?? '');
  }

  return null;
}

String? onlyNumber(String? number) {
  if (number == null) {
    return null;
  }

  // Удаляем все символы, кроме цифр
  String cleanedNumber = number.replaceAll(RegExp(r'[^0-9]'), '');

  return cleanedNumber;
}

int? checkDatePermitionForDriver(DateTime? startDate) {
  if (startDate == null) return null;

  // Получаем текущую дату без времени (только день, месяц, год)
  DateTime currentDate = DateTime.now();
  DateTime today =
      DateTime(currentDate.year, currentDate.month, currentDate.day);

  // Убираем время из startDate (оставляем только день, месяц, год)
  DateTime startDay = DateTime(startDate.year, startDate.month, startDate.day);

  // Сравниваем даты
  if (startDay.isAtSameMomentAs(today)) {
    return 1; // Дата совпадает с сегодняшним днем
  } else if (startDay.isBefore(today)) {
    return 2; // Дата была вчера или раньше
  } else {
    return 3; // Дата наступит завтра или позже
  }
}

bool? chekGeoDriverForJob(
  LatLng? currentgeodriver,
  LatLng? placeGeo,
) {
  /// Проверка на null значения
  if (currentgeodriver == null || placeGeo == null) {
    return null;
  }

  const double earthRadius = 6371000; // Радиус Земли в метрах

  double lat1 = currentgeodriver.latitude;
  double lon1 = currentgeodriver.longitude;
  double lat2 = placeGeo.latitude;
  double lon2 = placeGeo.longitude;

  // Конвертация координат из градусов в радианы
  double dLat = (lat2 - lat1) * (math.pi / 180);
  double dLon = (lon2 - lon1) * (math.pi / 180);

  lat1 = lat1 * (math.pi / 180);
  lat2 = lat2 * (math.pi / 180);

  // Формула Haversine для вычисления расстояния между двумя точками на сфере
  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  // Расстояние между двумя точками в метрах
  double distance = earthRadius * c;

  // Возвращаем true, если расстояние меньше или равно 200 метров
  return distance <= 200;
}
