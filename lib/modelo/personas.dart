class Personas {
  final String identificacion;
  final String nombre;
  final String apellido;
  final String edad;
  final String celular;
  final String direccion;
  final String email;
  final String contrasena;
  final String foto;
  // final String tipoUsuario;

  Personas(
      {required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.edad,
      required this.celular,
      required this.direccion,
      required this.email,
      required this.contrasena,
      required this.foto});

  factory Personas.fromJson(Map<String, dynamic> json) {
    return Personas(
        identificacion: json['identificacion'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        edad: json['edad'],
        celular: json['celular'],
        direccion: json['direccion'],
        email: json['email'],
        contrasena: json['contrasena'],
        foto: json['foto']);
  }
}
