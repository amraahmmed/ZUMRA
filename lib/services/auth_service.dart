import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "http://localhost:5000";

  /// ================= LOGIN =================
  static Future<void> login({
    required String userName,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/Account/Login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userName": userName,
        "password": password,
        "rememberMe": true,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw "Invalid email or password";
    } else {
      throw "Something went wrong";
    }
  }

  /// ================= REGISTER =================
  static Future<void> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/Account/Register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "acceptTerms": true,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      final body = jsonDecode(response.body);
      throw body["message"] ?? "Registration failed";
    }
  }

  /// ================= RESEND CONFIRMATION EMAIL =================
  static Future<void> resendConfirmationEmail({
    required String email,
  }) async {
    final url =
        Uri.parse("$_baseUrl/Auth/Account/ResendconfirmEmail?Email=$email");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return;
    } else {
      final body = jsonDecode(response.body);
      throw body["message"] ?? "Failed to resend email";
    }
  }

  /// ================= VERIFY OTP =================
  static Future<void> verifyOTP({
    required String email,
    required String otp,
  }) async {
    final url =
        Uri.parse("$_baseUrl/Auth/Account/VerifyOTP?OtpCode=$otp&Email=$email");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return;
    } else {
      final body = jsonDecode(response.body);
      throw body["message"] ?? "OTP verification failed";
    }
  }
    /// ================= FORGOT PASSWORD =================
  static Future<void> forgotPassword({
    required String email,
  }) async {
    final url =
        Uri.parse("$_baseUrl/Auth/Account/ForgotPassword?Email=$email");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return;
    } else {
      final body = jsonDecode(response.body);
      throw body["message"] ?? "Failed to send password reset code";
    }
  }
    /// ================= RESET PASSWORD =================
  static Future<void> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/Account/ResetPassword");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      final body = jsonDecode(response.body);
      throw body["message"] ?? "Failed to reset password";
    }
  }
}