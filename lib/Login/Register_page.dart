import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/Login/login_page.dart';
import 'package:parcial_1_app_movil/peticiones/peticionespersona.dart';

import '../Controller/connectivity.dart';
import '../Controller/controllerAuthPersona.dart';

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
  late TextEditingController _controlDireccion;
  late TextEditingController _controlEmail;
  late TextEditingController _controlcontrasena;
  late TextEditingController _controlConfContra;
  late TextEditingController _controlEdad;
  // var tipoUsuario = "Persona";

  Controllerauth controluser = Get.find();
  late ConnectivityController connectivityController;
  @override
  void initState() {
    _controlIdentificacion = TextEditingController();
    _controlNombre = TextEditingController();
    _controlApellido = TextEditingController();
    _controlCelular = TextEditingController();
    _controlDireccion = TextEditingController();
    _controlEmail = TextEditingController();
    _controlcontrasena = TextEditingController();
    _controlConfContra = TextEditingController();
    _controlEdad = TextEditingController();

    connectivityController = Get.find<ConnectivityController>();
    super.initState();
  }

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await controluser.registrarEmail(theEmail, thePassword);
      if (controluser.emailf != 'Sin Registro') {
        Get.to(() => LoginPage());
      } else {
        Get.snackbar(
          "Login",
          'Ingrese un Email Válido',
          icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (err) {
      print(err.toString());
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //CARGUE DE IMAGENES
  ImagePicker picker = ImagePicker();
  var _image;

  _fromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      //_image = File(image!.path);
    });
  }

  _fromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      // _image = File(image!.path);
    });
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
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Flexible(
                      child: GestureDetector(
                    onTap: () {
                      _opcioncamara(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 55,
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldsNumbers(_controlIdentificacion, 'Identificación',
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
              TextFieldsNumbers(
                _controlEdad,
                'Edad',
                'Edad',
                Icon(Icons.confirmation_num_rounded),
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldsNumbers(_controlCelular, 'Celular', 'Celular',
                  Icon(Icons.phone_android)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlDireccion, 'Direccion', 'Direccion',
                  Icon(Icons.directions)),
              SizedBox(
                height: 15,
              ),
              TextFields(
                  _controlEmail, 'Email', 'Email', Icon(Icons.email_sharp)),
              SizedBox(
                height: 15,
              ),
              PasswordTextField(_controlcontrasena, 'Nueva contraseña',
                  'Ingrese nueva contraseña', Icon(Icons.password)),
              SizedBox(
                height: 25,
              ),
              PasswordTextField(_controlConfContra, 'Confirmar contraseña',
                  'Confirmar contraseña', Icon(Icons.check_circle_outline)),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controlApellido.text.isNotEmpty ||
                      _controlCelular.text.isNotEmpty ||
                      _controlConfContra.text.isEmpty ||
                      _controlDireccion.text.isNotEmpty ||
                      _controlEdad.text.isNotEmpty ||
                      _controlEmail.text.isNotEmpty ||
                      _controlIdentificacion.text.isNotEmpty ||
                      _controlNombre.text.isNotEmpty ||
                      _controlcontrasena.text.isNotEmpty) {
                    if (_controlcontrasena.text == _controlConfContra.text) {
                      //verifica la conexion a la red y/o crea el usuario
                      if (connectivityController.connected) {
                        _login(_controlEmail.text, _controlcontrasena.text);
                      } else {
                        GetSnackBar(
                          title: 'No esta conectado a una Red',
                          duration: Duration(seconds: 5),
                        );
                      }
                      var persona = <String, dynamic>{
                        'id_user': controluser.uid,
                        'identificacion': _controlIdentificacion.text,
                        'nombre': _controlNombre.text,
                        'apellido': _controlApellido.text,
                        'edad': _controlEdad.text,
                        'celular': _controlCelular.text,
                        'direccion': _controlDireccion.text,
                        'email': _controlEmail.text,
                        'contrasena': _controlcontrasena.text,
                        'foto': '',
                      };
                      PeticionesPersona.crearPersona(persona, _image);
                    } else {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Center(
                                    child: Text(
                                  'Las contraseñas no coinciden',
                                  style: TextStyle(color: Colors.red),
                                )),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'ok',
                                      style: TextStyle(
                                          fontFamily: 'cursive',
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ));
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Center(
                                  child: Text(
                                'Todos los campos son obligatorios',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'ok',
                                    style: TextStyle(
                                        fontFamily: 'cursive',
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ));
                  }
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

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Imagen de Galeria'),
                      onTap: () {
                        _fromGallery();
                        Get.back();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Capturar Imagen'),
                    onTap: () {
                      _fromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
