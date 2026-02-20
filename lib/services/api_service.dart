import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String _devBaseUrlWebAndIOS = 'http://localhost:3000';
  static const String _devBaseUrlAndroidEmulator = 'http://10.0.2.2:3000';
  static const String _prodBaseUrl = 'https://super-app-831462757011.asia-south1.run.app';

  static String get baseUrl {
    if (kReleaseMode) return _prodBaseUrl;
    if (kIsWeb) return _devBaseUrlWebAndIOS;
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _devBaseUrlAndroidEmulator;
    }
    return _devBaseUrlWebAndIOS;
  }

  static const String hotelBookingsEndpoint = '/listing/hotel-bookings';

// http://localhost:3000
// https://super-app-831462757011.asia-south1.run.app
  static Map<String, String> headers({String? token}) {
    final h = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      h['Authorization'] = 'Bearer $token';
    }
    return h;
  }

  static Future<http.Response> get(String endpoint, {String? token}) async {
    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers(token: token),
    );
  }

  static Future<http.Response> post(String endpoint, {String? token, Map<String, dynamic>? body}) async {
    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers(token: token),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> patch(String endpoint, {String? token, Map<String, dynamic>? body}) async {
    return await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers(token: token),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> delete(String endpoint, {String? token}) async {
    return await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers(token: token),
    );
  }

  static Future<Map<String, dynamic>> createHotelBooking({
    required String token,
    required int hotelId,
    required DateTime checkIn,
    required DateTime checkOut,
    required List<Map<String, dynamic>> rooms,
  }) async {
    final response = await post(
      hotelBookingsEndpoint,
      token: token,
      body: {
        'hotelId': hotelId,
        'checkIn': checkIn.toIso8601String(),
        'checkOut': checkOut.toIso8601String(),
        'rooms': rooms,
      },
    );

    final dynamic decoded = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : {};
    final map = decoded is Map<String, dynamic>
        ? decoded
        : <String, dynamic>{};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return map;
    }

    throw Exception(
      map['message']?.toString() ?? 'Failed to create hotel booking',
    );
  }
}
