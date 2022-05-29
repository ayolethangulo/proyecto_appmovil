import 'package:flutter/material.dart';

import '../modelo/modelos.dart';

class ModificarEmpleado extends StatefulWidget {
  final Empleado _empleado;
  ModificarEmpleado(this._empleado);
  @override
  State<ModificarEmpleado> createState() => _ModificarEmpleadoState();
}

class _ModificarEmpleadoState extends State<ModificarEmpleado> {
  List<Empleado> _empleadoadd = [];

  late TextEditingController controladorfoto;
  late TextEditingController controladornombre;
  late TextEditingController controladorapellido;
  late TextEditingController controladorprofesion;
  late TextEditingController controladorfecha;
  late TextEditingController controladoredad;

  @override
  void initState() {
    Empleado empleado = widget._empleado;
    controladorfoto = TextEditingController(text: empleado.foto);
    controladornombre = TextEditingController(text: empleado.nombre);
    controladorapellido = TextEditingController(text: empleado.apellido);
    controladorprofesion = TextEditingController(text: empleado.profesion);
    controladorfecha = TextEditingController(text: empleado.fechaDeNacimiento);
    controladoredad = TextEditingController(text: empleado.edad);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Modificar un Empleado'),
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
              controller: controladorfecha,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Fecha de nacimiento',
                  // suffix: Icon(Icons.access_alarm),
                  suffix: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      controladorfecha.clear();
                    },
                  )
                  //probar suffix
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
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
}
