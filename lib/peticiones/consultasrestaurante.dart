import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/modelo/restaurante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultasRestauranteController extends GetxController {
  static final FirebaseFirestore baseDatos = FirebaseFirestore.instance;
  Rxn<List<Restaurantes>> _userFirestoreRes = Rxn<List<Restaurantes>>();
  Rxn<List<Restaurantes>> _userFirestoreGralRes = Rxn<List<Restaurantes>>();

  //Consulta individual
  Stream consultaIndividual(String idBusqueda) {
    Query<Map<String, dynamic>> listaIndividual = baseDatos
        .collection('Restaurantes')
        .where('id_user', isEqualTo: idBusqueda);

    log(listaIndividual
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (snapshot) => Restaurantes.fromMap(snapshot.data()),
          ),
        )
        .toList()
        .toString());

    return listaIndividual.snapshots();
  }

  //Consulta general
  Stream<QuerySnapshot> consultaGeneral() {
    CollectionReference listadoGral = baseDatos.collection('Restaurantes');

    return listadoGral.snapshots();
  }

  //extraer los datos
  List<Restaurantes>? get getRes => _userFirestoreRes.value;
  List<Restaurantes>? get getResGral => _userFirestoreGralRes.value;

  //Consultar los datos
  Future<void> consultarRestaurante(String idBusqueda) async {
    await baseDatos.collection("Restaurantes").get().then((event) {
      List<Restaurantes> _lista = [];
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        if (doc.id == idBusqueda) {
          _lista.add(Restaurantes.fromMap(doc.data()));
        }
      }
      _userFirestoreRes.value = _lista;
      log(_lista.toString());
      guardarDatosRestaurante(
          getRes![0].nit,
          getRes![0].nombre,
          getRes![0].direccion,
          getRes![0].foto,
          getRes![0].telefono,
          getRes![0].celular,
          getRes![0].descripcion);
    });
  }

//Consultar los datos
  Future<void> consultarGral() async {
    await baseDatos.collection("Restaurantes").get().then((event) {
      List<Restaurantes> _lista = [];
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");

        _lista.add(Restaurantes.fromMap(doc.data()));
      }
      _userFirestoreGralRes.value = _lista;
      log(_lista.toString());
    });
  }

  Future<void> guardarDatosRestaurante(
      nit, nombre, direccion, foto, telefono, celular, descripcion) async {
    Future<SharedPreferences> _localRes = SharedPreferences.getInstance();
    final SharedPreferences localRes = await _localRes;
    localRes.setString('nit', nit);
    localRes.setString('nombreR', nombre);
    localRes.setString('direccionR', direccion);
    localRes.setString('fotoR', foto);
    localRes.setString('telefono', telefono);
    localRes.setString('celularR', celular);
    localRes.setString('descripcion', descripcion);
  }
}
