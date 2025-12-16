import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class GoogleSheetsService {
  // IMPORTANT: Replace these with your actual values
  static const String spreadsheetId = 'YOUR_SPREADSHEET_ID_HERE';
  static const String apiKey = 'YOUR_API_KEY_HERE';
  static const String sheetName = 'Users';

  // Base URL for Google Sheets API
  static const String baseUrl = 'https://sheets.googleapis.com/v4/spreadsheets';

  /// Initialize the sheet with headers (call this once)
  static Future<bool> initializeSheet() async {
    try {
      final headers = [
        'ID',
        'Name',
        'Email',
        'National ID',
        'Organization',
        'Phone',
        'Role',
        'Attend Hackathon',
        'Registration ID',
        'Timestamp',
        'Password Hash'
      ];

      final url = '$baseUrl/$spreadsheetId/values/$sheetName!A1:K1?key=$apiKey';
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'values': [headers]
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error initializing sheet: $e');
      return false;
    }
  }

  /// Add a new user to the sheet
  static Future<bool> addUser(User user, String passwordHash) async {
    try {
      // First, check if user already exists
      final exists = await userExists(user.email);
      if (exists) {
        print('User with email ${user.email} already exists');
        return false;
      }

      final row = [...user.toSheetRow(), passwordHash];

      final url = '$baseUrl/$spreadsheetId/values/$sheetName!A:K:append?valueInputOption=RAW&key=$apiKey';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'values': [row]
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }

  /// Check if user exists by email
  static Future<bool> userExists(String email) async {
    try {
      final url = '$baseUrl/$spreadsheetId/values/$sheetName?key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> rows = data['values'] ?? [];

        // Skip header row
        for (var i = 1; i < rows.length; i++) {
          if (rows[i].length > 2 && rows[i][2].toString().toLowerCase() == email.toLowerCase()) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }

  /// Get user by email and password
  static Future<User?> authenticateUser(String email, String passwordHash) async {
    try {
      final url = '$baseUrl/$spreadsheetId/values/$sheetName?key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> rows = data['values'] ?? [];

        // Skip header row
        for (var i = 1; i < rows.length; i++) {
          final row = rows[i];
          if (row.length > 10 &&
              row[2].toString().toLowerCase() == email.toLowerCase() &&
              row[10].toString() == passwordHash) {
            return User.fromSheetRow(row);
          }
        }
      }
      return null;
    } catch (e) {
      print('Error authenticating user: $e');
      return null;
    }
  }

  /// Get user by email only (for retrieving data after login)
  static Future<User?> getUserByEmail(String email) async {
    try {
      final url = '$baseUrl/$spreadsheetId/values/$sheetName?key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> rows = data['values'] ?? [];

        // Skip header row
        for (var i = 1; i < rows.length; i++) {
          final row = rows[i];
          if (row.length > 2 && row[2].toString().toLowerCase() == email.toLowerCase()) {
            return User.fromSheetRow(row);
          }
        }
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  /// Get all users (admin function)
  static Future<List<User>> getAllUsers() async {
    try {
      final url = '$baseUrl/$spreadsheetId/values/$sheetName?key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> rows = data['values'] ?? [];

        List<User> users = [];
        // Skip header row
        for (var i = 1; i < rows.length; i++) {
          if (rows[i].length >= 10) {
            users.add(User.fromSheetRow(rows[i]));
          }
        }
        return users;
      }
      return [];
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }
}
