import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parcial_1_app_movil/home_pages/InformacionRest.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              _publication(
                  'Restaurantes CaliPollo',
                  "https://www.crushpixel.com/big-static17/preview4/restaurant-logo-vector-icon-2663950.jpg",
                  3,
                  'El mejor restaurante de pollos de la ciudad de Valledupar, con menus particulares'),
              _publication(
                  'Cielito Lindo',
                  'https://10619-2.s.cdn12.com/rests/original/107_510287937.jpg',
                  4,
                  'Si quieres Asistir a un restaurante elegante y de lujo, ´puedes asistir a Cielito Lindo, donde tenemos las mejores recetas para ti'),
              _publication(
                  'Pizza',
                  'https://static-images.ifood.com.br/image/upload/t_high/logosgde/f1e19c1d-d61d-4a77-a364-e85a1c67e543_PIZZA_MARTA.jpg',
                  5,
                  'Restaurante donde se fabrican las mejores pizzas del municipio Pizza Factory'),
              _publication(
                  'Yadri al horno',
                  'https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/D65K3MSUSJHB3AX5DTTVHK5X5E.jpg',
                  5,
                  'Si necesitas un pastel para tu cumpleaños ven a Yadri al horno, aqui encontraras lo mejor en reposteria')
            ],
          ),
        ],
      ),
    );
  }

  List<String> _caliPollo = [
    'https://images-gmi-pmc.edge-generalmills.com/f5a517df-12c8-4d55-aa70-c882d99122e0.jpg',
    'https://images-gmi-pmc.edge-generalmills.com/f1c75fdc-b10d-4b92-9c60-31d49afaa31f.jpg'
  ];
  Widget _publication(String nombreRestaurante, String urlImagen,
      double calificacion, String descripcion) {
    return ListTile(
      title: Text(nombreRestaurante),
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
