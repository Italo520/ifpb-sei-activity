import 'package:explora_jampa/models/point_of_interest.dart';
import 'package:explora_jampa/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<List<PointOfInterest>> futurePois;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    futurePois = MapService().getPointsOfInterest();
  }

  void _onMapCreated(GoogleMapController controller) {
    futurePois.then((pois) {
      setState(() {
        _markers = pois.map((poi) {
          return Marker(
            markerId: MarkerId(poi.id.toString()),
            position: LatLng(poi.latitude, poi.longitude),
            infoWindow: InfoWindow(
              title: poi.name,
              snippet: poi.description,
            ),
          );
        }).toSet();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de João Pessoa'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<PointOfInterest>>(
        future: futurePois,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar o mapa: ${snapshot.error}'));
          } else {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-7.1195, -34.8451), // Center of João Pessoa
                zoom: 12,
              ),
              markers: _markers,
            );
          }
        },
      ),
    );
  }
}
