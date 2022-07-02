import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/home_pages/InformacionRest.dart';
import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/peticiones/consultasrestaurante.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConsultasRestauranteController consultaRestaurante = Get.find();

  @override
  Widget build(BuildContext context) {
    consultaRestaurante.consultarGral().then((value) => null);
    return Scaffold(
      body: Obx(
        () => ListView.builder(
            itemCount: consultaRestaurante.getResGral!.length == 0
                ? 0
                : consultaRestaurante.getResGral!.length,
            itemBuilder: (context, posicion) => _publication(
                consultaRestaurante.getResGral![posicion].nombre,
                consultaRestaurante.getResGral![posicion].foto,
                3,
                consultaRestaurante.getResGral![posicion].celular)),
      ),
    );
  }

  Widget _publication(String nombreRestaurante, String urlImagen,
      double calificacion, String descripcion) {
    return ListTile(
      title: Text((nombreRestaurante + "|" + "Contacto: " + descripcion)
          .replaceAll("|", "\n")),
      subtitle: RatingBar.builder(
        itemCount: 5,
        initialRating: 3,
        itemSize: 20,
        itemBuilder: (context, _) {
          return Icon(
            Icons.star,
            color: Colors.amber,
          );
        },
        onRatingUpdate: (raiting) {
          print(raiting);
        },
      ),
      leading:
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImagen)),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InformationPage(
                    nombreRestaurante, calificacion, descripcion)));
      },
    );
  }
}
