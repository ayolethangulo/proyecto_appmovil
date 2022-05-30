import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/Login/login_page.dart';
import 'package:parcial_1_app_movil/peticiones/peticionespersona.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late TextEditingController _controlIdentificacion;
  late TextEditingController _controlNombre;
  late TextEditingController _controlApellido;
  late TextEditingController _controlCelular;
  late TextEditingController _controlEmail;
  late TextEditingController _controlEdad;
  @override
  void initState() {
    _controlIdentificacion = TextEditingController();
    _controlNombre = TextEditingController();
    _controlApellido = TextEditingController();
    _controlCelular = TextEditingController();
    _controlEmail = TextEditingController();
    _controlEdad = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Usuario',
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
                'Información persona',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFields(_controlIdentificacion, 'Identificación',
                  'Identificación', Icon(Icons.person)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlNombre, 'Nombre', 'Nombre',
                  Icon(Icons.text_fields_sharp)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlApellido, 'Apellido', 'Apellido',
                  Icon(Icons.text_fields_sharp)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlCelular, 'Celular', 'Celular',
                  Icon(Icons.phone_android)),
              SizedBox(
                height: 15,
              ),
              TextFields(
                  _controlEmail, 'Email', 'Email', Icon(Icons.email_sharp)),
              SizedBox(
                height: 15,
              ),
              TextFields(
                _controlEdad,
                'Edad',
                'Edad',
                Icon(Icons.confirmation_num_rounded),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  var response = adicionarPersona(
                      _controlIdentificacion.text,
                      _controlNombre.text,
                      _controlApellido.text,
                      _controlCelular.text,
                      _controlEmail.text,
                      _controlEdad.text);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Registrar Persona'),
                            content: Text(response.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text(
                    'Registrar Usuario',
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
