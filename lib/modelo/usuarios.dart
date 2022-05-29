class Usuarios {
  final String id;
  final String tipoUsuario;
  final String email;
  final String password;

  Usuarios({
    required this.id,
    required this.tipoUsuario,
    required this.email,
    required this.password,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      id: json['id'],
      tipoUsuario: json['tipoUsuario'],
      email: json['email'],
      password: json['password'],
    );
  }
}
