import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class SendTLGnotificationCall {
  static Future<ApiCallResponse> call({
    String? content = '',
    String? subject = '',
    String? offer = '',
    String? company = '',
  }) async {
    final ffApiRequestBody = '''
{
  "Subject": "${subject}",
  "Content": "${content}",
  "company": "${company}",
  "offer": "${offer}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SendTLGnotification',
      apiUrl: 'https://hook.eu2.make.com/k2srulrx8vfxawlfffsnteov2aip4iz8',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SmsAuthCall {
  static Future<ApiCallResponse> call({
    String? to = '',
    String? msg = '',
    String? apiId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'smsAuth',
      apiUrl: 'https://sms.ru/sms/send',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'api_id': "4E000A43-EEE4-D0E8-1D06-8CC93B009B71",
        'to': to,
        'msg': msg,
        'json': "1",
        'ttl': "1",
        'test': "1",
        'from': "Track App",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
