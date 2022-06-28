import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/Controller/connectivity.dart';
import 'package:parcial_1_app_movil/Controller/controllerAuthPersona.dart';
import 'package:parcial_1_app_movil/Login/Register_page.dart';
import 'package:parcial_1_app_movil/Login/Register_restaurant.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';
import 'package:parcial_1_app_movil/pages/viewMain.dart';
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
  late ConnectivityController connectivityController;

  var usuario;
  var contrasena;

  @override
  void initState() {
    super.initState();
    connectivityController = Get.find<ConnectivityController>();
    consultarusuario();
  }

  _inicio(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await controluser.ingresarEmail(theEmail, thePassword);
      if (controluser.emailf != 'Sin Registro') {
        Get.to(() => ViewMain());
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
            // SizedBox(
            //   height: 15.0,
            // ),
            // _comboRoles(),
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
                  style: TextStyle(fontFamily: 'cursive'),
                ),
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('TIPO DE USUARIO'),
                              actions: [
                                ListTile(
                                  title: Text(
                                    'Restaurante',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  trailing: Icon(Icons.home_work_outlined),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterRestaurant()));
                                  },
                                ),
                                ListTile(
                                  title: Text(
                                    'Persona',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  trailing: Icon(Icons.person_add),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterUser()));
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ));
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

  // var _items = ['Seleccione', 'Persona', 'Restaurante'];
  // String _selectedItem = 'Seleccione';
  // Widget _comboRoles() {
  //   return Center(
  //       child: SizedBox(
  //     width: 260,
  //     child: DropdownButtonFormField(
  //       hint: Text(_selectedItem),
  //       items: _items.map((String item) {
  //         return DropdownMenuItem(value: item, child: Text(item));
  //       }).toList(),
  //       onChanged: (_value) => setState(() {
  //         _selectedItem = _value as String;
  //       }),
  //       decoration: InputDecoration(
  //           // prefix: Icon(Icons.person),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(6),
  //               borderSide: BorderSide(width: 1, color: Colors.blue))),
  //     ),
  //   ));
  // }

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
            // validarUsuarios(http.Client(), controladorcorreo.text,
            //         controladorcontra.text)
            //     .then((response) {
            //   print(response.length);
            //   if (response.length == 1) {
            //     guardarusuario(controladorcorreo.text, controladorcontra.text);
            //     Get.to(() => ViewMain());
            //   } else {
            //     Get.snackbar(
            //       "Login",
            //       'Datos Inválidos',
            //       icon: Icon(Icons.person, color: Colors.red),
            //       snackPosition: SnackPosition.BOTTOM,
            //     );
            //   }
            // });
          }
        },
      );
    });
  }

  consultarusuario() async {
    Future<SharedPreferences> _localuser = SharedPreferences.getInstance();
    final SharedPreferences localuser = await _localuser;
    setState(() {
      usuario = localuser.getString('email');
      contrasena = localuser.getString('password');
    });
    if (usuario != '') {
      if (usuario != null) {
        controladorcorreo = TextEditingController(text: usuario);
        controladorcontra = TextEditingController(text: contrasena);
      }
    }
  }
}
