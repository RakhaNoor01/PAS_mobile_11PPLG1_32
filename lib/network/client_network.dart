import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Table_Model.dart';

class ClientNetwork {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';
  
  static const String registerUrl = 'https://mediadwi.com/api/latihan/register-user';
  static const String loginUrl = 'https://mediadwi.com/api/latihan/login';

  static String get productsUrl => baseUrl + productsEndpoint;

  // Fetch products dari FakeStore API
  static Future<List<TableModel>> fetchProducts() async {
    try {
      print('Fetching products from: $productsUrl');
      final response = await http.get(Uri.parse(productsUrl));

      print('Response Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        return tableModelFromJson(response.body);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<Map<String, dynamic>> registerUser(
    String username, 
    String password, 
    String fullName, 
    String email
  ) async {
    try {
      print('=== REGISTER REQUEST ===');
      print('URL: $registerUrl');
      print('Username: $username');
      print('Password: $password');
      print('Full Name: $fullName');
      print('Email: $email');

      if (username.isEmpty || password.isEmpty || fullName.isEmpty || email.isEmpty) {
        throw Exception('Ada field yang kosong sebelum dikirim ke API!');
      }

      var response = await http.post(
        Uri.parse(registerUrl),
        body: {
          'username': username,
          'password': password,
          'full_name': fullName,
          'email': email,
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        return result;
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Error registering user: $e');
    }
  }

  static Future<Map<String, dynamic>> loginUser(
    String username, 
    String password
  ) async {
    try {
      print('=== LOGIN REQUEST ===');
      print('URL: $loginUrl');
      print('Username: $username');
      print('Password: $password');

      if (username.isEmpty || password.isEmpty) {
        throw Exception('Username atau password kosong!');
      }

      final response = await http.post(
        Uri.parse(loginUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result;
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Error logging in: $e');
    }
  }
}
