import 'package:flutter/material.dart';
import 'package:parcial_1_app_movil/Login/TextFields.dart';

class BookingsPage extends StatefulWidget {
  BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  late TextEditingController _controllerMesa;
  late TextEditingController _controllerPersonas;
  late TextEditingController _controllerFecha;

  @override
  void initState() {
    _controllerMesa = TextEditingController();
    _controllerPersonas = TextEditingController();
    _controllerFecha = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Container(
                  child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                  placeholder: AssetImage('image/reserva.jpg'),
                                  image: AssetImage('image/reserva.jpg')),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Nueva reserva',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              TextFields(_controllerMesa, 'Numero de mesa',
                  'Ingresar numero de la mesa', Icon(Icons.tapas_outlined)),
              SizedBox(
                height: 5,
              ),
              TextFields(_controllerPersonas, 'Numero de personas',
                  'Ingresar numero de la personas', Icon(Icons.person)),
              SizedBox(
                height: 5,
              ),
              _inputDate(context),
              SizedBox(
                height: 110,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text(
                    'Reservar',
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
            ],
          )
        ],
      ),
    );
  }

  Widget _inputDate(BuildContext _context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _controllerFecha,
      decoration: InputDecoration(
          hintText: 'Fecha de reservación',
          labelText: 'Seleccionar fecha para reserva',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: Icon(Icons.perm_contact_calendar)),
      onTap: () {
        FocusScope.of(_context).requestFocus(new FocusNode());
        _selectedDate(context);
      },
    );
  }

  _selectedDate(BuildContext _context) async {
    //DateTime fechaActual;
    //int edadd;
    //int valor = 1;
    DateTime? picke = await showDatePicker(
        context: _context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1700),
        lastDate: DateTime(2032));

    //fechaActual = DateTime.now();
    if (picke != null) {
      setState(() {
        _controllerFecha.text = picke.toString().substring(0, 10);
      });
    }
  }
}
