class TideService {
  Future<Map<String, String>> getTideInfo() async {
    // Simulating a network call
    await Future.delayed(Duration(seconds: 1));
    return {
      'status': 'Maré Baixa',
      'time': '08:00',
    };
  }
}
