import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:parcial_1_app_movil/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parcial_1_app_movil/peticiones/consultaspersona.dart';

import 'Controller/connectivity.dart';
import 'Controller/controllerAuthPersona.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Controllerauth());
  Get.put(ConsultasPersonaController());

  ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  Connectivity().onConnectivityChanged.listen((connectivityStatus) {
    connectivityController.connectivity = connectivityStatus;
  });

  runApp(MyApp());
}
