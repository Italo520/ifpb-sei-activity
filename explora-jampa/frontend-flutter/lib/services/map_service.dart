import 'dart:convert';
import 'package:explora_jampa/config.dart';
import 'package:explora_jampa/models/point_of_interest.dart';
import 'package:http/http.dart' as http;

class MapService {
  final String apiUrl = "${AppConfig.baseUrl}/pois";

  Future<List<PointOfInterest>> getPointsOfInterest() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<PointOfInterest> pois = body.map((dynamic item) => PointOfInterest.fromJson(item)).toList();
      return pois;
    } else {
      throw "Failed to load points of interest";
    }
  }
}
