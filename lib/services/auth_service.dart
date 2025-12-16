import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart';
import 'google_sheets_service.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserData = 'userData';

  /// Hash password using SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Register a new user
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String organization,
    required String phone,
    required String role,
    required bool attendHackathon,
  }) async {
    try {
      // Check if user already exists
      final exists = await GoogleSheetsService.userExists(email);
      if (exists) {
        return {
          'success': false,
          'message': 'An account with this email already exists',
        };
      }

      // Create user object
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        nationalId: nationalId,
        organization: organization,
        phone: phone,
        role: role,
        attendHackathon: attendHackathon,
        registrationId: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now().toIso8601String(),
      );

      // Hash password
      final passwordHash = hashPassword(password);

      // Save to Google Sheets
      final success = await GoogleSheetsService.addUser(user, passwordHash);

      if (success) {
        // Save login state
        await saveUserSession(user);

        return {
          'success': true,
          'message': 'Registration successful!',
          'user': user,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to register. Please try again.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  /// Login user
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Hash password
      final passwordHash = hashPassword(password);

      // Authenticate with Google Sheets
      final user = await GoogleSheetsService.authenticateUser(email, passwordHash);

      if (user != null) {
        // Save login state
        await saveUserSession(user);

        return {
          'success': true,
          'message': 'Login successful!',
          'user': user,
        };
      } else {
        return {
          'success': false,
          'message': 'Invalid email or password',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  /// Save user session
  static Future<void> saveUserSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserEmail, user.email);
    await prefs.setString(_keyUserData, json.encode(user.toJson()));
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Get current user
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_keyUserData);

    if (userDataString != null) {
      final userJson = json.decode(userDataString);
      return User.fromJson(userJson);
    }
    return null;
  }

  /// Refresh user data from Google Sheets
  static Future<User?> refreshUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_keyUserEmail);

    if (email != null) {
      final user = await GoogleSheetsService.getUserByEmail(email);
      if (user != null) {
        await saveUserSession(user);
      }
      return user;
    }
    return null;
  }

  /// Logout user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserData);
    // Keep registration data for QR code if exists
  }
}
