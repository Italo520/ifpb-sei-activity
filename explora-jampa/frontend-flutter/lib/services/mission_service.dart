import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/mission.dart';
import 'package:http/http.dart' as http;

class MissionService {
  final String apiUrl = "${AppConfig.baseUrl}/missions";

  Future<List<Mission>> getMissions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Mission> missions = body.map((dynamic item) => Mission.fromJson(item)).toList();
      return missions;
    } else {
      throw "Failed to load missions";
    }
  }
}
