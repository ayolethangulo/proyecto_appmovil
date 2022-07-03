import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/Controller/controllerAuthPersona.dart';
import 'package:parcial_1_app_movil/Login/login_page.dart';
import 'package:parcial_1_app_movil/configurations/configuracionRest.dart';
import 'package:parcial_1_app_movil/peticiones/consultasrestaurante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRestaurant extends StatefulWidget {
  HomeRestaurant({Key? key}) : super(key: key);

  @override
  State<HomeRestaurant> createState() => _HomeRestaurantState();
}

class _HomeRestaurantState extends State<HomeRestaurant> {
  Controllerauth controluser = Get.find();
  ConsultasRestauranteController controlRestaurante = Get.find();
  String nombreUsuario = "Usuario";
  String fotoUsuario = "";

  @override
  void initState() {
    consultarDatosPersona();
    super.initState();
  }

  consultarDatosPersona() async {
    controlRestaurante
        .consultarRestaurante(controluser.uid)
        .then((value) => nombreUsuario = controlRestaurante.getRes![0].nombre);
    Future<SharedPreferences> _localuser = SharedPreferences.getInstance();
    final SharedPreferences localuser = await _localuser;
    setState(() {
      nombreUsuario = localuser.getString('nombreR').toString();
      fotoUsuario = localuser.getString('fotoR').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Row(
          children: [
            Text(
              nombreUsuario.toUpperCase(),
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
              accountName: Text(nombreUsuario),
              accountEmail: Text(controluser.emailf),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: Container(
                    decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(70.0),
                  image: DecorationImage(image: NetworkImage(fotoUsuario)),
                )),
              ),
              decoration: BoxDecoration(color: Colors.red[700]),
            ),
            ListTile(
              title: Text(
                'Inicio',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    //fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeRestaurant()));
              },
            ),
            ListTile(
              title: Text(
                'Configuración de la cuenta',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    //fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfiguracionRestaurant()));
              },
            ),
            ListTile(
              title: Text(
                'Ayuda',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    //fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.help_outline),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Cerrar Sesión',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    //fontFamily: 'cursive',
                    fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.logout),
              onTap: () {
                _cerrarSesion();
              },
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

  void _cerrarSesion() {
    controlRestaurante.guardarDatosRestaurante('', '', '', '', '', '', '');
    controluser.logOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
