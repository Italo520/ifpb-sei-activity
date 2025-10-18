import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/jwt_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String loginUrl = "${AppConfig.baseUrl}/api/auth/signin";
  final String signupUrl = "${AppConfig.baseUrl}/api/auth/signup";
  final _storage = new FlutterSecureStorage();
  JwtResponse? _jwtResponse;

  Future<JwtResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      _jwtResponse = JwtResponse.fromJson(jsonDecode(response.body));
      await saveToken(_jwtResponse!.token);
      return _jwtResponse!;
    } else {
      throw Exception('Failed to login.');
    }
  }

  Future<void> signup(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse(signupUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sign up.');
    }
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> deleteToken() async {
    _jwtResponse = null;
    await _storage.delete(key: 'jwt_token');
  }

  JwtResponse? get jwtResponse => _jwtResponse;
}
