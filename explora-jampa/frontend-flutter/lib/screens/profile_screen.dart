import 'package:explora_jampa/models/badge.dart';
import 'package:explora_jampa/models/user.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:explora_jampa/services/gamification_service.dart';
import 'package:explora_jampa/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> futureUser;
  late Future<List<Badge>> futureBadges;
  final _profileService = ProfileService();
  final _gamificationService = GamificationService();
  final _authService = AuthService();
  int? _userId;

  @override
  void initState() {
    super.initState();
    _userId = _authService.jwtResponse?.id;
    if (_userId != null) {
      futureUser = _profileService.getUser(_userId!);
      futureBadges = _gamificationService.getUserBadges(_userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Perfil')),
        body: Center(child: Text('Faça login para ver seu perfil.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Erro ao carregar perfil: ${userSnapshot.error}'));
          } else if (userSnapshot.hasData) {
            User user = userSnapshot.data!;
            return Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                SizedBox(height: 10),
                Text(user.username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(user.email, style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Divider(),
                Text('Conquistas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: FutureBuilder<List<Badge>>(
                    future: futureBadges,
                    builder: (context, badgeSnapshot) {
                      if (badgeSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (badgeSnapshot.hasError) {
                        return Center(child: Text('Erro ao carregar conquistas: ${badgeSnapshot.error}'));
                      } else if (badgeSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: badgeSnapshot.data!.length,
                          itemBuilder: (context, index) {
                            Badge badge = badgeSnapshot.data![index];
                            return ListTile(
                              leading: Image.network(badge.iconUrl, width: 40, height: 40, errorBuilder: (c, e, s) => Icon(Icons.error)),
                              title: Text(badge.name),
                              subtitle: Text(badge.description),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('Nenhuma conquista encontrada.'));
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('Nenhum usuário encontrado.'));
          }
        },
      ),
    );
  }
}
