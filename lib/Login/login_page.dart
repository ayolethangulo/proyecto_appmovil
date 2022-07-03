import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/Controller/connectivity.dart';
import 'package:parcial_1_app_movil/Controller/controllerAuthPersona.dart';
import 'package:parcial_1_app_movil/Login/Register_page.dart';
import 'package:parcial_1_app_movil/Login/Register_restaurant.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/pages/homeRestaurant.dart';
import 'package:parcial_1_app_movil/pages/viewMain.dart';
import 'package:parcial_1_app_movil/peticiones/consultaspersona.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  static String user = 'Admin';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controladorcorreo = TextEditingController();
  TextEditingController controladorcontra = TextEditingController();

  Controllerauth controluser = Get.find();
  ConsultasPersonaController controlConsulta = Get.find();
  late ConnectivityController connectivityController;

  var usuario;
  var contrasena;

  @override
  void initState() {
    super.initState();
    connectivityController = Get.find<ConnectivityController>();
    consultarusuario();
  }

  void consultarusuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? passw = prefs.getString('password');

    if (email != null) {
      setState(() {
        controladorcorreo.text = email;
        controladorcontra.text = passw!;
        if (controluser.emailf != 'Sin Registro')
          _inicio(controladorcorreo.text, controladorcontra.text);
      });
      return;
    }
  }

  _inicio(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await controluser.ingresarEmail(theEmail, thePassword);
      if (controluser.emailf != 'Sin Registro') {
        //Get.to(() => ViewMain());
        Get.to(() => HomeRestaurant());
      } else {
        Get.snackbar(
          "Login",
          'Ingrese un Email Válido',
          icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (err) {
      print(err.toString());
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Raiting Restaurant',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 40,
                  fontFamily: 'cursive',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.0,
            ),
            Flexible(
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  child: Image.asset(
                    'image/rest.png',
                    height: 120,
                  )),
            ),
            SizedBox(
              height: 15.0,
            ),
            _userTextFiel(),
            SizedBox(
              height: 15.0,
            ),
            PasswordTextField(controladorcontra, 'Ingrese una contraseña',
                'Contraseña', Icon(Icons.lock)),
            SizedBox(
              height: 20.0,
            ),
            _bottonLogin(),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '¿Nuevo en Raiting Restaurant?',
                  style: TextStyle(),
                ),
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUser()));
                  },
                  child: Text(
                    'Registrate',
                    style: TextStyle(
                        fontFamily: 'cursive',
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _userTextFiel() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: controladorcorreo,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'ejemplo@gmail.com',
            labelText: 'Correo Electrónico',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.red[700],
            onPrimary: Colors.white,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 15.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            'Iniciar Sesión',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () {
          if (controladorcorreo.text.isEmpty ||
              controladorcontra.text.isEmpty) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text(
                        'Alerta',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        'Campos vacios, verifique para poder ingresar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ));
          } else {
            if (connectivityController.connected) {
              _inicio(controladorcorreo.text, controladorcontra.text);
            } else {
              GetSnackBar(
                title: 'No esta conectado a un Red',
                duration: Duration(seconds: 5),
              );
            }
          }
        },
      );
    });
  }
}
