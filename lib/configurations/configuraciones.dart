import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial_1_app_movil/Controller/controllerAuthPersona.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/modelo/personas.dart';
import 'package:parcial_1_app_movil/pages/viewMain.dart';
import 'package:parcial_1_app_movil/peticiones/peticionespersona.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracionUsuarioPage extends StatefulWidget {
  ConfiguracionUsuarioPage({Key? key}) : super(key: key);
  @override
  State<ConfiguracionUsuarioPage> createState() =>
      _ConfiguracionUsuarioPageState();
}

class _ConfiguracionUsuarioPageState extends State<ConfiguracionUsuarioPage> {
  Controllerauth controluser = Get.find();
  late Personas personas;
  var bandera = 0;
  late TextEditingController _controlIdentificacion;
  late TextEditingController _controlNombre;
  late TextEditingController _controlApellido;
  late TextEditingController _controlCelular;
  late TextEditingController _controlDireccion;
  late TextEditingController _controlEdad;

  @override
  void initState() {
    _controlIdentificacion = TextEditingController();
    _controlNombre = TextEditingController();
    _controlApellido = TextEditingController();
    _controlCelular = TextEditingController();
    _controlDireccion = TextEditingController();
    _controlEdad = TextEditingController();
    consultarDatosusuario();
    super.initState();
  }

  void consultarDatosusuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? identificacion = prefs.getString('identificacion');
    final String? nombre = prefs.getString('nombre');
    final String? apellido = prefs.getString('apellido');
    final String? celular = prefs.getString('celular');
    final String? direccion = prefs.getString('direccion');
    final String? edad = prefs.getString('edad');
    if (identificacion != null) {
      setState(() {
        bandera = 1;
        _controlIdentificacion.text = identificacion.toString();
        _controlNombre.text = nombre.toString();
        _controlApellido.text = apellido.toString();
        _controlCelular.text = celular.toString();
        _controlDireccion.text = direccion.toString();
        _controlEdad.text = edad.toString();
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
          'Configuración Usuario',
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
                'Información personal',
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
              TextFields(_controlDireccion, 'Dirección', 'Dirección',
                  Icon(Icons.directions)),
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
                  var persona = <String, dynamic>{
                    'id_user': controluser.uid,
                    'identificacion': _controlIdentificacion.text,
                    'nombre': _controlNombre.text,
                    'apellido': _controlApellido.text,
                    'edad': _controlEdad.text,
                    'celular': _controlCelular.text,
                    'direccion': _controlDireccion.text,
                    'foto': '',
                  };
                  if (bandera == 0) {
                    _guardarPersona(persona);
                  } else {
                    _modificarPersona(persona);
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text(
                    'Guardar Datos',
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

  void _guardarPersona(Map<String, dynamic> persona) {
    PeticionesPersona.crearPersona(
        persona, _image, 'Personas', 'perfilPersonas');
    Get.snackbar(
      "Registrar",
      'Datos Registrados',
      icon: Icon(Icons.check, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewMain()));
  }

  void _modificarPersona(Map<String, dynamic> persona) {
    PeticionesPersona.actualizarPersona(
        controluser.uid, _image, persona, 'Personas', 'perfilPersonas');
    Get.snackbar(
      "Actualizar",
      'Datos Actualizados',
      icon: Icon(Icons.check, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewMain()));
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
