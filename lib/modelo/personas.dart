class Personas {
  final String idUser;
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
      {required this.idUser,
      required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.edad,
      required this.celular,
      required this.direccion,
      required this.email,
      required this.contrasena,
      required this.foto});

  factory Personas.fromMap(Map<String, dynamic> data) {
    return Personas(
      idUser: data['id_user'] ?? '',
      identificacion: data['identificacion'] ?? '',
      nombre: data['nombre'] ?? '',
      apellido: data['apellido'] ?? '',
      edad: data['edad'] ?? '',
      celular: data['celular'] ?? '',
      direccion: data['direccion'] ?? '',
      email: data['email'] ?? '',
      contrasena: data['contrasena'] ?? '',
      foto: data['foto'] ?? '',
    );
  }

  factory Personas.fromDoc(Map<String, dynamic> data) {
    return Personas(
      idUser: data['id_user'] ?? '',
      identificacion: data['identificacion'] ?? '',
      nombre: data['nombre'] ?? '',
      apellido: data['apellido'] ?? '',
      edad: data['edad'] ?? '',
      celular: data['celular'] ?? '',
      direccion: data['direccion'] ?? '',
      email: data['email'] ?? '',
      contrasena: data['contrasena'] ?? '',
      foto: data['foto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "identificacion": identificacion,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "celular": celular,
        "direccion": direccion,
        "email": email,
        "contrasena": contrasena,
        "foto": foto
      };
}
