class Restaurantes {
  final String idUser;
  final String nit;
  final String nombre;
  final String direccion;
  final String telefono;
  final String celular;
  final String descripcion;
  final String email;
  final String contrasena;
  final String foto;

  Restaurantes(
      {required this.idUser,
      required this.nit,
      required this.nombre,
      required this.direccion,
      required this.telefono,
      required this.celular,
      required this.descripcion,
      required this.email,
      required this.contrasena,
      required this.foto});

  factory Restaurantes.fromMap(Map<String, dynamic> data) {
    return Restaurantes(
      idUser: data['id_user'] ?? '',
      nit: data['nit'] ?? '',
      nombre: data['nombre'] ?? '',
      direccion: data['direccion'] ?? '',
      telefono: data['telefono'] ?? '',
      celular: data['celular'] ?? '',
      descripcion: data['descripcion'] ?? '',
      email: data['email'] ?? '',
      contrasena: data['contrasena'] ?? '',
      foto: data['foto'] ?? '',
    );
  }

  factory Restaurantes.fromDoc(Map<String, dynamic> data) {
    return Restaurantes(
      idUser: data['id_user'] ?? '',
      nit: data['nit'] ?? '',
      nombre: data['nombre'] ?? '',
      direccion: data['direccion'] ?? '',
      telefono: data['telefono'] ?? '',
      celular: data['celular'] ?? '',
      descripcion: data['descripcion'] ?? '',
      email: data['email'] ?? '',
      contrasena: data['contrasena'] ?? '',
      foto: data['foto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nit": nit,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "celular": celular,
        "descripcion": descripcion,
        "email": email,
        "contrasena": contrasena,
        "foto": foto
      };
}
