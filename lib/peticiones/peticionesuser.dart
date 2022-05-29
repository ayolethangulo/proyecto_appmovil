import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_1_app_movil/modelo/usuarios.dart';

void validarUsuario(String email, String password) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/validar.php');

  await http.post(url, body: {
    'email': email,
    'password': password,
  });
}

Future<List<Usuarios>> validarUsuarios(
    http.Client client, String email, String password) async {
  var url = Uri.parse(
      'https://pruebamovil2022.000webhostapp.com/proyectoapi/validar.php');

  final response = await http.post(url, body: {
    'email': email,
    'password': password,
  });
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas2, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Usuarios> pasaraListas2(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Usuarios>((json) => Usuarios.fromJson(json)).toList();
}
