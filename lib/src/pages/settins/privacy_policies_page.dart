import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Política de Privacidad - VIDA SALUDABLE'),
            _buildSectionContent('Bienvenido a VIDA SALUDABLE. Valoramos tu privacidad y nos comprometemos a proteger tus datos personales. Esta política de privacidad describe cómo recopilamos, usamos y protegemos tu información.'),
            
            _buildSectionTitle('1. Información que Recopilamos'),
            _buildBulletPoint('Datos personales: Nombre, edad, sexo, correo electrónico, número de teléfono.'),
            _buildBulletPoint('Datos biométricos: Peso, talla, masa muscular, índice de masa corporal (IMC).'),
            _buildSectionContent('Estos datos son obtenidos y verificados por profesionales de la salud de la Universidad Adventista de Bolivia (UAB), garantizando su precisión y validez.'),
            _buildBulletPoint('Hábitos de vida: Alimentación, ejercicio, sueño, hidratación, aire puro, luz solar y bienestar espiritual.'),
            _buildSectionContent('Estos hábitos están basados en los principios de los 8 remedios naturales, una propuesta de la Iglesia Adventista para lograr un bienestar integral.'),
            
            _buildSectionTitle('Sobre los 8 Remedios Naturales'),
            _buildBulletPoint('Alimentación saludable: Basada en una dieta equilibrada con énfasis en alimentos naturales y nutritivos.'),
            _buildBulletPoint('Ejercicio físico: Actividad regular para fortalecer el cuerpo y la mente.'),
            _buildBulletPoint('Agua (hidratación): Importancia del consumo adecuado de agua pura.'),
            _buildBulletPoint('Luz solar: Beneficios de la exposición adecuada al sol para la producción de vitamina D y bienestar general.'),
            _buildBulletPoint('Aire puro: Necesidad de respirar aire fresco y oxigenar correctamente el cuerpo.'),
            _buildBulletPoint('Descanso (sueño): Horas de sueño adecuadas para la recuperación del organismo.'),
            _buildBulletPoint('Moderación (temperancia): Equilibrio en el estilo de vida evitando excesos.'),
            _buildBulletPoint('Confianza en Dios (bienestar espiritual): La fe y la espiritualidad como factores clave en la salud emocional y mental.'),
            
            _buildSectionTitle('2. Cómo Usamos la Información'),
            _buildSectionTitle('2.1 Evaluación de Salud y Prevención de Enfermedades'),
            _buildSectionContent('La evaluación de salud dentro de VIDA SALUDABLE es realizada exclusivamente por profesionales en el área de la salud de la Universidad Adventista de Bolivia (UAB), quienes analizan los datos biométricos recopilados para proporcionar un diagnóstico general del estado de salud del usuario.'),
            
            _buildSectionTitle('2.2 Seguimiento Personalizado y Provisión de Información sobre los 8 Remedios Naturales'),
            _buildSectionContent('El seguimiento personalizado es supervisado por los responsables del programa VIDA SALUDABLE, quienes son profesionales en el área de la salud, nutrición, educación física y bienestar integral. El uso del aplicativo está restringido a usuarios registrados en el dicho programa.'),
            _buildSectionContent('En este seguimiento, no solo se evalúa el progreso del usuario, sino que también se proporciona información detallada y validada por los profesionales de la UAB sobre los 8 remedios naturales. Estos datos no son generados ni proporcionados a través del aplicativo, sino de manera personal.'),
            _buildSectionContent('Esta información abarca su impacto en la salud, su aplicación práctica en la vida diaria y evidencia científica que respalda sus beneficios.'),
            _buildSectionContent('Los profesionales de la UAB validan cada recomendación, asegurando que la información proporcionada sea confiable y alineada con principios de salud integrativa.'),
            _buildBulletPoint('Investigación y estudios académicos de manera anónima.'),
            _buildBulletPoint('Mejoras en la aplicación y experiencia del usuario.'),
            
            _buildSectionTitle('3. Compartición de Datos'),
            _buildBulletPoint('No compartimos información personal sin tu consentimiento.'),
            _buildBulletPoint('Los datos anónimos pueden ser utilizados en investigaciones académicas.'),
            _buildBulletPoint('Nuestros proveedores de servicios tienen la obligación de mantener la confidencialidad de los datos.'),
            
            _buildSectionTitle('4. Protección de Datos'),
            _buildBulletPoint('Cifrado de datos en contraseñas y acceso restringido a la información personal.'),
            _buildBulletPoint('Anonimización de datos para garantizar la privacidad en estudios e investigaciones.'),
            
            _buildSectionTitle('5. Derechos del Usuario'),
            _buildBulletPoint('Acceder, rectificar o eliminar tus datos personales.'),
            _buildBulletPoint('Revocar tu consentimiento en cualquier momento.'),
            
            _buildSectionTitle('6. Conservación de Datos'),
            _buildSectionContent('Tus datos serán almacenados solo durante el tiempo necesario para cumplir con los fines mencionados en esta política.'),
            
            _buildSectionTitle('7. Cambios en la Política de Privacidad'),
            _buildSectionContent('Nos reservamos el derecho de actualizar esta política en cualquier momento. Te notificaremos si realizamos cambios significativos.'),
            
            _buildSectionTitle('8. Contacto'),
            _buildSectionContent('Si tienes preguntas o inquietudes sobre esta Política de Privacidad, puedes contactarnos a través de:'),
            _buildSectionContent('📧 Correo electrónico: vida.saludable@uab.edu.bo'),
            _buildSectionContent('📍 Dirección: Av. Pairumani - Universidad Adventista de Bolivia'),
            
            _buildSectionContent('Para más información de la Universidad Adventista de Bolivia visítanos: '),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse('https://www.uab.edu.bo'));
              },
              child: Text(
                'www.uab.edu.bo',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
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
