import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial_1_app_movil/Login/Register_page.dart';
import 'package:parcial_1_app_movil/Login/Register_restaurant.dart';
import 'package:parcial_1_app_movil/pages/viewMain.dart';
import 'package:parcial_1_app_movil/peticiones/peticionesuser.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  static String user = 'Admin';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController controladorcorreo;
  late TextEditingController controladorcontra;

  @override
  void initState() {
    controladorcorreo = TextEditingController();
    controladorcontra = TextEditingController();

    super.initState();
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
                  fontSize: 30,
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
            _comboRoles(),
            SizedBox(
              height: 15.0,
            ),
            _userTextFiel(),
            SizedBox(
              height: 15.0,
            ),
            _passwordTextFiel(),
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
                              content: Text('Restaurante'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterRestaurant()));
                                  },
                                  child: Text(
                                    'Restaurante',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterUser()));
                                  },
                                  child: Text(
                                    'Persona',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Register_User()));
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
      backgroundColor: Colors.black12,
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
            hintText: 'ejemplo@parcial.com',
            labelText: 'Correo Electronico',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  var _items = ['Seleccione', 'Persona', 'Restaurante'];
  String _selectedItem = 'Seleccione';
  Widget _comboRoles() {
    return Center(
        child: SizedBox(
      width: 260,
      child: DropdownButtonFormField(
        hint: Text(_selectedItem),
        items: _items.map((String item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: (_value) => setState(() {
          _selectedItem = _value as String;
        }),
        decoration: InputDecoration(
            // prefix: Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(width: 1, color: Colors.blue))),
      ),
    ));
  }

  Widget _passwordTextFiel() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: controladorcontra,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
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
            'Iniciar Sesion',
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
            validarUsuarios(http.Client(), controladorcorreo.text,
                    controladorcontra.text)
                .then((response) {
              print(response.length);
              if (response.length == 1) {
                Get.to(() => ViewMain());
              } else {
                Get.snackbar(
                  "Login",
                  'Datos Invalidos',
                  icon: Icon(Icons.person, color: Colors.red),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            });
          }
        },
      );
    });
  }
}
