import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/badge.dart';
import 'package:explora_jampa/models/user.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final String userApiUrl = "${AppConfig.baseUrl}/users";
  final String badgesApiUrl = "${AppConfig.baseUrl}/badges";
  final AuthService _authService = AuthService();

  Future<User> getUser(int userId) async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('$userApiUrl/$userId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to load user";
    }
  }

  Future<List<Badge>> getBadges() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse(badgesApiUrl),
       headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Badge> badges = body.map((dynamic item) => Badge.fromJson(item)).toList();
      return badges;
    } else {
      throw "Failed to load badges";
    }
  }
}
