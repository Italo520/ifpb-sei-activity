import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/badge.dart';
import 'package:explora_jampa/models/user.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final String userApiUrl = "${AppConfig.baseUrl}/users";
  final String badgesApiUrl = "${AppConfig.baseUrl}/badges";

  Future<User> getUser(int userId) async {
    final response = await http.get(Uri.parse('$userApiUrl/$userId'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to load user";
    }
  }

  Future<List<Badge>> getBadges() async {
    final response = await http.get(Uri.parse(badgesApiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Badge> badges = body.map((dynamic item) => Badge.fromJson(item)).toList();
      return badges;
    } else {
      throw "Failed to load badges";
    }
  }
}
