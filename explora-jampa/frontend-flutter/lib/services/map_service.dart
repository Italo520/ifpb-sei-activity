import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/point_of_interest.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:http/http.dart' as http;

class MapService {
  final String apiUrl = "${AppConfig.baseUrl}/pois";
  final AuthService _authService = AuthService();

  Future<List<PointOfInterest>> getPointsOfInterest() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<PointOfInterest> pois = body.map((dynamic item) => PointOfInterest.fromJson(item)).toList();
      return pois;
    } else {
      throw "Failed to load points of interest";
    }
  }
}
