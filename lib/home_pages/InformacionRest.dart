import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';

class InformationPage extends StatefulWidget {
  final String restaurante, descripcion;
  final double calificacion;

  // List<String> imagenRest;
  InformationPage(this.restaurante, this.calificacion, this.descripcion);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  late TextEditingController _controllerComment;
  @override
  void initState() {
    _controllerComment = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[700],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.restaurante,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'image/rest.png',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.restaurante,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 35,
                      fontFamily: 'cursive',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                _Calificacion(widget.calificacion),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1, color: Colors.red)),
                  child: Text(
                    'Descripcion: \n' + widget.descripcion,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.asset(
                          imagenes[index]['url'],
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: imagenes.length,
                      pagination: new SwiperPagination(),
                      loop: true,
                      autoplay: true,
                      duration: 500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.grey[100],
                    child: Column(children: [
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        child: TextField(
                          controller: _controllerComment,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: 'Comentario',
                              hintText: 'Añadir comentario',
                              suffix: GestureDetector(
                                child: Icon(Icons.close),
                                onTap: () {
                                  _controllerComment.clear();
                                },
                              ),
                              icon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.send),
                              )),
                        ),
                      ),
                    ]))
              ],
            )
          ],
        ));
  }

  List<String> _comentarios = ['Excelente restaurante', 'Buen ambiente'];
  List<Map> imagenes = [
    {'url': 'image/imagen3.jpg'},
    {'url': 'image/imagen6.jpg'},
    {'url': 'image/imagen7.jpg'},
  ];

  Widget _swiperImages(List<String> images) {
    int longitud = images.length;
    return Swiper(
      viewportFraction: 0.8,
      scale: 0.5,
      autoplay: true,
      duration: 300,
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          images[index],
          fit: BoxFit.cover,
        );
      },
      itemCount: longitud,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
      onTap: (index) {},
    );
  }

  _Calificacion(double calificac) {
    return RatingBar.builder(
      itemCount: 5,
      initialRating: calificac,
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
    );
  }

  List<Comentario> listComentario = [
    Comentario(comentario: 'Buen Ambiente'),
    Comentario(comentario: 'Recetas exquisitas'),
  ];
}

class Comentario {
  var comentario;

  Comentario({this.comentario});
}
