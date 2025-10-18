import 'package:explora_jampa/models/interest.dart';
import 'package:explora_jampa/screens/home_screen.dart';
import 'package:explora_jampa/services/interest_service.dart';
import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  late Future<List<Interest>> _futureInterests;
  final Set<int> _selectedInterests = {};
  final _interestService = InterestService();

  @override
  void initState() {
    super.initState();
    _futureInterests = _interestService.getInterests();
  }

  void _toggleInterest(int interestId) {
    setState(() {
      if (_selectedInterests.contains(interestId)) {
        _selectedInterests.remove(interestId);
      } else {
        _selectedInterests.add(interestId);
      }
    });
  }

  void _saveAndContinue() async {
    try {
      await _interestService.saveUserInterests(_selectedInterests);
      _navigateToHome();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao salvar interesses: ${e.toString()}')),
      );
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Map<String, IconData> _iconMapping = {
    "Praias": Icons.beach_access,
    "Cultura": Icons.museum,
    "Gastronomia": Icons.restaurant,
    "Ecoturismo": Icons.eco,
    "Aventura": Icons.explore,
    "Relaxar": Icons.self_improvement,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seus Interesses'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Interest>>(
        future: _futureInterests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar interesses: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selecione seus interesses para receber sugestões personalizadas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Interest interest = snapshot.data![index];
                      bool isSelected = _selectedInterests.contains(interest.id);
                      return ChoiceChip(
                        label: Text(interest.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          _toggleInterest(interest.id);
                        },
                        avatar: Icon(_iconMapping[interest.name] ?? Icons.category),
                        selectedColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      );
                    },
                  ),
                ),
                _buildActionButtons(),
              ],
            );
          } else {
            return Center(child: Text('Nenhum interesse encontrado.'));
          }
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _navigateToHome,
            child: Text('Pular'),
          ),
          ElevatedButton(
            onPressed: _saveAndContinue,
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
