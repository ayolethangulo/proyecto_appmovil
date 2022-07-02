import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/modelo/personas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultasPersonaController extends GetxController {
  static final FirebaseFirestore baseDatos = FirebaseFirestore.instance;
  Rxn<List<Personas>> _userFirestore = Rxn<List<Personas>>();
  Rxn<List<Personas>> _userFirestoreGral = Rxn<List<Personas>>();

  //Consulta individual
  Stream consultaIndividual(String idBusqueda) {
    Query<Map<String, dynamic>> listaIndividual = baseDatos
        .collection('Personas')
        .where('id_user', isEqualTo: idBusqueda);

    log(listaIndividual
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (snapshot) => Personas.fromMap(snapshot.data()),
          ),
        )
        .toList()
        .toString());

    return listaIndividual.snapshots();
  }

  //Consulta general
  Stream<QuerySnapshot> consultaGeneral() {
    CollectionReference listadoGral = baseDatos.collection('Personas');

    return listadoGral.snapshots();
  }

  //extraer los datos
  List<Personas>? get getUser => _userFirestore.value;
  List<Personas>? get getUserGral => _userFirestoreGral.value;

  //Consultar los datos
  Future<void> consultarUsuario(String idBusqueda) async {
    await baseDatos.collection("Personas").get().then((event) {
      List<Personas> _lista = [];
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        if (doc.id == idBusqueda) {
          _lista.add(Personas.fromMap(doc.data()));
        }
      }
      _userFirestore.value = _lista;
      log(_lista.toString());
      guardarDatosPersona(
          getUser![0].identificacion,
          getUser![0].nombre,
          getUser![0].apellido,
          getUser![0].foto,
          getUser![0].celular,
          getUser![0].direccion,
          getUser![0].edad);
    });
  }

  Future<void> guardarDatosPersona(
      identificacion, nombre, apellido, foto, celular, direccion, edad) async {
    Future<SharedPreferences> _localuser = SharedPreferences.getInstance();
    final SharedPreferences localuser = await _localuser;
    localuser.setString('identificacion', identificacion);
    localuser.setString('nombre', nombre);
    localuser.setString('apellido', apellido);
    localuser.setString('foto', foto);
    localuser.setString('celular', celular);
    localuser.setString('direccion', direccion);
    localuser.setString('edad', edad);
  }
}
