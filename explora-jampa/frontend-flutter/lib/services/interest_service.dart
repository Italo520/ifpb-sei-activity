import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/interest.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:http/http.dart' as http;

class InterestService {
  final String interestsUrl = "${AppConfig.baseUrl}/api/interests";
  final String saveInterestsUrl = "${AppConfig.baseUrl}/api/users/me/interests";
  final AuthService _authService = AuthService();

  Future<List<Interest>> getInterests() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse(interestsUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Interest> interests = body.map((dynamic item) => Interest.fromJson(item)).toList();
      return interests;
    } else {
      throw Exception('Failed to load interests.');
    }
  }

  Future<void> saveUserInterests(Set<int> interestIds) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse(saveInterestsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(interestIds.toList()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save user interests.');
    }
  }
}
