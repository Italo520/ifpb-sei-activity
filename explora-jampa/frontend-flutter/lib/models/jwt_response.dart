class JwtResponse {
  final String token;
  final int id;
  final String username;
  final String email;
  final List<String> roles;

  JwtResponse({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
  });

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
      token: json['accessToken'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: List<String>.from(json['roles']),
    );
  }
}
