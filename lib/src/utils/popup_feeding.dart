import 'package:flutter/material.dart';

class InfoFeeding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Alimentacion.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class InfoExcercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Ejercicio.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class InfoHope extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Esperanza.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class InfoWater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Agua.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class InfoDream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Descanso.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class InfoSun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Luz Solar.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class InfoAire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Información Adicional',
        style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500), // Tamaño de la fuente del título
      ),
      content: SingleChildScrollView(
        child: Text(
          'Informacion de Aire Puro.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cerrar',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}