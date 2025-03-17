import 'package:flutter/material.dart';

class PrivacyPoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Política de Privacidad',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => {
            Navigator.of(context).pop()
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Última actualización: 04-02-2025'),
            _buildSectionContent(
                'Bienvenido a VIDA SALUDABLE. Valoramos tu privacidad y nos comprometemos a proteger tus datos personales.'),
            
            _buildSectionTitle('1. Información que Recopilamos'),
            _buildBulletPoint('Datos personales: Nombre, edad, sexo, correo electrónico, número de teléfono.'),
            _buildBulletPoint('Datos biométricos: Peso, talla, masa muscular, índice de masa corporal (IMC).'),
            _buildBulletPoint('Hábitos de vida: Alimentación, ejercicio, sueño, agua, aire puro, luz solar, bienestar espiritual.'),
            
            _buildSectionTitle('2. Cómo Usamos la Información'),
            _buildBulletPoint('Evaluación de salud y prevención de enfermedades.'),
            _buildBulletPoint('Seguimiento personalizado y recomendaciones de hábitos saludables.'),
            _buildBulletPoint('Investigación y estudios académicos de manera anónima.'),
            _buildBulletPoint('Mejoras en la aplicación y experiencia del usuario.'),
            
            _buildSectionTitle('3. Compartición de Datos'),
            _buildBulletPoint('No compartimos información personal sin consentimiento.'),
            _buildBulletPoint('Datos anónimos pueden ser usados en estudios académicos.'),
            _buildBulletPoint('Proveedores de servicio deben mantener confidencialidad de los datos.'),
            
            _buildSectionTitle('4. Protección de Datos'),
            _buildBulletPoint('Cifrado de datos en las contraseñas y acceso restringido a información personal.'),
            _buildBulletPoint('Anonimización de datos para estudios e investigaciones.'),
            
            _buildSectionTitle('5. Derechos del Usuario'),
            _buildBulletPoint('Acceder, rectificar o eliminar datos personales.'),
            _buildBulletPoint('Revocar consentimiento en cualquier momento.'),
            
            _buildSectionTitle('6. Conservación de Datos'),
            _buildSectionContent('Tus datos serán almacenados mientras sea necesario para los fines mencionados en esta política.'),
            
            _buildSectionTitle('7. Cambios en la Política de Privacidad'),
            _buildSectionContent('Nos reservamos el derecho de actualizar esta política en cualquier momento. Te notificaremos sobre cambios importantes.'),
            
            _buildSectionTitle('8. Contacto'),
            _buildSectionContent('Si tienes preguntas o inquietudes sobre esta Política de Privacidad, puedes contactarnos a través de:'),
            _buildSectionContent('📧 Correo electrónico: vida.saludable@uab.edu.bo'),
            _buildSectionContent('📍 Dirección: Av. Pairumani - Universidad Adventista de Bolivia'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
