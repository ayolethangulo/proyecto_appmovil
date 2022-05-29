import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parcial_1_app_movil/modelo/restaurante.dart';
import 'package:http/http.dart' as http;

Future<List<Restaurantes>> listaRestaurantes(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/listar_restaurante.php'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Restaurantes> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar
      .map<Restaurantes>((json) => Restaurantes.fromJson(json))
      .toList();
}

void adicionarRestaurante(String nit, String nombre, String direccion,
    String telefono, String celular, String email) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/add_restaurante.php');

  await http.post(url, body: {
    'nit': nit,
    'nombre': nombre,
    'direccion': direccion,
    'telefono': telefono,
    'celular': celular,
    'email': email
  });
}

void editarRestaurante(String nit, String nombre, String direccion,
    String telefono, String celular, String email) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/update_restaurante.php');

  await http.post(url, body: {
    'nit': nit,
    'nombre': nombre,
    'direccion': direccion,
    'telefono': telefono,
    'celular': celular,
    'email': email
  });
}

void eliminarRestaurante(id) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/delete_restaurante.php');

  await http.post(url, body: {
    'ideliminar': id,
  });
}
