class Restaurantes {
  final String nit;
  final String nombre;
  final String direccion;
  final String telefono;
  final String celular;
  final String email;
  final String tipoUsuario;

  Restaurantes(
      {required this.nit,
      required this.nombre,
      required this.direccion,
      required this.telefono,
      required this.celular,
      required this.email,
      required this.tipoUsuario});

  factory Restaurantes.fromJson(Map<String, dynamic> json) {
    return Restaurantes(
      nit: json['nit'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      celular: json['celular'],
      email: json['email'],
      tipoUsuario: json['tipoUsuario'],
    );
  }
}
