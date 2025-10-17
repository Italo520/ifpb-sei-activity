import 'package:explora_jampa/models/mission.dart';
import 'package:explora_jampa/services/mission_service.dart';
import 'package:flutter/material.dart';

class MissionsScreen extends StatefulWidget {
  @override
  _MissionsScreenState createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  late Future<List<Mission>> futureMissions;

  @override
  void initState() {
    super.initState();
    futureMissions = MissionService().getMissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missões'),
      ),
      body: Center(
        child: FutureBuilder<List<Mission>>(
          future: futureMissions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Mission mission = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(mission.name),
                      subtitle: Text(mission.description),
                      trailing: Text('${mission.points} Pts'),
                    ),
                  );
                },
              );
            } else {
              return Text('Nenhuma missão encontrada.');
            }
          },
        ),
      ),
    );
  }
}
