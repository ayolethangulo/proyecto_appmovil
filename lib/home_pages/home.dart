import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                  3),
              _publication(
                  'Cielito Lindo',
                  'https://10619-2.s.cdn12.com/rests/original/107_510287937.jpg',
                  4),
              _publication(
                  'Pizza',
                  'https://static-images.ifood.com.br/image/upload/t_high/logosgde/f1e19c1d-d61d-4a77-a364-e85a1c67e543_PIZZA_MARTA.jpg',
                  5),
              _publication(
                  'Yadri al horno',
                  'https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/D65K3MSUSJHB3AX5DTTVHK5X5E.jpg',
                  5)
            ],
          ),
        ],
      ),
    );
  }

  Widget _publication(
      String nombreRestaurante, String urlImagen, int calificacion) {
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
      onTap: () {},
    );
  }
}
