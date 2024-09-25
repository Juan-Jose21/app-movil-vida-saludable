import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:app_vida_saludable/src/models/user.dart';
import 'package:get_storage/get_storage.dart';

class InformationsController extends GetxController {

  User user = User.fronJson(GetStorage().read('User') ?? {});

  InfromationsController() {
    print('USUARIO DE SESSION: ${user.toJson()}');
  }

  void showDevelopmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Aviso',
            style: TextStyle(
              color: Colors.red, // Color del título
            ),
          ),
          content: Text(
            'Esta funcionalidad está en desarrollo',
            style: TextStyle(
              color: Colors.black, // Color del contenido
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
