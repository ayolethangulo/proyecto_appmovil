import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PeticionesPersona {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore baseDatos = FirebaseFirestore.instance;

  static Future<void> crearPersona(Map<String, dynamic> persona, foto,
      nombrecoleccion, nombrecarpetaFotos) async {
    print(persona['foto']);

    var url = '';
    if (foto != null)
      url = await PeticionesPersona._loadPhoto(
          foto, persona['id_user'], nombrecarpetaFotos);
    print(url);

    persona['foto'] = url.toString();
    await baseDatos
        .collection(nombrecoleccion)
        .doc(persona['id_user'])
        .set(persona)
        .catchError((e) {
      print(e);
    });
  }

  static Future<dynamic> _loadPhoto(
      var foto, var idFoto, var carpetaImage) async {
    final fs.Reference storageRef =
        fs.FirebaseStorage.instance.ref().child(carpetaImage);

    fs.TaskSnapshot taskSnapshot;
    taskSnapshot = await storageRef.child(idFoto).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('URL: ' + url.toString());
    return url.toString();
  }

  static Future<void> actualizarPersona(
      String id, foto, Map<String, dynamic> persona) async {
    print(persona['foto']);

    var url = '';
    if (foto != null)
      url = await PeticionesPersona._loadPhoto(
          foto, persona['id_user'], 'perfilPersonas');
    print(url);

    persona['foto'] = url.toString();
    await baseDatos
        .collection('Personas')
        .doc(id)
        .update(persona)
        .catchError((e) {
      print(e);
    });
    //return true;
  }
}
