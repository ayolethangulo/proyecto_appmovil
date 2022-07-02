import 'dart:ui';

import 'package:flutter/material.dart';

class HomeRestaurant extends StatefulWidget {
  HomeRestaurant({Key? key}) : super(key: key);

  @override
  State<HomeRestaurant> createState() => _HomeRestaurantState();
}

class _HomeRestaurantState extends State<HomeRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Row(
          children: [
            Text(
              'Restaurante donde jj',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Nombre de Usuario'),
              accountEmail: Text('ejemplo@gmail.com'),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Image.asset(
                    'image/rest.png',
                    height: 100,
                  )),
              decoration: BoxDecoration(color: Colors.red[700]),
            ),
            ListTile(
              title: Text(
                'Inicio',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Configuracion de la cuenta',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Ayuda',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.help_outline),
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      // center padding colum
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/restaurante.png',
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                        'RESTAURANTES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Divider(
                height: 20,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _opcion('Menu', 'image/menurojo.png', 'Menu'),
                SizedBox(
                  width: 40,
                ),
                _opcion('noticias y promociones', 'image/altoparlante.png',
                    'Noticias y\nPromociones'),
                SizedBox(
                  width: 40,
                ),
                _opcion('imagenes del restaurante', 'image/galeria1.png',
                    'Presentación \ndel restaurante'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _opcion('calificaciones', 'image/calificacion.png',
                    'Calificaciones'),
                SizedBox(
                  width: 40,
                ),
                _opcion('dirección', 'image/ubicacion.png', 'Ubicación'),
              ],
            ),
            // SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  _opcion(String _tooltip, String _rutaImagen, String _textoBoton) {
    return Container(
        child: Column(
      children: [
        IconButton(
          highlightColor: Colors.red,
          iconSize: 60,
          tooltip: _tooltip,
          onPressed: () {
            //Agregar el parametro para recibir la funcion e ir a la pagina correspondiente
          },
          icon: Image.asset(
            _rutaImagen,
            fit: BoxFit.fill,
          ),
        ),
        Text(
          _textoBoton,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
