import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/Controller/controllerAuthPersona.dart';
import 'package:parcial_1_app_movil/Login/login_page.dart';
import 'package:parcial_1_app_movil/configurations/configuraciones.dart';
import 'package:parcial_1_app_movil/home_pages/Promotions.dart';
import 'package:parcial_1_app_movil/home_pages/bookings.dart';
import 'package:parcial_1_app_movil/home_pages/home.dart';
import 'package:parcial_1_app_movil/peticiones/consultaspersona.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMain extends StatefulWidget {
  ViewMain({Key? key}) : super(key: key);

  @override
  State<ViewMain> createState() => _ViewMainState();
}

class _ViewMainState extends State<ViewMain> {
  late int _selectedIndex = 0;
  Controllerauth controluser = Get.find();
  ConsultasPersonaController controlPersona = Get.find();
  String nombreUsuario = "Usuario";
  String apellidoUsuario = "";
  String fotoUsuario = "";

  @override
  void initState() {
    consultarDatosPersona();
    super.initState();
  }

  consultarDatosPersona() async {
    controlPersona
        .consultarUsuario(controluser.uid)
        .then((value) => nombreUsuario = controlPersona.getUser![0].nombre);
    Future<SharedPreferences> _localuser = SharedPreferences.getInstance();
    final SharedPreferences localuser = await _localuser;
    setState(() {
      nombreUsuario = localuser.getString('nombre').toString();
      apellidoUsuario = localuser.getString('apellido').toString();
      fotoUsuario = localuser.getString('foto').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    controlPersona.consultaGeneral();
    controlPersona.consultaIndividual(controluser.uid);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(nombreUsuario.toUpperCase() +
                  " " +
                  apellidoUsuario.toUpperCase()),
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
                    MaterialPageRoute(builder: (context) => ViewMain()));
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
                        builder: (context) => ConfiguracionUsuarioPage()));
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Raiting Restaurant',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'cursive',
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.refresh)),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Icon(Icons.contact_support_outlined),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.red[700],
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigationBottom,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red[100],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_fix_high_outlined), label: 'Promociones'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_outlined), label: 'reservar'),
        ],
      ),
    );
  }

  _navigationBottom(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    HomePage(),
    PromotionsPage(),
    BookingsPage(),
  ];

  void _cerrarSesion() {
    controlPersona.guardarDatosPersona('', '', '', '', '', '', '');
    controluser.logOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
