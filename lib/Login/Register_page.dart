import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late TextEditingController _controlTest;
  @override
  void initState() {
    _controlTest = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Usuario',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'cursive',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Text(
                'Información persona',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'cursive',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFields(_controlTest, 'Identificacion', 'Identificacion',
                  Icon(Icons.person)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlTest, 'Nombre', 'Nombre',
                  Icon(Icons.text_fields_sharp)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlTest, 'Apellido', 'Apellido',
                  Icon(Icons.text_fields_sharp)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlTest, 'Celular', 'Celular',
                  Icon(Icons.phone_android)),
              SizedBox(
                height: 15,
              ),
              TextFields(_controlTest, 'Email', 'Correo Electronico',
                  Icon(Icons.email_sharp)),
              SizedBox(
                height: 15,
              ),
              TextFields(
                _controlTest,
                'Edad',
                'Edad',
                Icon(Icons.confirmation_num_rounded),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text(
                    'Registrar Usuario',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    onPrimary: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 15.0),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          )
        ],
      ),
    );
  }
}
