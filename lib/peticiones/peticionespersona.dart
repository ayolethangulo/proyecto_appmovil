import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parcial_1_app_movil/modelo/personas.dart';
import 'package:http/http.dart' as http;

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

Future<String> adicionarPersona(String identificacion, String nombre,
    String apellido, String celular, String email, String edad) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/add_persona.php');

  final response = await http.post(url, body: {
    'identificacion': identificacion,
    'nombre': nombre,
    'apellido': apellido,
    'celular': celular,
    'email': email,
    'edad': edad
  });
  // final pasar = json.decode(response.body).cast<Map<String, dynamic>>();
  return response.body;
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
