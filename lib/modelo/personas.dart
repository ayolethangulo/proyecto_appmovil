class Personas {
  final String identificacion;
  final String nombre;
  final String apellido;
  final String celular;
  final String email;
  final String edad;

  Personas({
    required this.identificacion,
    required this.nombre,
    required this.apellido,
    required this.celular,
    required this.email,
    required this.edad,
  });

  factory Personas.fromJson(Map<String, dynamic> json) {
    return Personas(
      identificacion: json['identificacion'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      celular: json['celular'],
      email: json['email'],
      edad: json['edad'],
    );
  }
}
