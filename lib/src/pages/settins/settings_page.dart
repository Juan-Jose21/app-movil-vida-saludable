import 'package:app_vida_saludable/src/controllers/settins_controller.dart';
import 'package:app_vida_saludable/src/pages/settins/notifications.dart';
import 'package:app_vida_saludable/src/pages/settins/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsController con = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _bgSettings(),
          _datos(context),
          _textOne(context),
          _contentPerfil(context),
          _contentNotificacion(context),
          _textServicioCliente(context),
          _contentSugerencias(context),
          _textPoliticas(context),
          _contentPolitica(context),
          _contentVersion(context),
          _lineaSeparador(context),
          _bottomCerrarSesion(context)
        ],
      ),
    );
  }
  Widget _bgSettings() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.indigo,
        // borderRadius: BorderRadius.only(
        //   bottomRight: Radius.circular(90),
        // ),
      ),
    );
  }

  Widget _datos(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.1),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/profile.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${con.user.nombre}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'VIDA SALUDABLE',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _textOne(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Text(
              'General',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.black, // Color de la línea
          ),
        ],
      ),
    );
  }

  Widget _contentPerfil(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29, left: 14, right: 14),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.account_box,
            size: 30,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Text(
            'Perfil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Icon(
              Icons.navigate_next_rounded,
              size: 40,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget _contentNotificacion(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.36, left: 14, right: 14),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Text(
            'Notificación',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
            child: Icon(
              Icons.navigate_next_rounded,
              size: 40,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textServicioCliente(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Text(
              'Servicio al Cliente',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.black, // Color de la línea
          ),
        ],
      ),
    );
  }

  Widget _contentSugerencias(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.51, left: 14, right: 14),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.insert_comment_rounded,
            size: 30,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Text(
            'Sugerencias',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(
            Icons.navigate_next_rounded,
            size: 40,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _textPoliticas(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.59),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Text(
              'Políticas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.black, // Color de la línea
          ),
        ],
      ),
    );
  }

  Widget _contentPolitica(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.66, left: 14, right: 14),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.text_snippet,
            size: 30,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Text(
            'Política de Privacidad',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(
            Icons.navigate_next_rounded,
            size: 40,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _contentVersion(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.73, left: 14, right: 14),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.perm_device_info_outlined,
            size: 30,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Text(
            'Versión',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(
            Icons.navigate_next_rounded,
            size: 40,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _lineaSeparador(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.815),
      height: 1.0,
      width: double.infinity,
      color: Colors.black,
    );
  }


  Widget _bottomCerrarSesion(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.83, left: 14),
      width: 115,
      child: ElevatedButton(
        onPressed: () {
          con.signOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Salir',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }







}