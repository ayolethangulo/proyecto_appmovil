import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/Login/login_page.dart';
import 'package:parcial_1_app_movil/peticiones/peticionesrestaurante.dart';

class ConfiguracionRestaurant extends StatefulWidget {
  ConfiguracionRestaurant({Key? key}) : super(key: key);

  @override
  State<ConfiguracionRestaurant> createState() => _ConfiguracionRestaurantState();
}

class _ConfiguracionRestaurantState extends State<ConfiguracionRestaurant> {
  late TextEditingController _controlNit;
  late TextEditingController _controlNombre;
  late TextEditingController _controlDireccion;
  late TextEditingController _controlTelefono;
  late TextEditingController _controlCelular;
  late TextEditingController _controlCorreo;
  var tipoUsuario = "Restaurante";
  @override
  void initState() {
    _controlNit = TextEditingController();
    _controlNombre = TextEditingController();
    _controlDireccion = TextEditingController();
    _controlTelefono = TextEditingController();
    _controlCelular = TextEditingController();
    _controlCorreo = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuracion Restaurante',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'cursive',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Text(
                'Información restaurante',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFields(_controlNit, 'Nit', 'Nit del restaurante',
                  Icon(Icons.home_work_outlined)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlNombre, 'Nombre', 'Nombre del restaurante',
                  Icon(Icons.text_snippet_rounded)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlDireccion, 'Direccion', 'Dirección',
                  Icon(Icons.directions)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlTelefono, 'Telefono', 'Telefono de contacto',
                  Icon(Icons.phone)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlCelular, 'Celular', 'Celular de contacto',
                  Icon(Icons.phone_android)),
              SizedBox(
                height: 15,
              ),
              TextFields(
                _controlCorreo,
                'Email',
                'Correo electronico',
                Icon(Icons.email_sharp),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  editarRestaurante(
                      _controlNit.text,
                      _controlNombre.text,
                      _controlDireccion.text,
                      _controlTelefono.text,
                      _controlCelular.text,
                      _controlCorreo.text,
                      );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text(
                    'Registrar Restaurante',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    onPrimary: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 15.0),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          )
        ],
      ),
    );
  }
}