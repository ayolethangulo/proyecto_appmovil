import 'package:flutter/material.dart';
import '../modelo/modelos.dart';

class AdicionarEmpleado extends StatefulWidget {
  AdicionarEmpleado({Key? key}) : super(key: key);

  @override
  State<AdicionarEmpleado> createState() => _AdicionarEmpleadoState();
}

class _AdicionarEmpleadoState extends State<AdicionarEmpleado> {
  List<Empleado> _empleadoadd = [];

  late TextEditingController controladorfoto;
  late TextEditingController controladornombre;
  late TextEditingController controladorapellido;
  late TextEditingController controladorprofesion;
  late TextEditingController controladorfecha;
  late TextEditingController controladoredad;

  @override
  void initState() {
    controladorfoto = TextEditingController();
    controladornombre = TextEditingController();
    controladorapellido = TextEditingController();
    controladorprofesion = TextEditingController();
    controladorfecha = TextEditingController();
    controladoredad = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Adicionar un Empleado'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: controladorfoto,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Foto (url)',
                  // suffix: Icon(Icons.access_alarm),
                  suffix: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      controladorfoto.clear();
                    },
                  )
                  //probar suffix
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: controladornombre,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nombres',
                  // suffix: Icon(Icons.access_alarm),
                  suffix: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      controladornombre.clear();
                    },
                  )
                  //probar suffix
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: controladorapellido,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Apellidos',
                  // suffix: Icon(Icons.access_alarm),
                  suffix: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      controladorapellido.clear();
                    },
                  )
                  //probar suffix
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: controladorprofesion,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Profesion',
                  // suffix: Icon(Icons.access_alarm),
                  suffix: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      controladorprofesion.clear();
                    },
                  )
                  //probar suffix
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              enableInteractiveSelection: false,
              controller: controladorfecha,
              decoration: InputDecoration(
                  hintText: 'Seleccione fecha de nacimiento',
                  labelText: 'Fecha de Nacimiento',
                  suffixIcon: Icon(Icons.perm_contact_calendar),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  icon: Icon(Icons.calendar_today)),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                CallDatePicker(context, controladorfecha);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              enabled: true,
              controller: controladoredad,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Edad',
                  // suffix: Icon(Icons.access_alarm),
                  suffix: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      controladoredad.clear();
                    },
                  )
                  //probar suffix
                  ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (controladorfoto.text.isNotEmpty &&
                    controladornombre.text.isNotEmpty &&
                    controladorapellido.text.isNotEmpty &&
                    controladorprofesion.text.isNotEmpty &&
                    controladoredad.text.isNotEmpty) {
                  _empleadoadd.add(Empleado(
                      foto: controladorfoto.text,
                      nombre: controladornombre.text,
                      apellido: controladorapellido.text,
                      profesion: controladorprofesion.text,
                      edad: controladoredad.text));
                  Navigator.pop(context, _empleadoadd);
                }
              },
              child: Text('Guardar Empleado'))
        ],
      ),
    ));
  }

  CalcularEdad(DateTime fecha, DateTime seleccionado,
      TextEditingController _controller) {
    if (fecha.month < seleccionado.month) {
      int edad = int.parse((fecha.year - seleccionado.year).toString());
      _controller.text = (edad - 1).toString();
    } else if (fecha.month >= seleccionado.month) {
      _controller.text = (fecha.year - seleccionado.year).toString();
    }
  }

  CallDatePicker(
      BuildContext _context, TextEditingController _controler) async {
    DateTime ActualFecha = DateTime.now();
    DateTime? fecha = await showDatePicker(
        context: _context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1700),
        lastDate: DateTime(2032));
    if (fecha != null) {
      setState(() {
        _controler.text = fecha.toString().substring(0, 10);
        CalcularEdad(ActualFecha, fecha, controladoredad);
      });
    }
  }
}
