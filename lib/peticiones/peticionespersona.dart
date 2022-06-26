import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:parcial_1_app_movil/modelo/personas.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PeticionesPersona {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore baseDatos = FirebaseFirestore.instance;

  static Future<void> crearPersona(Map<String, dynamic> persona, foto) async {
    print(persona['foto']);

    var url = '';
    if (foto != null)
      url = await PeticionesPersona._loadPhoto(foto, persona['id_user']);
    print(url);

    persona['foto'] = url.toString();
    await baseDatos
        .collection('Personas')
        .doc(persona['id_user'])
        .set(persona)
        .catchError((e) {
      print(e);
    });
  }

  static Future<dynamic> _loadPhoto(var foto, var idFoto) async {
    final fs.Reference storageRef =
        fs.FirebaseStorage.instance.ref().child("perfilPersonas");

    fs.TaskSnapshot taskSnapshot = await storageRef.child(idFoto).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('URL: ' + url.toString());
    return url.toString();
  }
}

Future<List<Personas>> listaPersonas(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/listar_persona.php'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Personas> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Personas>((json) => Personas.fromJson(json)).toList();
}

void adicionarPersona(String identificacion, String nombre, String apellido,
    String celular, String email, String edad, String tipoUsuario) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/add_persona.php');

  await http.post(url, body: {
    'identificacion': identificacion,
    'nombre': nombre,
    'apellido': apellido,
    'celular': celular,
    'email': email,
    'edad': edad,
    'tipoUsuario': tipoUsuario
  });
}

void editarPersona(String identificacion, String nombre, String apellido,
    String celular, String email, String edad) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/update_persona.php');

  await http.post(url, body: {
    'identificacion': identificacion,
    'nombre': nombre,
    'apellido': apellido,
    'celular': celular,
    'email': email,
    'edad': edad
  });
}

void eliminarPersona(id) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/delete_persona.php');

  await http.post(url, body: {
    'ideliminar': id,
  });
}
