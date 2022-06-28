import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial_1_app_movil/Login/Register_page.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/Login/login_page.dart';
import 'package:parcial_1_app_movil/peticiones/peticionespersona.dart';
import 'package:parcial_1_app_movil/peticiones/peticionesrestaurante.dart';

import '../Controller/connectivity.dart';
import '../Controller/controllerAuthPersona.dart';

class RegisterRestaurant extends StatefulWidget {
  RegisterRestaurant({Key? key}) : super(key: key);

  @override
  State<RegisterRestaurant> createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  late TextEditingController _controlNit;
  late TextEditingController _controlNombre;
  late TextEditingController _controlDireccion;
  late TextEditingController _controlTelefono;
  late TextEditingController _controlCelular;
  late TextEditingController _controlCorreo;
  late TextEditingController _controlcontrasena;
  late TextEditingController _controlConfContra;

  Controllerauth controluser = Get.find();
  late ConnectivityController connectivityController;

  @override
  void initState() {
    _controlNit = TextEditingController();
    _controlNombre = TextEditingController();
    _controlDireccion = TextEditingController();
    _controlTelefono = TextEditingController();
    _controlCelular = TextEditingController();
    _controlCorreo = TextEditingController();

    _controlcontrasena = TextEditingController();
    _controlConfContra = TextEditingController();
    connectivityController = Get.find<ConnectivityController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Restaurante',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Registrar restaurante',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
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
              TextFields(_controlDireccion, 'Dirección', 'Dirección',
                  Icon(Icons.directions)),
              SizedBox(
                height: 15,
              ),
              TextFieldsNumbers(_controlTelefono, 'Teléfono',
                  'Teléfono de contacto', Icon(Icons.phone)),
              SizedBox(
                height: 15,
              ),
              TextFieldsNumbers(_controlCelular, 'Celular',
                  'Celular de contacto', Icon(Icons.phone_android)),
              SizedBox(
                height: 15,
              ),
              TextFields(
                _controlCorreo,
                'Email',
                'Correo electrónico',
                Icon(Icons.email_sharp),
              ),
              SizedBox(
                height: 25,
              ),
              PasswordTextField(_controlcontrasena, 'Nueva contraseña',
                  'Ingrese nueva contraseña', Icon(Icons.password)),
              SizedBox(
                height: 25,
              ),
              PasswordTextField(_controlConfContra, 'Confirmar contraseña',
                  'Confirmar contraseña', Icon(Icons.check_circle_outline)),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controlNit.text.isEmpty ||
                      _controlNombre.text.isEmpty ||
                      _controlDireccion.text.isEmpty ||
                      _controlTelefono.text.isEmpty ||
                      _controlCelular.text.isEmpty ||
                      _controlCorreo.text.isEmpty ||
                      _controlConfContra.text.isEmpty ||
                      _controlcontrasena.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Error...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle()),
                              actions: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error_outlined,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                        child: Text(
                                      'Todos los campos son obligatorios',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Aceptar',
                                  ),
                                )
                              ],
                            ));
                  } else {
                    if (_controlcontrasena.text == _controlConfContra.text) {
                      if (connectivityController.connected) {
                        _login(_controlCorreo.text, _controlcontrasena.text);
                      } else {
                        GetSnackBar(
                          title: 'No esta conectado a una Red',
                          duration: Duration(seconds: 5),
                        );
                      }
                      var restaurante = <String, dynamic>{
                        'id_user': controluser.uid,
                        'nit': _controlNit.text,
                        'nombre': _controlNombre.text,
                        'direccion': _controlDireccion.text,
                        'telefono': _controlTelefono.text,
                        'celular': _controlCelular.text,
                        'email': _controlCorreo.text,
                        'contrasena': _controlcontrasena.text,
                        'foto': '',
                      };
                      PeticionesPersona.crearPersona(restaurante, _image, 'nit',
                          'Restaurantes', 'perfilRestaurantes');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          'Las contraseñas no coinciden!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red[100],
                        elevation: 20,
                        action: SnackBarAction(
                          label: 'Reingresar',
                          onPressed: () {
                            _controlcontrasena.clear();
                            _controlConfContra.clear();
                          },
                        ),
                      ));
                    }
                  }
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
                height: 60,
              ),
            ],
          )
        ],
      ),
    );
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
          'Ingrese un Email Valido',
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

//CARGUE DE IMAGENES
  ImagePicker picker = ImagePicker();
  var _image;

  _fromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  _fromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }
}
