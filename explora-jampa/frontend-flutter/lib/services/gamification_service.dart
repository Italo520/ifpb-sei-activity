import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/badge.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:http/http.dart' as http;

class GamificationService {
  final String gamificationUrl = "${AppConfig.baseUrl}/api/gamification";
  final AuthService _authService = AuthService();

  Future<void> startMission(int missionId) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$gamificationUrl/missions/$missionId/start'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to start mission.');
    }
  }

  Future<void> completeMission(int missionId) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$gamificationUrl/missions/$missionId/complete'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to complete mission.');
    }
  }

  Future<List<Badge>> getUserBadges(int userId) async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('$gamificationUrl/users/$userId/badges'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // A resposta da API é uma lista de UserBadge, então precisamos extrair o Badge
      List<Badge> badges = body.map((dynamic item) => Badge.fromJson(item['badge'])).toList();
      return badges;
    } else {
      throw Exception('Failed to load user badges.');
    }
  }
}
