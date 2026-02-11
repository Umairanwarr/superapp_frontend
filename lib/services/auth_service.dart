import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthService {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS simulator
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000/auth'; // Ensure this matches user's local setup if different
    }
    return 'http://localhost:3000/auth';
  }

  // Helper to get headers with token
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    // 'Authorization': 'Bearer $token', // Add when token management is implemented
  };

  Future<Map<String, dynamic>> socialLogin({
    required String idToken,
    required String provider,
  }) async {
    final url = Uri.parse('$baseUrl/social-login');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({
          'idToken': idToken,
          'provider': provider,
        }),
      );

      return _handleResponse(response, 'social login');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      );

      return _handleResponse(response, 'register');
    } catch (e) {
      // Re-throw to be handled by controller
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      return _handleResponse(response, 'verify OTP');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}),
      );

      return _handleResponse(response, 'login');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'email': email}),
      );

      return _handleResponse(response, 'forgot password');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/reset-password');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      return _handleResponse(response, 'reset password');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Future<Map<String, dynamic>> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/verify-reset-otp');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      return _handleResponse(response, 'verify reset OTP');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  // New method for updating profile
  Future<Map<String, dynamic>> updateProfile({
    required int userId,
    required String token,
    String? fullName,
    String? gender,
    String? currency,
    String? language,
    bool? isProfileComplete,
  }) async {
    final url = Uri.parse('$baseUrl/../users/$userId');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token', // Uncomment when backend protects this route
        },
        body: jsonEncode({
          if (fullName != null) 'fullName': fullName,
          if (gender != null)
            'gender':
                gender, // Ensure backend expects UPPERCASE if using enum, or handle mapping
          if (currency != null) 'currency': currency,
          if (language != null)
            'lang': language
                .toUpperCase(), // Map 'English' -> 'ENGLISH' in controller or here
          if (isProfileComplete != null) 'isProfileComplete': isProfileComplete,
        }),
      );

      return _handleResponse(response, 'update profile');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  /// Base URL for /users endpoints
  static String get _usersBaseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000/users';
    }
    return 'http://localhost:3000/users';
  }

  /// Edit user profile (name, email, phone, avatar)
  Future<Map<String, dynamic>> editUserProfile({
    required int userId,
    String? fullName,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? avatar,
  }) async {
    final url = Uri.parse('$_usersBaseUrl/$userId');

    final body = <String, dynamic>{};
    if (fullName != null && fullName.isNotEmpty) body['fullName'] = fullName;
    if (firstName != null && firstName.isNotEmpty)
      body['firstName'] = firstName;
    if (lastName != null && lastName.isNotEmpty) body['lastName'] = lastName;
    if (email != null && email.isNotEmpty) body['email'] = email;
    if (phoneNumber != null && phoneNumber.isNotEmpty)
      body['phoneNumber'] = phoneNumber;
    if (avatar != null && avatar.isNotEmpty) body['avatar'] = avatar;

    try {
      final response = await http.patch(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );

      return _handleResponse(response, 'edit profile');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response, String action) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      // Try to parse error message from body
      try {
        final body = jsonDecode(response.body);
        final message = body['message'] ?? body['error'] ?? 'Unknown error';
        throw Exception('Failed to $action: $message');
      } catch (_) {
        throw Exception('Failed to $action: ${response.body}');
      }
    }
  }
}
