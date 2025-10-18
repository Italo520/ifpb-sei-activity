import 'package:explora_jampa/screens/interests_screen.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  void _signup() async {
    try {
      await _authService.signup(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      // Logar o usuário automaticamente após o registro
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );
      // Navegar para a tela de interesses
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => InterestsScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha no registro: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuário',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Registrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Voltar para a tela de login
              },
              child: Text('Já tem uma conta? Faça login'),
            ),
          ],
        ),
      ),
    );
  }
}
