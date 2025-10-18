import 'package:explora_jampa/models/mission.dart';
import 'package:explora_jampa/services/gamification_service.dart';
import 'package:explora_jampa/services/mission_service.dart';
import 'package:flutter/material.dart';

class MissionsScreen extends StatefulWidget {
  @override
  _MissionsScreenState createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  late Future<List<Mission>> futureMissions;
  final _gamificationService = GamificationService();

  @override
  void initState() {
    super.initState();
    futureMissions = MissionService().getMissions();
  }

  void _startMission(int missionId) async {
    try {
      await _gamificationService.startMission(missionId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Missão iniciada com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao iniciar missão: ${e.toString()}')),
      );
    }
  }

  void _completeMission(int missionId) async {
    try {
      await _gamificationService.completeMission(missionId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Missão concluída com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao concluir missão: ${e.toString()}')),
      );
    }
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${mission.points} Pts'),
                          IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () => _startMission(mission.id),
                          ),
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () => _completeMission(mission.id),
                          ),
                        ],
                      ),
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
