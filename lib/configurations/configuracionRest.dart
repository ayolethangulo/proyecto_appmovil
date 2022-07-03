import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial_1_app_movil/Controller/controllerAuthPersona.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/modelo/restaurante.dart';
import 'package:parcial_1_app_movil/pages/homeRestaurant.dart';
import 'package:parcial_1_app_movil/peticiones/peticionespersona.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracionRestaurant extends StatefulWidget {
  ConfiguracionRestaurant({Key? key}) : super(key: key);

  @override
  State<ConfiguracionRestaurant> createState() =>
      _ConfiguracionRestaurantState();
}

class _ConfiguracionRestaurantState extends State<ConfiguracionRestaurant> {
  Controllerauth controluser = Get.find();
  late Restaurantes restaurantes;
  var bandera = 0;
  late TextEditingController _controlNit;
  late TextEditingController _controlNombre;
  late TextEditingController _controlDireccion;
  late TextEditingController _controlTelefono;
  late TextEditingController _controlCelular;
  late TextEditingController _controlDescripcion;

  @override
  void initState() {
    _controlNit = TextEditingController();
    _controlNombre = TextEditingController();
    _controlDireccion = TextEditingController();
    _controlTelefono = TextEditingController();
    _controlCelular = TextEditingController();
    _controlDescripcion = TextEditingController();
    consultarDatosRestaurante();
    super.initState();
  }

  void consultarDatosRestaurante() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nit = prefs.getString('nit');
    final String? nombre = prefs.getString('nombreR');
    final String? direccion = prefs.getString('direccionR');
    final String? telefono = prefs.getString('telefono');
    final String? celular = prefs.getString('celularR');
    final String? descripcion = prefs.getString('descripcion');
    if (nit != null) {
      setState(() {
        bandera = 1;
        _controlNit.text = nit.toString();
        _controlNombre.text = nombre.toString();
        _controlDireccion.text = direccion.toString();
        _controlTelefono.text = telefono.toString();
        _controlCelular.text = celular.toString();
        _controlDescripcion.text = descripcion.toString();
      });
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
    });
  }

  _fromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración Restaurante',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontFamily: 'cursive',
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
                    fontSize: 22,
                    //fontFamily: 'cursive',
                    fontWeight: FontWeight.bold),
              ),
              Center(
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
              TextFields(_controlDescripcion, 'Descripción',
                  'Descripción o Logotipo', Icon(Icons.description)),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  var restaurante = <String, dynamic>{
                    'id_user': controluser.uid,
                    'nit': _controlNit.text,
                    'nombre': _controlNombre.text,
                    'direccion': _controlDireccion.text,
                    'Telefono': _controlTelefono.text,
                    'celular': _controlCelular.text,
                    'descripcion': _controlDescripcion.text,
                    'foto': '',
                  };
                  if (bandera == 0) {
                    _guardarRestaurante(restaurante);
                  } else {
                    _modificarRestaurante(restaurante);
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text(
                    'Guardar datos',
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

  void _guardarRestaurante(Map<String, dynamic> restaurante) {
    PeticionesPersona.crearPersona(
        restaurante, _image, 'Restaurantes', 'perfilRestaurantes');
    Get.snackbar(
      "Registrar",
      'Datos Registrados',
      icon: Icon(Icons.check, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeRestaurant()));
  }

  void _modificarRestaurante(Map<String, dynamic> restaurante) {
    PeticionesPersona.actualizarPersona(controluser.uid, _image, restaurante,
        'Restaurantes', 'perfilRestaurantes');
    Get.snackbar(
      "Actualizar",
      'Datos Actualizados',
      icon: Icon(Icons.check, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeRestaurant()));
  }
}
