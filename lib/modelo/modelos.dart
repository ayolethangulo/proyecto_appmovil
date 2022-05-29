class Registro {
  var correo;
  var contrasena;
 

  Registro({this.correo, this.contrasena});
}

List<Registro> registro = [
  Registro(
      correo: 'admin',
      contrasena: 'admin',
      ),
  
];
class Empleado{
var foto;
var nombre;
var apellido;
var profesion;
var fechaDeNacimiento;
var edad;


 Empleado({this.foto, this.nombre, this.apellido, this.profesion, this.fechaDeNacimiento, this.edad});
}

List<Empleado> empleado = [
  Empleado(
      foto: 'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png',
      nombre: 'Gian',
      apellido: 'Figueroa',
      profesion: 'Ingeniero de sistemas',
      fechaDeNacimiento:'10/2/2000',
      edad: '22',

      ),
  ];